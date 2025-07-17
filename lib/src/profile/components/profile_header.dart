import 'package:flutter/material.dart';
import 'package:app/data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 44,
            backgroundImage: user.profilePicture.isNotEmpty ? NetworkImage(user.profilePicture) : null,
            child: user.profilePicture.isEmpty
                ? Icon(Icons.account_circle, size: 80, color: Theme.of(context).colorScheme.primary)
                : null,
          ),
          const SizedBox(width: 24),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('@${user.username}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ],
          )), // Placeholder for stats or other content
        ],
      ),
    );
  }
}
