import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:app/data/models/chat_model.dart';
import '../components/chat_list_tile.dart';

class ChatListView extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatListView({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    if (chats.isEmpty) {
      return const Center(child: Text('No chats yet.'));
    }
    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (_, __) => Divider(
        color: colorScheme.outline,
        height: 1,
        endIndent: Insets.medium,
        indent: Insets.medium,
      ),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListTile(
          chat: chat,
          onTap: () {
            context.push(extra: chat, RoutesDocument.chatDetail(chat.uid));
          },
        );
      },
    );
  }
}
