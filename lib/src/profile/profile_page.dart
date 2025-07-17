import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/data/models/user_model.dart';
import 'components/profile_header.dart';
import 'components/profile_stats.dart';
import 'components/profile_action_button.dart';

class ProfilePage extends ConsumerWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (userId == null) {
      final user = ref.watch(userProvider);
      if (user == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return _ProfileScaffold(user: user);
    } else {
      final userAsync = ref.watch(userProfileProvider(userId!));
      return userAsync.when(
        data: (user) => user == null
            ? const Scaffold(body: Center(child: Text('User not found')))
            : _ProfileScaffold(user: user),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
      );
    }
  }
}

final userProfileProvider = FutureProvider.family<UserModel?, String>((ref, userId) async {
  final repo = ref.read(userRepositoryProvider);
  return await repo.getUser(userId);
});

class _ProfileScaffold extends ConsumerWidget {
  final UserModel user;
  const _ProfileScaffold({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final isOwnProfile = currentUser?.uid == user.uid;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          ProfileHeader(user: user),
          ProfileStats(),
          const SizedBox(height: 12),
          if (isOwnProfile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ),
            )
          else
            ProfileActionButton(user: user),
          const SizedBox(height: 16),
          Divider(),
          Expanded(
            child: Center(
              child: Text(
                'Profile content goes here',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
