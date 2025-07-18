/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { setGlobalOptions } from "firebase-functions";
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions/v1";
import * as admin from "firebase-admin";

admin.initializeApp();
setGlobalOptions({ maxInstances: 10 });

/**
 * Cloud Function: notifyChatMessage
 * Triggered when a new message is created in chats/{chatUid}/messages/{messageUid}.
 * Sends a push notification to all chat participants (from RepoChatModel) except the sender.
 * Also logs the notification state in the 'stats' collection.
 * Supports multiple devices per user (fcmTokens array).
 */
export const notifyChatMessage = functions
    .region('eur3')
    .firestore
    .document("chats/{chatUid}/messages/{messageUid}")
    .onCreate(async (snap, context) => {
        // Get the new message data
        const message = snap.data();
        if (!message) return;

        const chatUid = context.params.chatUid;
        const senderUid = message.senderUid;

        // Fetch the chat document (RepoChatModel) to get the participants
        const chatDoc = await admin
            .firestore()
            .collection("chats")
            .doc(chatUid)
            .get();
        if (!chatDoc.exists) return;
        const chatData = chatDoc.data();
        if (!chatData || !Array.isArray(chatData.participants)) return;

        // Notify all participants except the sender
        const recipientUids = chatData.participants.filter(
            (uid) => uid !== senderUid
        );

        // For each recipient, fetch their FCM tokens and send a notification
        for (const recipientUid of recipientUids) {
            const userDoc = await admin
                .firestore()
                .collection("users")
                .doc(recipientUid)
                .get();
            const userData = userDoc.data();
            const fcmTokens = Array.isArray(userData?.fcmTokens) ? userData.fcmTokens : [];
            if (!fcmTokens.length) continue;

            // Prepare the notification payload
            const payload = {
                notification: {
                    title: "New Message",
                    body: message.text || "You have a new message",
                },
                data: {
                    "chatUid": chatUid,
                    "senderUid": senderUid,
                    messageId: message.uid,
                    type: "chat",
                    route: `/chat/${chatUid}`,
                },
            };

            // Send the push notification to all tokens and log the result in 'stats'
            for (const fcmToken of fcmTokens) {
                let status = 'success';
                let errorMsg = '';
                try {
                    await admin.messaging().sendToDevice(fcmToken, payload);
                    logger.info(
                        `Notification sent to user ${recipientUid} (token: ${fcmToken}) for chat ${chatUid}`
                    );
                } catch (error) {
                    status = 'error';
                    errorMsg = String(error);
                    logger.error(
                        `Failed to send notification to ${recipientUid} (token: ${fcmToken}): ${error}`
                    );
                }
                // Log the notification state in the 'stats' collection
                await admin.firestore().collection('stats').add({
                    recipientUid,
                    chatUid,
                    messageId: message.uid,
                    fcmToken,
                    status,
                    error: errorMsg,
                    timestamp: admin.firestore.FieldValue.serverTimestamp(),
                });
            }
        }
    });

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
