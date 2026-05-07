# LUME AI — AI-powered journaling

LUME AI is a Flutter mobile app for reflective journaling with AI-assisted mood analysis and personalized music recommendations.

**Key Features**
- AI-powered mood detection (HuggingFace inference)
- Mood-based music recommendations and artist-similarity suggestions
- Multi-language support and automatic language detection
- Built-in calming soundscapes and audio player
- Local persistence with `shared_preferences`

**Tech stack**
- Flutter
- HuggingFace Inference API
- `youtube_explode_dart` (artist/video metadata)
- `shared_preferences` (local storage)
- `audioplayers` (in-app audio)
 - Note: local MP3 soundscape playback has been removed to reduce repository size; recommendations still open in external players (YouTube links).

## Getting Started

Prerequisites:
- Flutter SDK (stable)
- Android SDK / Xcode (for mobile builds)

Install dependencies:

```bash
flutter pub get
```

Provide your HuggingFace API key (do NOT commit it). Two recommended approaches:

- Use `--dart-define` at build/run time (no extra packages):

```bash
flutter run --dart-define=HF_API_KEY=your_key_here
flutter build apk --release --dart-define=HF_API_KEY=your_key_here
```

- Or set environment variables in CI and pass `--dart-define` during builds.

For local development you can copy `.env.example` to `.env` (but keep `.env` in `.gitignore`).

## Build (release APK)

```bash
flutter build apk --release --dart-define=HF_API_KEY=your_key_here
# output: build/app/outputs/flutter-apk/app-release.apk
```

## Security
- Do NOT commit API keys or keystore files. If you find a committed secret, revoke and rotate it immediately.

## Contributing
- Open issues and PRs on GitHub. Keep changes small and focused.

## License
Add a `LICENSE` file to this repository (e.g., MIT or Apache-2.0). If you want, I can add an MIT license now.

## Contact
- Maintainer: add your name and contact details here.


