import 'dart:convert';
import 'package:http/http.dart' as http;
import 'mood_analyzer.dart';

class AIService {
  // Do NOT keep API keys in source control. Provide the HuggingFace API key
  // at build/run time. Example:
  //   flutter run --dart-define=HF_API_KEY=your_key_here
  //   flutter build apk --release --dart-define=HF_API_KEY=your_key_here
  static final String _token = const String.fromEnvironment('HF_API_KEY', defaultValue: '');

  static const String _endpoint =
      'https://router.huggingface.co/hf-inference/models/SamLowe/roberta-base-go_emotions';

  Future<String> detectMood(String text) async {
    try {
      // If no API key supplied, fall back to local mood analyzer.
      if (_token.isEmpty) return MoodAnalyzer.analyze(text);

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          if (_token.isNotEmpty) 'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({'inputs': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          final emotions = data[0] as List;
          emotions.sort((a, b) => b['score'].compareTo(a['score']));
          return emotions.first['label'];
        }
      }
    } catch (_) {}

    return MoodAnalyzer.analyze(text);
  }

  // 🌍 Universal language detection
  String detectLanguage(String text) {
    if (!RegExp(r'\p{L}', unicode: true).hasMatch(text)) return 'global';
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) return 'arabic';
    if (RegExp(r'[\u0900-\u097F]').hasMatch(text)) return 'indic';
    if (RegExp(r'[\u4E00-\u9FFF]').hasMatch(text)) return 'chinese';
    if (RegExp(r'[\u3040-\u30FF]').hasMatch(text)) return 'japanese';
    if (RegExp(r'[\uAC00-\uD7AF]').hasMatch(text)) return 'korean';
    return 'global';
  }

  // 🧠 User intent & reference detection
  Map<String, String?> extractIntent(String text) {
    final lower = text.toLowerCase();
    String? ref;

    final match = RegExp(r'(like|play|listen to|similar to)\s+(.+)',
        caseSensitive: false)
        .firstMatch(lower);

    if (match != null) ref = match.group(2)?.trim();

    return {'reference': ref};
  }
}
