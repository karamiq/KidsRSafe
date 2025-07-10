import 'package:app/data/models/post_model.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app/core/utils/constants/sizes.dart';

class PostMediaView extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final bool isLiked;
  final bool isSaved;

  const PostMediaView({
    super.key,
    required this.post,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onShare,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  State<PostMediaView> createState() => _PostMediaViewState();
}

class _PostMediaViewState extends State<PostMediaView> {
  CachedVideoPlayerPlusController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isDragging = false;
  int _position = 0;
  Duration _duration = Duration.zero;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.post.type == PostType.video) {
      _initializeVideo();
    }
  }

  @override
  void didUpdateWidget(PostMediaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.post.type == PostType.video) {
      if (oldWidget.post.urls.first != widget.post.urls.first) {
        _disposeController();
        _initializeVideo();
      }
      if (oldWidget.post.status != widget.post.status) {
        _handleVisibilityChange();
      }
    }
  }

  void _initializeVideo() async {
    try {
      _controller = CachedVideoPlayerPlusController.network(widget.post.urls.first);

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _duration = _controller!.value.duration;
        });

        if (widget.post.status == PostStatus.approved) {
          _playVideo();
        }

        _controller!.setLooping(true);
        _controller!.addListener(_onVideoUpdate);
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  void _onVideoUpdate() {
    if (mounted && _controller != null && !_isDragging) {
      setState(() {
        _position = _controller!.value.position.inSeconds;
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  void _handleVisibilityChange() {
    if (widget.post.status == PostStatus.approved) {
      _playVideo();
    } else {
      _pauseVideo();
    }
  }

  void _playVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _pauseVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _pauseVideo();
    } else {
      _playVideo();
    }
  }

  void _seekTo(Duration position) {
    if (_controller != null && _isInitialized) {
      _controller!.seekTo(position);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _disposeController() {
    _controller?.removeListener(_onVideoUpdate);
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isPlaying = false;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Widget _buildVideoView() {
    if (!_isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        _togglePlayPause();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CachedVideoPlayerPlus(_controller!),
          ),
          if (widget.post.status == PostStatus.approved)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Insets.small, vertical: Insets.extraSmall),
                          child: Text(
                            '${_formatDuration(Duration(seconds: _position.toInt()))} / ${_formatDuration(_duration)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Slider(
                          value: _position.toDouble(),
                          max: _duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            _controller!.seekTo(Duration(seconds: value.toInt()));
                            _position = value.toInt();
                            setState(() {
                              _isDragging = false;
                            });
                          },
                          onChangeEnd: (value) {
                            _seekTo(Duration(seconds: value.toInt()));
                            _position = value.toInt();
                            setState(() {
                              _isDragging = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (!_isPlaying)
            Center(
              child: Container(
                padding: Insets.mediumAll,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          itemCount: widget.post.urls.length,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: widget.post.urls[index],
              fit: BoxFit.cover,
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
        if (widget.post.urls.length > 1)
          Positioned(
            top: Insets.medium,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.post.urls.length,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.post.type == PostType.video ? _buildVideoView() : _buildImageView(),
        if (widget.post.status == PostStatus.approved)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: Insets.medium,
            right: Insets.medium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.post.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: Insets.extraSmall),
                Text(
                  widget.post.caption,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: 0,
          right: 0,
          child: Container(
            padding: Insets.mediumAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(
                  icon: widget.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: widget.post.likes.toString(),
                  onTap: widget.onLike,
                  isActive: widget.isLiked,
                ),
                const SizedBox(height: Insets.medium),
                _buildActionButton(
                  icon: Icons.comment,
                  label: widget.post.comments.toString(),
                  onTap: widget.onComment,
                ),
                const SizedBox(height: Insets.medium),
                _buildActionButton(
                  icon: widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  label: widget.post.saves.toString(),
                  onTap: widget.onSave,
                  isActive: widget.isSaved,
                ),
                const SizedBox(height: Insets.medium),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: widget.onShare,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.red : Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: Insets.extraSmall),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
