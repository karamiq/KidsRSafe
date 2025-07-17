import 'package:app/common_lib.dart';
import 'package:app/data/models/chat_model.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/chat_list_view.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.read(userProvider)?.uid ?? '';
    final chatsRepository = ref.watch(chatsRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Users'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ChatModel>>(
        stream: chatsRepository.fetchUserChats(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chats yet.'));
          }
          final chats = snapshot.data!;
          return ChatListView(chats: chats);
        },
      ),
    );
  }
}
