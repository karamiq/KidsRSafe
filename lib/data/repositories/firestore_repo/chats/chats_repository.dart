import 'package:app/data/models/chat_model.dart';
import 'package:app/data/repositories/firestore_repo/chats/models/repo_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import '../../../providers/firebase_provider.dart';
import '../../../models/message_model.dart';

typedef JsonMap = Map<String, dynamic>;

class ChatsRepository {
  final Ref ref;
  ChatsRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  CollectionReference<JsonMap> get _chats => firestore.collection('chats');

  /// Create a chat between two users, or get the existing chat's ChatModel
  Future<ChatModel> createOrGetChat({required String userId1, required String userId2}) async {
    final participants = [userId1, userId2]..sort();
    final uid = _chats.doc().id;
    final query = await _chats.where('participants', isEqualTo: participants).limit(1).get();
    String chatId;
    if (query.docs.isNotEmpty) {
      chatId = query.docs.first.id;
    } else {
      await _chats.doc(uid).set(RepoChatModel(
            participants: participants,
            uid: uid,
            lastMessage: '',
            lastMessageTime: DateTime.now(),
          ).toJson());
      chatId = uid;
    }
    // Fetch the chat document and build ChatModel
    final chatDoc = await _chats.doc(chatId).get();
    final repoChat = RepoChatModel.fromJson(chatDoc.data()!);
    final userRepo = ref.read(userRepositoryProvider);
    final oppositeUserId = participants.firstWhere((id) => id != userId1, orElse: () => '');
    final oppositeUser = await userRepo.getUser(oppositeUserId);
    return ChatModel(
      uid: repoChat.uid,
      oppositeUser: oppositeUser!,
      lastMessage: repoChat.lastMessage,
      lastMessageTime: repoChat.lastMessageTime ?? DateTime.now(),
    );
  }

  /// Stream all chats the user is participating in, ordered by last message time
  Stream<List<ChatModel>> fetchUserChats(String userId) {
    return _chats
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final repoChats = snapshot.docs.map((doc) {
        final data = doc.data();
        return RepoChatModel.fromJson(data);
      }).toList();
      // For each chat, fetch the opposite user
      final userRepo = ref.read(userRepositoryProvider);
      final List<ChatModel> chatModels = await Future.wait(repoChats.map((repoChat) async {
        // Find the opposite user
        final oppositeUserId = repoChat.participants.firstWhere((id) => id != userId, orElse: () => '');
        final oppositeUser = await userRepo.getUser(oppositeUserId);
        return ChatModel(
          uid: repoChat.uid,
          oppositeUser: oppositeUser!,
          lastMessage: repoChat.lastMessage,
          lastMessageTime: repoChat.lastMessageTime ?? DateTime.now(),
        );
      }));
      return chatModels;
    });
  }

// .orderBy('lastMessageTime', descending: true)
  /// Send a message in a chat and update chat metadata
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final msgRef = _chats.doc(chatId).collection('messages').doc();
    final message = MessageModel(
      uid: msgRef.id,
      senderUid: senderId,
      text: text,
      timestamp: DateTime.now(),
      readBy: [senderId],
    );
    final chatRef = _chats.doc(chatId);
    await firestore.runTransaction((transaction) async {
      transaction.set(msgRef, message.toJson());
      transaction.update(chatRef, {
        'lastMessage': text,
        'lastMessageTime': DateTime.now().toIso8601String(),
      });
    });
  }

  /// Stream all messages for a chat, ordered by timestamp
  Stream<List<MessageModel>> fetchMessagesForChat(String chatId) {
    return _chats
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = doc.data();
              return MessageModel.fromJson(data);
            })
            .whereType<MessageModel>()
            .toList());
  }
}
