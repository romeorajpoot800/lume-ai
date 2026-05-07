import 'package:flutter/material.dart';

class PlayerBar extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const PlayerBar({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD9E7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.music_note, size: 30, color: Colors.deepPurple),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),

          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 36,
              color: Colors.deepPurple,
            ),
            onPressed: onPlayPause,
          ),
        ],
      ),
    );
  }
}
