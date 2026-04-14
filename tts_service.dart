// lib/models/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.2);
    _initialized = true;
  }

  Future<void> speak(String text) async {
    await init();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> speakLetter(String letter) async {
    await speak('$letter. $letter is for ${_getWord(letter)}');
  }

  Future<void> speakWord(String word, String sentence) async {
    await speak('$word. $sentence');
  }

  Future<void> speakCelebration() async {
    await speak('Great job! You are amazing!');
  }

  Future<void> speakCorrect() async {
    await speak('Correct! Well done!');
  }

  Future<void> speakWrong() async {
    await speak('Try again! You can do it!');
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  String _getWord(String letter) {
    const map = {
      'A': 'Apple', 'B': 'Bear', 'C': 'Cat', 'D': 'Dog', 'E': 'Elephant',
      'F': 'Fish', 'G': 'Grape', 'H': 'House', 'I': 'Ice Cream', 'J': 'Jam',
      'K': 'Kite', 'L': 'Lion', 'M': 'Moon', 'N': 'Night', 'O': 'Orange',
      'P': 'Penguin', 'Q': 'Queen', 'R': 'Rainbow', 'S': 'Star', 'T': 'Tree',
      'U': 'Umbrella', 'V': 'Violin', 'W': 'Whale', 'X': 'X-Ray',
      'Y': 'Yellow', 'Z': 'Zebra',
    };
    return map[letter] ?? letter;
  }
}
