import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Song {
  final String title;
  final String artist;
  final String url;

  Song(this.title, this.artist, this.url);
}

class SmartRecommendationEngine {
  static final _yt = YoutubeExplode();

  static final _softBlockedWords = [
    'how to',
    'tutorial',
    'explained',
    'free flp',
    'type beat',
    'production',
    'mixing',
    'mastering',
  ];

  static Future<List<Song>> recommend({
    required String journal,
    required String mood,
    required String language,
    required Map<String, String?> intentData,
  }) async {
    final List<Song> songs = [];
    final reference = intentData['reference'];

    if (reference != null && reference.isNotEmpty) {
      await _recommendSimilar(reference, songs);
    } else {
      final query = _buildMoodQuery(mood, language);
      await _fetch(query, songs);
    }

    // Fallback if filters remove too much
    if (songs.length < 10) {
      final fallbackQuery = "popular songs $language";
      await _fetch(fallbackQuery, songs);
    }

    return songs.take(40).toList();
  }

  static Future<void> _recommendSimilar(String reference, List<Song> songs) async {
    final seed = await _yt.search.search(reference);
    if (seed.isEmpty) return;

    final artist = seed.first.author;
    final query = "$artist songs similar style";

    await _fetch(query, songs);
  }

  static Future<void> _fetch(String query, List<Song> songs) async {
    final results = await _yt.search.search(query);

    for (final video in results) {
      final title = video.title.toLowerCase();

      if (_softBlockedWords.any(title.contains)) continue;
      if (video.duration != null && video.duration!.inSeconds < 60) continue;
      if (title.contains('#shorts')) continue;

      // Avoid duplicates
      if (songs.any((s) => s.title == video.title)) continue;

      songs.add(Song(
        video.title,
        video.author,
        'https://www.youtube.com/watch?v=${video.id.value}',
      ));

      if (songs.length >= 40) break;
    }
  }

  static String _buildMoodQuery(String mood, String language) {
    mood = mood.toLowerCase();

    if (mood.contains('sad') ||
        mood.contains('depressed') ||
        mood.contains('anxious') ||
        mood.contains('fear')) {
      return "sad emotional songs calm healing music rain piano birds";
    }

    if (mood.contains('happy') || mood.contains('joy')) {
      return "happy feel good upbeat songs";
    }

    if (mood.contains('anger')) {
      return "energetic powerful songs";
    }

    return "popular feel good songs";
  }
}
