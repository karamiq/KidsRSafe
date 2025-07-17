import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(Insets.medium),
        Center(
          child: Container(
            height: 5,
            width: context.width * 0.5,
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderSize.smallRadius),
          ),
        ),
        const Gap(Insets.small),
        Padding(
          padding: Insets.mediumAll,
          child: Text(
            'What woud you like to post ?',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(Insets.small),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium, vertical: Insets.large),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderSize.smallRadius,
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
          ),
          child: Column(
            children: [
              MediaTypeCard(
                title: 'Short video',
                suptitle: 'Share your video with the community',
                icon: Icons.video_call,
                onTap: () => context.push(RoutesDocument.videoSelecting),
              ),
              const Gap(Insets.medium),
              MediaTypeCard(
                title: 'Image',
                suptitle: 'Share your photo with the community',
                icon: Icons.photo_camera,
                onTap: () => context.push(RoutesDocument.imagesSelecting),
              ),
              const Gap(Insets.medium),
              const Gap(Insets.extraLarge * 2),
            ],
          ),
        )
      ],
    );
  }
}

class MediaTypeCard extends StatelessWidget {
  const MediaTypeCard(
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
            child: ClipRRect(
              borderRadius: BorderSize.smallRadius,
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
      ),
    );
  }
}
