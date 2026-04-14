# 🐰 BunnyLearn — Kids English Learning App

A complete Flutter app for teaching English to young children, with a cute rabbit mascot, animations, audio support, and a reward system.

---

## 📱 Features

| Feature | Details |
|---|---|
| 🔤 **Learn ABC** | All 26 letters with emoji words, phonetics, tap-to-hear TTS |
| 📖 **Words** | 20 words across 4 categories (Animals, Fruits, Nature, Toys) with flip cards |
| 🎮 **Quiz Game** | 10 randomized questions, animated feedback, score tracking |
| 🏆 **Rewards** | Stars system, 8 badges, progress bars, milestone goals |
| 🐰 **Rabbit Mascot** | Custom-drawn, floating animated SVG character |
| 🔊 **Audio** | Text-to-speech for letters, words, feedback (flutter_tts) |
| 💾 **Persistence** | Progress saved locally (shared_preferences) |

---

## 🚀 Setup

### Prerequisites
- Flutter SDK 3.0+
- Android Studio / Xcode
- Physical device or emulator

### Steps

```bash
# 1. Navigate into the project
cd bunny_learn

# 2. Get dependencies
flutter pub get

# 3. Run the app
flutter run

# 4. Build APK (Android)
flutter build apk --release

# 5. Build for iOS
flutter build ios --release
```

---

## 📂 Project Structure

```
lib/
├── main.dart                  # App entry + Splash screen
├── data/
│   └── app_data.dart          # All content: alphabet, words, quiz questions
├── models/
│   ├── app_state.dart         # ChangeNotifier: stars, progress, persistence
│   ├── app_theme.dart         # Colors, text styles, theme
│   └── tts_service.dart       # Singleton TTS wrapper (flutter_tts)
├── widgets/
│   └── common_widgets.dart    # BouncyButton, StarBadge, RabbitMascot,
│                              # SectionCard, RewardPopup, ProgressRow
└── screens/
    ├── home_screen.dart        # Dashboard with navigation grid
    ├── alphabet_screen.dart    # A–Z grid with detail panel + TTS
    ├── words_screen.dart       # Category tabs + 3D flip cards
    ├── quiz_screen.dart        # Animated quiz with score tracking
    └── rewards_screen.dart     # Stars, badges, milestones
```

---

## 🎨 Design System

- **Font**: Fredoka One (headings/letters) + Nunito (body)
- **Primary**: `#FF6B9D` (pink), Secondary: `#FFCA57` (yellow)
- **Section colors**: Red · Orange · Purple · Green
- **Animations**: Bounce buttons, float rabbit, card flip, slide transitions, elastic pop-ins
- **Portrait locked** + immersive mode for distraction-free learning

---

## 📦 Dependencies

```yaml
flutter_tts: ^4.0.2          # Text-to-speech
shared_preferences: ^2.2.2   # Local data persistence
google_fonts: ^6.1.0         # Fredoka One + Nunito
provider: ^6.1.1             # State management
```

---

## 🏆 Reward System

| Action | Stars Earned |
|---|---|
| Learn a new letter | +1 ⭐ |
| Learn a new word | +2 ⭐ |
| Quiz correct answer | +1 ⭐ |
| New quiz high score | +3× score ⭐ |

### Ranks
- 🐰 Beginner (0–19 stars)
- ✨ Explorer (20–49 stars)
- ⭐ Rising Star (50–99 stars)
- 🌟 Star Learner (100–199 stars)
- 🏆 Super Star! (200+ stars)

---

## 🔊 Audio Notes

The app uses `flutter_tts` for device text-to-speech, which works on both Android and iOS without any extra audio files needed. Speech rate is set to 0.45 (slower, child-friendly) and pitch to 1.2 (slightly higher, more engaging).

For custom sound effects, add `.mp3` files to `assets/audio/` and use the `audioplayers` package (already in pubspec).

---

Made with 💖 for little learners!
