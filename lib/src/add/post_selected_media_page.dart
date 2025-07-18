import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostSelectedMediaPage extends HookConsumerWidget {
  const PostSelectedMediaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final List<File> media = args?['media'] ?? [];
    final PostType mediaType = args?['mediaType'] ?? PostType.photo;

    final titleController = useTextEditingController();
    final captionController = useTextEditingController();
    final isLoading = useState<bool>(false);
    final titleLength = useState<int>(0);
    final captionLength = useState<int>(0);

    useEffect(() {
      void titleListener() => titleLength.value = titleController.text.length;
      void captionListener() => captionLength.value = captionController.text.length;
      titleController.addListener(titleListener);
      captionController.addListener(captionListener);
      // Set initial values
      titleLength.value = titleController.text.length;
      captionLength.value = captionController.text.length;
      return () {
        titleController.removeListener(titleListener);
        captionController.removeListener(captionListener);
      };
    }, [titleController, captionController]);

    Future<void> submitPost() async {
      if (titleController.text.trim().isEmpty || captionController.text.trim().isEmpty || media.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields and select media'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      isLoading.value = true;

      try {
        final currentUser = ref.read(userProvider);
        if (currentUser == null) {
          throw Exception('User not authenticated');
        }

        final postRepository = ref.read(postRepositoryProvider);

        final result = await postRepository.submitPostForModeration(
          title: titleController.text.trim(),
          userId: currentUser.uid,
          type: mediaType,
          files: media,
          caption: captionController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        context.go(RoutesDocument.home);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit post: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: const Text('Create Post'),
        backgroundColor: context.colorScheme.surface,
        foregroundColor: context.colorScheme.onSurface,
        elevation: 0,
        actions: [
          if (isLoading.value)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: submitPost,
              child: const Text('Post'),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      mediaType == PostType.video ? Icons.video_library : Icons.photo_library,
                      color: context.colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mediaType == PostType.video ? 'Video Selected' : 'Images Selected',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${media.length} ${mediaType == PostType.video ? 'video' : 'image${media.length > 1 ? 's' : ''}'} ready to post',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Title',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60), // limit title to 60 characters
                ],
                decoration: InputDecoration(
                  hintText: 'Enter a title for your post...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerLowest,
                  counterText: '${titleLength.value}/60',
                ),
                style: context.textTheme.bodyLarge,
                maxLength: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Caption',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: captionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500), // limit caption to 500 characters
                ],
                decoration: InputDecoration(
                  hintText: 'Write a caption for your post...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerLowest,
                  counterText: '${captionLength.value}/500',
                ),
                style: context.textTheme.bodyLarge,
                maxLength: 500,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isLoading.value ? null : submitPost,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Submit Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
