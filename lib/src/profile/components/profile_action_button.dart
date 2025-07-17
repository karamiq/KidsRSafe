import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:app/router/app_router.dart';

class ProfileActionButton extends ConsumerWidget {
  final UserModel user;
  const ProfileActionButton({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final chatsRepository = ref.watch(chatsRepositoryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          child: Text('Contanct'),
          onPressed: () async {
            if (currentUser == null) return;
            final chat = await chatsRepository.createOrGetChat(
              userId1: currentUser.uid,
              userId2: user.uid,
            );
            if (context.mounted) {
              context.push(extra: chat, RoutesDocument.chatDetail(chat.uid));
            }
          },
        ),
      ),
    );
  }
}
