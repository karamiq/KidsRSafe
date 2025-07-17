import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  final Duration currentPosition;
  final Duration totalDuration;
  final VoidCallback onPlayPause;
  final bool isPlaying;

  const VideoProgressBar({
    super.key,
    required this.controller,
    required this.currentPosition,
    required this.totalDuration,
    required this.onPlayPause,
    required this.isPlaying,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatDuration(currentPosition),
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              Text(formatDuration(totalDuration),
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayColor: Colors.white.withOpacity(0.2),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
            ),
            child: Slider(
              value: currentPosition.inMilliseconds.toDouble(),
              min: 0,
              max: totalDuration.inMilliseconds.toDouble(),
              onChanged: (value) => controller.seekTo(Duration(milliseconds: value.toInt())),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => controller.seekTo((currentPosition - const Duration(seconds: 10)).isNegative
                    ? Duration.zero
                    : currentPosition - const Duration(seconds: 10)),
                icon: const Icon(Icons.replay_10, color: Colors.white, size: 28),
              ),
              IconButton(
                onPressed: onPlayPause,
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 32),
              ),
              IconButton(
                onPressed: () => controller.seekTo(
                    (currentPosition + const Duration(seconds: 10)) > totalDuration
                        ? totalDuration
                        : currentPosition + const Duration(seconds: 10)),
                icon: const Icon(Icons.forward_10, color: Colors.white, size: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
