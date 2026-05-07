class RecommendationService {
  static List<String> getRecommendations(String mood) {
    switch (mood.toLowerCase()) {
      case 'sadness':
        return ['calm', 'rain', 'piano'];
      case 'happy':
        return ['happy', 'guitar', 'birds'];
      case 'anger':
        return ['calm', 'wind', 'forest'];
      case 'fear':
        return ['calm', 'rain', 'meditation'];
      default:
        return ['calm', 'nature', 'ambient'];
    }
  }
}
