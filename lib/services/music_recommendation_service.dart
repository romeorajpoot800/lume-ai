class Song {
  final String title;
  final String artist;
  final String url;

  Song(this.title, this.artist, this.url);
}

class MusicRecommendationService {
  static final Map<String, Map<String, List<Song>>> _library = {
    "English": {
      "joy": [
        Song("Can't Stop The Feeling", "Justin Timberlake",
            "https://www.youtube.com/watch?v=ru0K8uYEZWw"),
        Song("Happy", "Pharrell Williams",
            "https://www.youtube.com/watch?v=ZbZSe6N_BXs"),
      ],
      "neutral": [
        Song("Let It Be", "The Beatles",
            "https://www.youtube.com/watch?v=QDYfEBY9NM4"),
      ],
    },
    "Hindi": {
      "joy": [
        Song("Ilahi", "Arijit Singh",
            "https://www.youtube.com/watch?v=fdubeMFwuGs"),
        Song("Zinda", "Siddharth Mahadevan",
            "https://www.youtube.com/watch?v=AkhtqH4nNwM"),
      ],
      "neutral": [
        Song("Phir Se Ud Chala", "Mohit Chauhan",
            "https://www.youtube.com/watch?v=2mWaqsC3U7k"),
      ],
    },
  };

  static Future<List<Song>> fetchSongs({
    required String mood,
    required String language,
  }) async {
    String moodKey;

    if (mood == "sadness" || mood == "fear" || mood == "anger") {
      moodKey = "joy"; // 💙 always uplift
    } else {
      moodKey = _library[language]?.containsKey(mood) == true
          ? mood
          : "neutral";
    }

    return _library[language]?[moodKey] ??
        _library["English"]!["neutral"]!;
  }
}
