import 'package:flutter/material.dart';

import '../../common_lib.dart';

class MediaSelectingCard extends StatelessWidget {
  const MediaSelectingCard(
      {super.key, required this.title, required this.suptitle, required this.icon, required this.onTap});
  final String title;
  final String suptitle;
  final IconData icon;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderSize.smallRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderSize.smallRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
          ),
          child: Padding(
            padding: Insets.smallAll,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  radius: 26,
                  child: Icon(icon, size: 40, color: Theme.of(context).colorScheme.secondary)),
              title: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                suptitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
