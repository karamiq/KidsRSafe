import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class ThumbnailStrip extends HookWidget {
  final List<File> images;
  final int selectedIndex;
  final ValueChanged<int> onThumbnailSelected;
  final ScrollController controller;

  const ThumbnailStrip({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onThumbnailSelected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final thumbnailKeys = useMemoized(() {
      return List.generate(images.length, (index) => GlobalKey());
    }, [images.length]);

    useEffect(() {
      if (controller.hasClients && selectedIndex < images.length) {
        final selectedContext = thumbnailKeys[selectedIndex].currentContext;
        final renderBox = selectedContext?.findRenderObject() as RenderBox?;
        final listViewContext = context.findRenderObject() as RenderBox?;

        if (renderBox != null && listViewContext != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final listViewPosition = listViewContext.localToGlobal(Offset.zero);
          final relativePosition = position.dx - listViewPosition.dx;

          final centerPosition = listViewContext.size.width / 2 - renderBox.size.width / 2;
          final scrollOffset = relativePosition - centerPosition;
          final targetScroll =
              (controller.offset + scrollOffset).clamp(0.0, controller.position.maxScrollExtent);

          controller.animateTo(targetScroll,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        }
      }
      return null;
    }, [selectedIndex]);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return AnimatedContainer(
            key: thumbnailKeys[index],
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onThumbnailSelected(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.outline.withOpacity(0.2),
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    images[index],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: context.colorScheme.surfaceContainerLowest,
                        child: Icon(Icons.broken_image, color: context.colorScheme.onSurfaceVariant),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
