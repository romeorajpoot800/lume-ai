import 'package:flutter/material.dart';
import 'sounds_screen.dart';

class JournalReaderScreen extends StatelessWidget {
  final Map<String, dynamic> journal;

  const JournalReaderScreen({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    final text = journal['text'];
    final mood = journal['mood'];

    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(
        title: const Text("Journal Entry"),
        backgroundColor: const Color(0xFF6A3FA0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white38),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SoundsScreen(
                        mood: mood,
                        language: "global",
                        journal: text,
                        intentData: const {'reference': null},
                        fromJournal: true,
                      ),
                    ),
                  );
                },
                child: const Text("Play Suggested Sounds"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
