import 'package:flutter/material.dart';
import 'package:app/core/utils/constants/sizes.dart';

class VideoControls extends StatelessWidget {
  final int position;
  final Duration duration;
  final Function(Duration) onSeek;
  final VoidCallback onDragStart;
  final Function(double) onDragEnd;

  const VideoControls({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
    required this.onDragStart,
    required this.onDragEnd,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            color: Colors.transparent,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Insets.small,
                      vertical: Insets.extraSmall,
                    ),
                    child: Text(
                      '${_formatDuration(Duration(seconds: position))} / ${_formatDuration(duration)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Slider(
                    value: position.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      onSeek(Duration(seconds: value.toInt()));
                    },
                    onChangeStart: (_) => onDragStart(),
                    onChangeEnd: onDragEnd,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
