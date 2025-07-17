import 'package:app/common_lib.dart';
import 'package:app/data/models/chat_model.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/models/message_model.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final ChatModel chat;
  const ChatDetailPage({super.key, required this.chat});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollToBottom = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _showScrollToBottom.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final threshold = 20.0;
    final atBottom = _scrollController.offset <= threshold;
    if (_showScrollToBottom.value != !atBottom) {
      _showScrollToBottom.value = !atBottom;
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(UserModel? currentUser, dynamic chatsRepository) async {
    final text = _controller.text.trim();
    if (text.isEmpty || currentUser == null) return;
    await chatsRepository.sendMessage(
      chatId: widget.chat.uid,
      senderId: currentUser.uid,
      text: text,
    );
    _controller.clear();
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    final chatsRepository = ref.watch(chatsRepositoryProvider);
    final oppositeUser = widget.chat.oppositeUser;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(oppositeUser.profilePicture),
              child: ((oppositeUser.profilePicture.isEmpty)) ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 12),
            Text(oppositeUser.name),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: chatsRepository.fetchMessagesForChat(widget.chat.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: \n${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final messages = snapshot.data ?? [];
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                    if (messages.isEmpty) {
                      return const Center(child: Text('No messages yet.'));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isMe = msg.senderUid == currentUser?.uid;
                        return Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? Theme.of(context).colorScheme.primary.withOpacity(0.85)
                                  : Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(16).copyWith(
                                bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                                bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg.text,
                                  style: TextStyle(
                                    color: isMe
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    msg.timestamp.formatTimeago(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 11, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(borderRadius: BorderSize.smallRadius),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                          onSubmitted: (_) => _sendMessage(currentUser, chatsRepository),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => _sendMessage(currentUser, chatsRepository),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Replace the FAB logic with ValueListenableBuilder
          Positioned(
            bottom: 80,
            left: 16,
            child: ValueListenableBuilder<bool>(
              valueListenable: _showScrollToBottom,
              builder: (context, show, child) {
                if (!show) return const SizedBox.shrink();
                return FloatingActionButton(
                  mini: true,
                  onPressed: _scrollToBottom,
                  child: const Icon(Icons.arrow_downward),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
