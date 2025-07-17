import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'video_player_lib.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final VoidCallback? onTap;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.onTap,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with WidgetsBindingObserver {
  CachedVideoPlayerPlusController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isDragging = false;
  int _position = 0;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeVideo();
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _initializeVideo();
    }
    // if (oldWidget.status != widget.status) {
    //   _handleVisibilityChange();
    // }
  }

  void _initializeVideo() async {
    _disposeController();

    try {
      _controller = CachedVideoPlayerPlusController.network(widget.videoUrl);
      await _controller!.initialize();

      if (mounted && _controller != null) {
        setState(() {
          _isInitialized = true;
          _duration = _controller!.value.duration;
        });

        // Start playing immediately
        _playVideo();

        _controller!.setLooping(true);
        _controller!.addListener(_onVideoUpdate);
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      _disposeController();
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

  // void _handleVisibilityChange() {
  //   if (widget.status == PostStatus.approved) {
  //     _playVideo();
  //   } else {
  //     _pauseVideo();
  //   }
  // }

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

  void _disposeController() {
    if (_controller != null) {
      _controller!.removeListener(_onVideoUpdate);
      _controller!.pause();
      _controller!.dispose();
      _controller = null;
    }
    _isInitialized = false;
    _isPlaying = false;
    _position = 0;
    _duration = Duration.zero;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    super.dispose();
  }

  @override
  void deactivate() {
    if (_controller != null && _isInitialized) {
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (_controller != null && _isInitialized && _isPlaying) {
        _controller!.pause();
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _controller == null) {
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
      onTap: widget.onTap ?? _togglePlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CachedVideoPlayerPlus(_controller!),
            ),
          ),
          VideoControls(
            position: _position,
            duration: _duration,
            onSeek: _seekTo,
            onDragStart: () => setState(() => _isDragging = true),
            onDragEnd: (value) {
              _seekTo(Duration(seconds: value.toInt()));
              setState(() {
                _position = value.toInt();
                _isDragging = false;
              });
            },
          ),
          if (!_isPlaying) const PlayButton(),
        ],
      ),
    );
  }
}
