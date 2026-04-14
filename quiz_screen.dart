// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';
import '../models/tts_service.dart';
import '../widgets/common_widgets.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  bool _finished = false;
  final _tts = TtsService();

  late AnimationController _questionCtrl;
  late Animation<Offset> _questionSlide;
  late AnimationController _feedbackCtrl;
  late Animation<double> _feedbackScale;

  @override
  void initState() {
    super.initState();
    _questions = List.from(AppData.quizQuestions)..shuffle();

    _questionCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _questionSlide = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOutCubic));
    _questionCtrl.forward();

    _feedbackCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _feedbackScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _feedbackCtrl, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    _feedbackCtrl.dispose();
    super.dispose();
  }

  QuizQuestion get _q => _questions[_currentIndex];

  void _answer(int index, AppState state) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
    });
    _feedbackCtrl.forward();

    if (index == _q.correctIndex) {
      _score++;
      _tts.speakCorrect();
    } else {
      _tts.speakWrong();
    }

    Future.delayed(const Duration(seconds: 1, milliseconds: 200), () {
      if (!mounted) return;
      if (_currentIndex + 1 >= _questions.length) {
        setState(() => _finished = true);
        state.updateQuizScore(_score);
        _tts.speak('Quiz finished! You got $_score out of ${_questions.length}!');
      } else {
        _questionCtrl.reset();
        _feedbackCtrl.reset();
        setState(() {
          _currentIndex++;
          _answered = false;
          _selectedOption = null;
        });
        _questionCtrl.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0EEFF), Color(0xFFFFF8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: _finished
              ? _buildFinished(context)
              : Column(children: [
                  _buildHeader(context),
                  Expanded(
                    child: Consumer<AppState>(
                      builder: (_, state, __) => Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(children: [
                          // Progress
                          _buildProgress(),
                          const SizedBox(height: 20),
                          // Question card
                          Expanded(child: _buildQuestion(state)),
                        ]),
                      ),
                    ),
                  ),
                ]),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)]),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF6C5CE7).withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 5))
          ],
        ),
        child: Row(children: [
          BouncyButton(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text('🎮 Quiz Game',
                style: GoogleFonts.fredokaOne(
                    fontSize: 24, color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white38),
            ),
            child: Text(
              '⭐ $_score',
              style: GoogleFonts.fredokaOne(
                  fontSize: 16, color: Colors.white),
            ),
          ),
        ]),
      );

  Widget _buildProgress() => Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Question ${_currentIndex + 1} of ${_questions.length}',
            style: GoogleFonts.fredokaOne(
                fontSize: 14, color: AppColors.accent1),
          ),
          Text(
            '${((_currentIndex / _questions.length) * 100).round()}%',
            style: GoogleFonts.fredokaOne(
                fontSize: 14, color: AppColors.accent1),
          ),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _currentIndex / _questions.length,
            minHeight: 12,
            backgroundColor: AppColors.accent1.withOpacity(0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent1),
          ),
        ),
      ]);

  Widget _buildQuestion(AppState state) => SlideTransition(
        position: _questionSlide,
        child: Column(children: [
          // Question card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent1.withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Column(children: [
              Text(_q.emoji, style: const TextStyle(fontSize: 68)),
              const SizedBox(height: 12),
              Text(
                _q.question,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredokaOne(
                    fontSize: 20, color: AppColors.textDark),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // Answer options
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(_q.options.length, (i) {
                return _buildOptionButton(i, state);
              }),
            ),
          ),

          // Feedback
          if (_answered)
            ScaleTransition(
              scale: _feedbackScale,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedOption == _q.correctIndex
                      ? const Color(0xFF00B894)
                      : const Color(0xFFFF6B6B),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: (_selectedOption == _q.correctIndex
                              ? const Color(0xFF00B894)
                              : const Color(0xFFFF6B6B))
                          .withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  _selectedOption == _q.correctIndex
                      ? '🎉 Correct! Amazing!'
                      : '❌ Try again next time!',
                  style: GoogleFonts.fredokaOne(
                      fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ]),
      );

  Widget _buildOptionButton(int i, AppState state) {
    Color bg = Colors.white;
    Color border = AppColors.accent1.withOpacity(0.25);
    Color textColor = AppColors.accent1;

    if (_answered) {
      if (i == _q.correctIndex) {
        bg = const Color(0xFF00B894);
        border = const Color(0xFF00B894);
        textColor = Colors.white;
      } else if (i == _selectedOption) {
        bg = const Color(0xFFFF6B6B);
        border = const Color(0xFFFF6B6B);
        textColor = Colors.white;
      } else {
        bg = Colors.grey.shade100;
        border = Colors.grey.shade200;
        textColor = AppColors.textLight;
      }
    }

    return BouncyButton(
      onTap: () => _answer(i, state),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: border.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            _q.options[i],
            style: GoogleFonts.fredokaOne(fontSize: 26, color: textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildFinished(BuildContext context) {
    final pct = (_score / _questions.length * 100).round();
    final isGreat = pct >= 80;
    final isGood = pct >= 50;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          isGreat ? '🏆' : isGood ? '🌟' : '💪',
          style: const TextStyle(fontSize: 80),
        ),
        const SizedBox(height: 16),
        Text(
          isGreat
              ? 'Outstanding!'
              : isGood
                  ? 'Good Job!'
                  : 'Keep Practicing!',
          style: GoogleFonts.fredokaOne(
              fontSize: 32, color: AppColors.accent1),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Column(children: [
            Text(
              '$_score / ${_questions.length}',
              style: GoogleFonts.fredokaOne(
                  fontSize: 48, color: AppColors.accent1),
            ),
            Text(
              '$pct% Correct',
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: AppColors.textMid,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (int i = 0; i < (_score / 2).ceil(); i++) ...[
                const Text('⭐', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 2),
              ]
            ]),
          ]),
        ),
        const SizedBox(height: 28),
        Row(children: [
          Expanded(
            child: BouncyButton(
              onTap: () {
                setState(() {
                  _questions.shuffle();
                  _currentIndex = 0;
                  _score = 0;
                  _selectedOption = null;
                  _answered = false;
                  _finished = false;
                });
                _questionCtrl.reset();
                _feedbackCtrl.reset();
                _questionCtrl.forward();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent1.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Text(
                  '🔄 Play Again',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredokaOne(
                      fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BouncyButton(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.accent1.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  '🏠 Home',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredokaOne(
                      fontSize: 18, color: AppColors.accent1),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
