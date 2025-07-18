import 'package:app/common_lib.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/core/services/local_notifications_services.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _requestPermission();
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler();
    _setupTokenRefreshHandler();
    await _uploadTokenToFirestore();
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationsServices.showNotification(message);
    });
  }

  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _setupTokenRefreshHandler() {
    _messaging.onTokenRefresh.listen((String token) async {
      await _uploadTokenToFirestore(token: token);
    });
  }

  Future<void> _uploadTokenToFirestore({String? token}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final fcmToken = token ?? await _messaging.getToken();
    if (fcmToken == null) return;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      final data = snapshot.data() ?? {};
      final tokens = List<String>.from(data['fcmTokens'] ?? []);
      if (!tokens.contains(fcmToken)) {
        tokens.add(fcmToken);
        transaction.update(userDoc, {'fcmTokens': tokens});
      }
    });
  }

  Future<String?> getToken() async {
    final token = await _messaging.getToken();
    await _uploadTokenToFirestore(token: token);
    return token;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await LocalNotificationsServices.showNotification(message);
}
