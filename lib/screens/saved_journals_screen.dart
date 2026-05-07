import 'package:flutter/material.dart';
import '../services/journal_storage_service.dart';
import 'sounds_screen.dart';
import 'journal_reader_screen.dart';

class SavedJournalsScreen extends StatefulWidget {
  const SavedJournalsScreen({super.key});

  @override
  State<SavedJournalsScreen> createState() => _SavedJournalsScreenState();
}

class _SavedJournalsScreenState extends State<SavedJournalsScreen> {
  late Future<List<Map<String, dynamic>>> _journals;

  @override
  void initState() {
    super.initState();
    _journals = JournalStorageService.loadJournals();
  }

  String _formatDate(DateTime date) {
    const days = [
      'Sunday','Monday','Tuesday','Wednesday',
      'Thursday','Friday','Saturday'
    ];
    final dayName = days[date.weekday % 7];
    final d = date.day.toString().padLeft(2,'0');
    final m = date.month.toString().padLeft(2,'0');
    final y = (date.year % 100).toString().padLeft(2,'0');
    final h = date.hour.toString().padLeft(2,'0');
    final min = date.minute.toString().padLeft(2,'0');
    return "$dayName $d/$m/$y $h:$min";
  }

  void _openJournal(Map<String, dynamic> j) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JournalReaderScreen(journal: j),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(
        title: const Text("Saved Journals"),
        backgroundColor: const Color(0xFF6A3FA0),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _journals,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final journals = snapshot.data!.reversed.toList();

          if (journals.isEmpty) {
            return const Center(
              child: Text("No journals yet.",
                  style: TextStyle(color: Colors.white70)),
            );
          }

          return ListView.builder(
            itemCount: journals.length,
            itemBuilder: (_, i) {
              final j = journals[i];
              final date = DateTime.parse(j['date']);

              return Card(
                color: const Color(0xFF7B4DB8),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    j['text'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${j['mood']} • ${_formatDate(date)}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  onTap: () => _openJournal(j),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
