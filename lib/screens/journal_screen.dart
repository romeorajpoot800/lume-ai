import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../services/journal_storage_service.dart';
import 'saved_journals_screen.dart';
import 'sounds_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  final AIService _aiService = AIService();
  bool _loading = false;

  Future<void> _analyzeAndRecommend() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() => _loading = true);

    final rawText = _controller.text;

    final mood = await _aiService.detectMood(rawText);
    final language = await _aiService.detectLanguage(rawText);
    final intentData = await _aiService.extractIntent(rawText);

    await JournalStorageService.saveJournal(
      text: rawText,
      mood: mood,
      date: DateTime.now(),
    );

    setState(() => _loading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SoundsScreen(
          mood: mood,
          language: language,
          journal: rawText,
          intentData: intentData,
          fromJournal: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(
        title: const Text("journaling"),
        backgroundColor: const Color(0xFF6A3FA0),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SavedJournalsScreen()),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Write how you feel...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _analyzeAndRecommend,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text("Save & Get Recommendations"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
