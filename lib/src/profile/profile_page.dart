import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/data/models/user_model.dart';
import 'components/profile_header.dart';
import 'components/profile_stats.dart';
import 'components/profile_action_button.dart';

class ProfilePage extends ConsumerWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider(userId));
    return userAsync.when(
      data: (user) => user == null
          ? const Scaffold(body: Center(child: Text('User not found')))
          : _ProfileScaffold(user: user),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
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
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(user: user),
            ProfileStats(),
            const SizedBox(height: 12),
            if (isOwnProfile)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(context).colorScheme.onError,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        onPressed: () async {
                          await ref.read(userProvider.notifier).logout();
                        },
                      ),
                    ),
                  ],
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
