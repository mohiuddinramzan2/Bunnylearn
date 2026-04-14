// lib/models/app_state.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  int _totalStars = 0;
  int _quizHighScore = 0;
  int _alphabetLearned = 0;
  int _wordsLearned = 0;
  List<String> _learnedLetters = [];
  List<String> _learnedWords = [];
  int _streakDays = 1;

  int get totalStars => _totalStars;
  int get quizHighScore => _quizHighScore;
  int get alphabetLearned => _alphabetLearned;
  int get wordsLearned => _wordsLearned;
  List<String> get learnedLetters => _learnedLetters;
  List<String> get learnedWords => _learnedWords;
  int get streakDays => _streakDays;

  AppState() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _totalStars = prefs.getInt('totalStars') ?? 0;
    _quizHighScore = prefs.getInt('quizHighScore') ?? 0;
    _alphabetLearned = prefs.getInt('alphabetLearned') ?? 0;
    _wordsLearned = prefs.getInt('wordsLearned') ?? 0;
    _learnedLetters = prefs.getStringList('learnedLetters') ?? [];
    _learnedWords = prefs.getStringList('learnedWords') ?? [];
    _streakDays = prefs.getInt('streakDays') ?? 1;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalStars', _totalStars);
    await prefs.setInt('quizHighScore', _quizHighScore);
    await prefs.setInt('alphabetLearned', _alphabetLearned);
    await prefs.setInt('wordsLearned', _wordsLearned);
    await prefs.setStringList('learnedLetters', _learnedLetters);
    await prefs.setStringList('learnedWords', _learnedWords);
    await prefs.setInt('streakDays', _streakDays);
  }

  void addStars(int count) {
    _totalStars += count;
    _saveData();
    notifyListeners();
  }

  void markLetterLearned(String letter) {
    if (!_learnedLetters.contains(letter)) {
      _learnedLetters.add(letter);
      _alphabetLearned = _learnedLetters.length;
      addStars(1);
    }
    notifyListeners();
  }

  void markWordLearned(String word) {
    if (!_learnedWords.contains(word)) {
      _learnedWords.add(word);
      _wordsLearned = _learnedWords.length;
      addStars(2);
    }
    notifyListeners();
  }

  void updateQuizScore(int score) {
    if (score > _quizHighScore) {
      _quizHighScore = score;
      addStars(score * 3);
    } else {
      addStars(score);
    }
    notifyListeners();
  }

  String get rankTitle {
    if (_totalStars >= 200) return '🏆 Super Star!';
    if (_totalStars >= 100) return '🌟 Star Learner';
    if (_totalStars >= 50) return '⭐ Rising Star';
    if (_totalStars >= 20) return '✨ Explorer';
    return '🐰 Beginner';
  }
}
