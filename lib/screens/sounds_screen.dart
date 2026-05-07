import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/smart_recommendation_engine.dart';

class SoundsScreen extends StatefulWidget {
  final String mood;
  final String language;
  final String journal;
  final Map<String, String?> intentData;
  final bool fromJournal;

  const SoundsScreen({
    super.key,
    required this.mood,
    required this.language,
    required this.journal,
    required this.intentData,
    required this.fromJournal,
  });

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  late Future<List<Song>> _songs;

  @override
  void initState() {
    super.initState();

    final queryText = widget.fromJournal ? widget.journal : "";

    _songs = SmartRecommendationEngine.recommend(
      journal: queryText,
      mood: widget.mood,
      language: widget.language,
      intentData: widget.intentData,
    );
  }

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(
        title: const Text("Recommended For You"),
        backgroundColor: const Color(0xFF6A3FA0),
      ),
      body: FutureBuilder<List<Song>>(
        future: _songs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final songs = snapshot.data!;

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (_, i) {
              final s = songs[i];

              return Card(
                color: const Color(0xFF7B4DB8),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(s.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(s.artist, style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.play_circle_fill, color: Colors.white),
                  onTap: () => _open(s.url),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
