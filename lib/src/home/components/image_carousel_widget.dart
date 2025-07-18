import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/core/utils/constants/sizes.dart';

class ImageCarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final VoidCallback? onTap;

  const ImageCarouselWidget({
    super.key,
    required this.imageUrls,
    this.onTap,
  });

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.imageUrls[index],
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
        if (widget.imageUrls.length > 1) _buildPageIndicator(),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: Insets.medium,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageUrls.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: Insets.extraSmall),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == index ? Colors.white : Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
