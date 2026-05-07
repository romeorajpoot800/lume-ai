class MoodAnalyzer {
  static String analyze(String text) {
    final t = text.toLowerCase();

    if (_has(t, ['sad', 'depressed', 'angry', 'lonely', 'tired', 'low']))
      return 'sad';
    if (_has(t, ['happy', 'joy', 'excited', 'great', 'awesome'])) return 'happy';
    if (_has(t, ['anxious', 'fear', 'stress', 'worried'])) return 'anxious';
    if (_has(t, ['calm', 'peace', 'relaxed', 'okay', 'fine'])) return 'calm';

    return 'neutral';
  }

  static bool _has(String t, List<String> k) =>
      k.any((e) => t.contains(e));
}
