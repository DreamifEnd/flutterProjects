import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTopSwitchAudio;
  final VoidCallback onTopSwitchImage;

  const CountPanel({
    super.key,
    required this.count,
    required this.onTopSwitchAudio,
    required this.onTopSwitchImage,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(36, 36),
      padding: EdgeInsets.zero,
      backgroundColor: Colors.green,
      elevation: 2,
      iconColor: Colors.white,
    );

    return Stack(
      children: [
        Center(
          child: Text(
            "功德数： $count",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8,
            children: [
              ElevatedButton(
                style: style,
                onPressed: onTopSwitchAudio,
                child: const Icon(Icons.music_note_outlined),
              ),
              ElevatedButton(
                style: style,
                onPressed: onTopSwitchImage,
                child: const Icon(Icons.image),
              )
            ],
          ),
        )
      ],
    );
  }
}
