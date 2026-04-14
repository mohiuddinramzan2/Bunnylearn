// lib/screens/rewards_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';
import '../widgets/common_widgets.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEAFAF5), Color(0xFFFFF8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(children: [
                    // Big star display
                    _StarDisplay(state: state),
                    const SizedBox(height: 20),
                    // Progress cards
                    _ProgressSection(state: state),
                    const SizedBox(height: 20),
                    // Badges
                    _BadgesSection(state: state),
                    const SizedBox(height: 20),
                    // Leaderboard / milestones
                    _MilestonesSection(state: state),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF00B894), Color(0xFF00CEC9)]),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF00B894).withOpacity(0.4),
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
            child: Text('🏆 My Rewards',
                style: GoogleFonts.fredokaOne(
                    fontSize: 24, color: Colors.white)),
          ),
          const StarCounterBadge(),
        ]),
      );
}

// ── Big star display ─────────────────────────────────────────────────────────
class _StarDisplay extends StatefulWidget {
  final AppState state;
  const _StarDisplay({required this.state});

  @override
  State<_StarDisplay> createState() => _StarDisplayState();
}

class _StarDisplayState extends State<_StarDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _rotate;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
    _rotate = Tween<double>(begin: 0, end: 1).animate(_ctrl);
    _scale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFCA57), Color(0xFFFF9F43)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFCA57).withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(children: [
          // Animated star
          AnimatedBuilder(
            animation: _ctrl,
            builder: (_, child) => Transform.scale(
              scale: _scale.value,
              child: child,
            ),
            child: const Text('⭐', style: TextStyle(fontSize: 72)),
          ),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${widget.state.totalStars}',
              style: GoogleFonts.fredokaOne(
                  fontSize: 52, color: Colors.white, height: 1),
            ),
            Text(
              'Total Stars',
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.state.rankTitle,
                style: GoogleFonts.fredokaOne(
                    fontSize: 14, color: Colors.white),
              ),
            ),
          ]),
        ]),
      );
}

// ── Progress section ─────────────────────────────────────────────────────────
class _ProgressSection extends StatelessWidget {
  final AppState state;
  const _ProgressSection({required this.state});

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
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Learning Progress',
                style: GoogleFonts.fredokaOne(
                    fontSize: 18, color: AppColors.textDark)),
            const SizedBox(height: 16),
            ProgressRow(
              label: '🔤 Letters Learned',
              value: state.alphabetLearned,
              max: 26,
              color: AppColors.sectionColors[0],
            ),
            const SizedBox(height: 12),
            ProgressRow(
              label: '📖 Words Learned',
              value: state.wordsLearned,
              max: 20,
              color: AppColors.sectionColors[1],
            ),
            const SizedBox(height: 12),
            ProgressRow(
              label: '🎮 Best Quiz Score',
              value: state.quizHighScore,
              max: 10,
              color: AppColors.sectionColors[2],
            ),
          ],
        ),
      );
}

// ── Badges section ───────────────────────────────────────────────────────────
class _BadgesSection extends StatelessWidget {
  final AppState state;
  const _BadgesSection({required this.state});

  List<Map<String, dynamic>> get _badges => [
        {
          'emoji': '🔤',
          'title': 'First Letter',
          'desc': 'Learn your first letter',
          'earned': state.alphabetLearned >= 1,
          'color': const Color(0xFFFF6B6B),
        },
        {
          'emoji': '📚',
          'title': 'Alphabet Half',
          'desc': 'Learn 13 letters',
          'earned': state.alphabetLearned >= 13,
          'color': const Color(0xFFFF9F43),
        },
        {
          'emoji': '🏆',
          'title': 'Alphabet Master',
          'desc': 'Learn all 26 letters',
          'earned': state.alphabetLearned >= 26,
          'color': const Color(0xFFFFCA57),
        },
        {
          'emoji': '📖',
          'title': 'Word Starter',
          'desc': 'Learn 5 words',
          'earned': state.wordsLearned >= 5,
          'color': const Color(0xFF6C5CE7),
        },
        {
          'emoji': '🎯',
          'title': 'Word Pro',
          'desc': 'Learn 15 words',
          'earned': state.wordsLearned >= 15,
          'color': const Color(0xFF00B894),
        },
        {
          'emoji': '🌟',
          'title': 'Quiz Champ',
          'desc': 'Get 8+ in a quiz',
          'earned': state.quizHighScore >= 8,
          'color': const Color(0xFF0984E3),
        },
        {
          'emoji': '⭐',
          'title': 'Star Collector',
          'desc': 'Earn 50 stars',
          'earned': state.totalStars >= 50,
          'color': const Color(0xFFE17055),
        },
        {
          'emoji': '💫',
          'title': 'Super Learner',
          'desc': 'Earn 100 stars',
          'earned': state.totalStars >= 100,
          'color': const Color(0xFF6C5CE7),
        },
      ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🏅 My Badges',
              style: GoogleFonts.fredokaOne(
                  fontSize: 18, color: AppColors.textDark)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: _badges.length,
            itemBuilder: (_, i) {
              final b = _badges[i];
              final earned = b['earned'] as bool;
              final color = b['color'] as Color;

              return Tooltip(
                message: '${b['title']}: ${b['desc']}',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: earned
                        ? color.withOpacity(0.15)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: earned ? color : Colors.grey.shade200,
                      width: 2,
                    ),
                    boxShadow: earned
                        ? [
                            BoxShadow(
                              color: color.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        b['emoji'] as String,
                        style: TextStyle(
                          fontSize: 28,
                          color: earned ? null : const Color(0xFFBBBBBB),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          b['title'] as String,
                          style: GoogleFonts.fredokaOne(
                            fontSize: 10,
                            color: earned ? color : Colors.grey.shade400,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      if (earned)
                        const Icon(Icons.check_circle_rounded,
                            color: Color(0xFF00B894), size: 14),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
}

// ── Milestones section ───────────────────────────────────────────────────────
class _MilestonesSection extends StatelessWidget {
  final AppState state;
  const _MilestonesSection({required this.state});

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
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🎯 Next Goals',
                style: GoogleFonts.fredokaOne(
                    fontSize: 18, color: AppColors.textDark)),
            const SizedBox(height: 14),
            ...[
              _goalRow('Learn 5 more letters', state.alphabetLearned < 26,
                  '🔤', AppColors.sectionColors[0]),
              _goalRow('Learn 5 more words', state.wordsLearned < 20,
                  '📖', AppColors.sectionColors[1]),
              _goalRow('Score 8+ in a quiz', state.quizHighScore < 8,
                  '🎮', AppColors.sectionColors[2]),
              _goalRow('Collect 100 stars', state.totalStars < 100,
                  '⭐', AppColors.sectionColors[3]),
            ].whereType<Widget>().toList(),
          ],
        ),
      );

  Widget _goalRow(String label, bool active, String emoji, Color color) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: active
                  ? color.withOpacity(0.12)
                  : const Color(0xFF00B894).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(active ? emoji : '✅',
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: active ? AppColors.textDark : AppColors.textLight,
                decoration: active ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
          if (!active)
            const Icon(Icons.check_circle_rounded,
                color: Color(0xFF00B894), size: 20),
        ]),
      );
}
