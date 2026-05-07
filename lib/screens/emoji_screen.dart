import 'package:flutter/material.dart';
import 'sounds_screen.dart';

class EmojiScreen extends StatefulWidget {
  const EmojiScreen({super.key});

  @override
  State<EmojiScreen> createState() => _EmojiScreenState();
}

class _EmojiScreenState extends State<EmojiScreen> {
  int _selected = 2;
  final List<String> moods = ["sad", "anxious", "neutral", "happy", "joy"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(title: const Text("your thoughts")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          const SizedBox(height: 30),
          const Text("How Do You Feel Today ?",
              style: TextStyle(color: Colors.white, fontSize: 22)),
          const SizedBox(height: 30),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(5, (i) => _emojiBox(i)),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SoundsScreen(
                      mood: moods[_selected],
                      language: "global",
                      journal: "",
                      intentData: const {'reference': null},
                      fromJournal: false,
                    ),
                  ),
                );
              },
              child: const Text("Next"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _emojiBox(int index) {
    final isSelected = _selected == index;

    return GestureDetector(
      onTap: () => setState(() => _selected = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFB86CE3),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
