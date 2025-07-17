import 'package:flutter/material.dart';
import 'package:app/data/models/chat_model.dart';

class ChatListTile extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback? onTap;
  const ChatListTile({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final otherUser = chat.oppositeUser;
    final lastMessageTime = chat.lastMessageTime;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(otherUser.profilePicture),
      ),
      title: Text(otherUser.name),
      subtitle: Text(chat.lastMessage),
      trailing: lastMessageTime != null
          ? Text(
              TimeOfDay.fromDateTime(lastMessageTime).format(context),
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      onTap: onTap,
    );
  }
}
