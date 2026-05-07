import 'package:flutter/material.dart';
import 'journal_screen.dart';
import 'saved_journals_screen.dart';
import 'emoji_screen.dart';
import 'sounds_screen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  String _todayLabel() {
    final now = DateTime.now();
    const days = [
      'Sunday','Monday','Tuesday','Wednesday',
      'Thursday','Friday','Saturday'
    ];
    final d = days[now.weekday % 7];
    final date = "${now.day.toString().padLeft(2,'0')}/${now.month.toString().padLeft(2,'0')}";
    return "$d $date";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_todayLabel(),
                      style: const TextStyle(color: Colors.white70, fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.history, color: Colors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SavedJournalsScreen()),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              _mainCard(context),

              const SizedBox(height: 30),

              const Text("Exercises",
                  style: TextStyle(color: Colors.white, fontSize: 20)),

              const SizedBox(height: 12),

              _exercise(context, "Journaling", Icons.book_rounded,
                      () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const JournalScreen()))),

              const SizedBox(height: 12),

                    _exercise(context, "Lume Sounds", Icons.music_note_rounded,
                      () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SoundsScreen(
                  mood: "neutral",
                  language: "global",
                  journal: "",
                  intentData: {'reference': null},
                  fromJournal: false,
                      )))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainCard(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        colors: [Color(0xFF7B4DB8), Color(0xFFB86CE3)],
      ),
    ),
    child: Column(
      children: [
        const Text("What Do You Feel\nToday ?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 26)),
        const SizedBox(height: 18),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EmojiScreen()),
          ),
          child: const Text("Share Your Thoughts"),
        )
      ],
    ),
  );

  Widget _exercise(BuildContext context, String text, IconData icon, VoidCallback onTap) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white54)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(color: Colors.white)),
          ]),
        ),
      );
}
