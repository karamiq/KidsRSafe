import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/router/app_router.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.favorite,
        'title': 'New Like',
        'description': 'Alice liked your post.',
        'time': '2m',
      },
      {
        'icon': Icons.person_add,
        'title': 'New Follower',
        'description': 'Bob started following you.',
        'time': '10m',
      },
      {
        'icon': Icons.comment,
        'title': 'New Comment',
        'description': 'Charlie commented: "Nice!"',
        'time': '1h',
      },
      {
        'icon': Icons.notifications,
        'title': 'App Update',
        'description': 'Check out the new features in the app.',
        'time': '3h',
      },
    ];
    final int unreadChats = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Inbox'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                context.go(RoutesDocument.chats);
              },
              child: AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 120),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
                    ),
                    if (unreadChats > 0)
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Text(
                            unreadChats.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notifications',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(indent: 80, endIndent: 16, height: 0),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Icon(notif['icon'] as IconData,
                        color: Theme.of(context).colorScheme.primary, size: 28),
                  ),
                  title: Text(notif['title'] as String, style: Theme.of(context).textTheme.titleMedium),
                  subtitle:
                      Text(notif['description'] as String, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text(notif['time'] as String,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
