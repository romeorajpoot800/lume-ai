import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'sounds_screen.dart';

class LumeSoundsScreen extends StatefulWidget {
  const LumeSoundsScreen({super.key});

  @override
  State<LumeSoundsScreen> createState() => _LumeSoundsScreenState();
}

class _LumeSoundsScreenState extends State<LumeSoundsScreen> {
  final AudioPlayer _player = AudioPlayer();
  String? _current;
  double _volume = 0.8;

  final sounds = {
    "Calm": "assets/sounds/calm.mp3",
    "Happy": "assets/sounds/happy.mp3",
    "Sad": "assets/sounds/sad.mp3",
  };

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _play(String name) async {
    if (_current == name) {
      await _player.stop();
      setState(() => _current = null);
    } else {
      await _player.setVolume(_volume);
      await _player.play(AssetSource(sounds[name]!));
      setState(() => _current = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3FA0),
      appBar: AppBar(
        title: const Text("lume sounds"),
        backgroundColor: const Color(0xFF6A3FA0),
        actions: [
          IconButton(
            icon: const Icon(Icons.recommend),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SoundsScreen(
                  mood: "neutral",
                  language: "global",
                  journal: "",
                  intentData: {'reference': null},
                  fromJournal: false,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          ...sounds.keys.map((name) => Card(
            color: const Color(0xFFB86CE3),
            child: ListTile(
              title:
              Text(name, style: const TextStyle(color: Colors.white)),
              trailing: Icon(
                _current == name
                    ? Icons.pause_circle
                    : Icons.play_circle,
                color: Colors.white,
                size: 32,
              ),
              onTap: () => _play(name),
            ),
          )),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.volume_down, color: Colors.white),
              Expanded(
                child: Slider(
                  value: _volume,
                  onChanged: (v) {
                    setState(() => _volume = v);
                    _player.setVolume(v);
                  },
                ),
              ),
              const Icon(Icons.volume_up, color: Colors.white),
            ],
          ),
        ]),
      ),
    );
  }
}
