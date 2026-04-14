// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';
import '../widgets/common_widgets.dart';
import 'alphabet_screen.dart';
import 'words_screen.dart';
import 'quiz_screen.dart';
import 'rewards_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF0FB), Color(0xFFEFF8FF), Color(0xFFFFFBE0)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(0),
            child: Column(children: [
              // ── Header ──────────────────────────────────
              _Header(state: state),

              // ── Content ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Mascot + speech bubble
                    _MascotRow(),

                    const SizedBox(height: 18),

                    // Progress card
                    _ProgressCard(state: state),

                    const SizedBox(height: 22),

                    // Section label
                    Text('What do you want to learn?',
                        style: GoogleFonts.fredokaOne(
                          fontSize: 18,
                          color: AppColors.textDark,
                        )),

                    const SizedBox(height: 14),

                    // Section grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.05,
                      children: [
                        SectionCard(
                          emoji: '🔤',
                          title: 'Learn ABC',
                          subtitle: 'Letters & Sounds',
                          color: AppColors.sectionColors[0],
                          onTap: () => _navigate(context, const AlphabetScreen()),
                        ),
                        SectionCard(
                          emoji: '📖',
                          title: 'Words',
                          subtitle: 'Build Vocabulary',
                          color: AppColors.sectionColors[1],
                          onTap: () => _navigate(context, const WordsScreen()),
                        ),
                        SectionCard(
                          emoji: '🎮',
                          title: 'Quiz Game',
                          subtitle: 'Test Yourself!',
                          color: AppColors.sectionColors[2],
                          onTap: () => _navigate(context, const QuizScreen()),
                        ),
                        SectionCard(
                          emoji: '🏆',
                          title: 'Rewards',
                          subtitle: 'My Stars',
                          color: AppColors.sectionColors[3],
                          onTap: () => _navigate(context, const RewardsScreen()),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Streak card
                    _StreakCard(state: state),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, a, __) => screen,
      transitionsBuilder: (_, a, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 350),
    ));
  }
}

// ── Header widget ────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final AppState state;
  const _Header({required this.state});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B9D), Color(0xFFFF9F43), Color(0xFFFFCA57)],
          ),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '✨ ENGLISH LEARNING ✨',
              style: GoogleFonts.nunito(
                fontSize: 11,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const StarCounterBadge(),
          ]),
          const SizedBox(height: 6),
          Text(
            'BunnyLearn!',
            style: GoogleFonts.fredokaOne(
              fontSize: 36,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 3),
                  blurRadius: 8,
                )
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            state.rankTitle,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      );
}

// ── Mascot row ───────────────────────────────────────────────────────────────
class _MascotRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const RabbitMascot(size: 90),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
                border: Border.all(color: const Color(0xFFFFD6E7), width: 2),
              ),
              child: Text(
                'Hello! Ready to learn English today? 🌟',
                style: GoogleFonts.fredokaOne(
                    fontSize: 15, color: AppColors.primary),
              ),
            ),
          ),
        ],
      );
}

// ── Progress card ────────────────────────────────────────────────────────────
class _ProgressCard extends StatelessWidget {
  final AppState state;
  const _ProgressCard({required this.state});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Today's Progress",
                  style: GoogleFonts.fredokaOne(
                      fontSize: 16, color: AppColors.textDark)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '⭐ ${state.totalStars} pts',
                  style: GoogleFonts.fredokaOne(
                      fontSize: 13, color: AppColors.primary),
                ),
              ),
            ]),
            const SizedBox(height: 14),
            ProgressRow(
              label: '🔤 Letters Learned',
              value: state.alphabetLearned,
              max: 26,
              color: AppColors.sectionColors[0],
            ),
            const SizedBox(height: 10),
            ProgressRow(
              label: '📖 Words Learned',
              value: state.wordsLearned,
              max: 20,
              color: AppColors.sectionColors[1],
            ),
            const SizedBox(height: 10),
            ProgressRow(
              label: '🎮 Quiz High Score',
              value: state.quizHighScore,
              max: 10,
              color: AppColors.sectionColors[2],
            ),
          ],
        ),
      );
}

// ── Streak card ──────────────────────────────────────────────────────────────
class _StreakCard extends StatelessWidget {
  final AppState state;
  const _StreakCard({required this.state});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF0BE), Color(0xFFFFEAA7)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFCA57), width: 2),
        ),
        child: Row(children: [
          const Text('🔥', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.streakDays} Day Streak!',
                  style: GoogleFonts.fredokaOne(
                      fontSize: 18, color: const Color(0xFFE17055)),
                ),
                Text(
                  'Keep learning every day!',
                  style: GoogleFonts.nunito(
                      fontSize: 13, color: AppColors.textMid, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(children: [
            Text('🏆', style: const TextStyle(fontSize: 28)),
            Text(
              'Keep it up!',
              style: GoogleFonts.nunito(
                  fontSize: 11, color: AppColors.textMid, fontWeight: FontWeight.w700),
            ),
          ])
        ]),
      );
}
