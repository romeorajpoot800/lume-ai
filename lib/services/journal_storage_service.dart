import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JournalStorageService {
  static const String _key = 'saved_journals';

  static Future<void> saveJournal({
    required String text,
    required String mood,
    required DateTime date,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    final List journals = raw == null ? [] : jsonDecode(raw);

    journals.add({
      'text': text,
      'mood': mood,
      'date': date.toIso8601String(),
    });

    await prefs.setString(_key, jsonEncode(journals));
  }

  static Future<List<Map<String, dynamic>>> loadJournals() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    if (raw == null) return [];

    final List data = jsonDecode(raw);
    return data.cast<Map<String, dynamic>>();
  }
}
