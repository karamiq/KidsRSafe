import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/src/add/components/video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPage extends HookWidget {
  final File video;

  const VideoPreviewPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final videoController = useMemoized(() => VideoPlayerController.file(video), [video]);
    final isInitialized = useState<bool>(false);
    final isPlaying = useState<bool>(false);
    final currentPosition = useState<Duration>(Duration.zero);
    final totalDuration = useState<Duration>(Duration.zero);

    useEffect(() {
      videoController.initialize().then((_) {
        isInitialized.value = true;
        totalDuration.value = videoController.value.duration;
      });
      return () => videoController.dispose();
    }, [videoController]);

    useEffect(() {
      if (isInitialized.value) {
        videoController.addListener(() => currentPosition.value = videoController.value.position);
      }
      return null;
    }, [isInitialized.value]);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Video Preview'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: isInitialized.value
                      ? AspectRatio(
                          aspectRatio: videoController.value.aspectRatio, child: VideoPlayer(videoController))
                      : const Center(child: CircularProgressIndicator(color: Colors.white)),
                ),
                if (isInitialized.value)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        if (isPlaying.value) {
                          videoController.pause();
                        } else {
                          videoController.play();
                        }
                        isPlaying.value = !isPlaying.value;
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: isPlaying.value ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(isPlaying.value ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white, size: 48),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isInitialized.value)
            VideoProgressBar(
              controller: videoController,
              currentPosition: currentPosition.value,
              totalDuration: totalDuration.value,
              onPlayPause: () {
                if (isPlaying.value) {
                  videoController.pause();
                } else {
                  videoController.play();
                }
                isPlaying.value = !isPlaying.value;
              },
              isPlaying: isPlaying.value,
            ),
        ],
      ),
    );
  }
}
