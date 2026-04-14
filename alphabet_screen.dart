// lib/screens/alphabet_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';
import '../models/tts_service.dart';
import '../widgets/common_widgets.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  int? _selectedIndex;
  bool _showReward = false;
  final _tts = TtsService();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF0F0), Color(0xFFFFF8FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar area
              _buildHeader(context, state),

              // Detail panel (when letter selected)
              if (_selectedIndex != null) _buildDetailPanel(state),

              // Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: AppData.alphabet.length,
                  itemBuilder: (_, i) => _LetterTile(
                    item: AppData.alphabet[i],
                    isSelected: _selectedIndex == i,
                    isLearned: state.learnedLetters.contains(AppData.alphabet[i].letter),
                    onTap: () => _onTap(i, state),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppState state) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF9F43)]),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFFFF6B6B).withOpacity(0.35),
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
            child: Text('🔤 Learn ABC',
                style: GoogleFonts.fredokaOne(
                    fontSize: 24, color: Colors.white)),
          ),
          const StarCounterBadge(),
        ]),
      );

  Widget _buildDetailPanel(AppState state) {
    final item = AppData.alphabet[_selectedIndex!];
    final color = _hexColor(item.color);
    final isLearned = state.learnedLetters.contains(item.letter);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withOpacity(0.4), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(children: [
        // Big letter circle
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Center(
            child: Text(item.letter,
                style: GoogleFonts.fredokaOne(
                    fontSize: 42, color: Colors.white, height: 1)),
          ),
        ),
        const SizedBox(width: 16),
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(item.emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.word,
                          style: GoogleFonts.fredokaOne(
                              fontSize: 22, color: AppColors.textDark)),
                      Text(item.phonetic,
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: AppColors.textMid,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                // Speak button
                BouncyButton(
                  onTap: () => _tts.speakLetter(item.letter),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.volume_up_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Text('Hear It',
                          style: GoogleFonts.fredokaOne(
                              fontSize: 13, color: Colors.white)),
                    ]),
                  ),
                ),
                const SizedBox(width: 8),
                if (!isLearned)
                  BouncyButton(
                    onTap: () {
                      state.markLetterLearned(item.letter);
                      setState(() => _showReward = true);
                      _tts.speakCelebration();
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => RewardPopup(
                              stars: 1,
                              message:
                                  '${item.letter} is for ${item.word}!\nYou learned a new letter!',
                              onDismiss: () => Navigator.pop(context),
                            ),
                          );
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B894),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF00B894).withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.check_circle_outline,
                            color: Colors.white, size: 18),
                        const SizedBox(width: 4),
                        Text('I Learned!',
                            style: GoogleFonts.fredokaOne(
                                fontSize: 13, color: Colors.white)),
                      ]),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFCA57), size: 18),
                      const SizedBox(width: 4),
                      Text('Learned!',
                          style: GoogleFonts.fredokaOne(
                              fontSize: 13,
                              color: const Color(0xFF00B894))),
                    ]),
                  ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }

  void _onTap(int index, AppState state) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? null : index;
    });
    if (_selectedIndex != null) {
      _tts.speakLetter(AppData.alphabet[index].letter);
    }
  }

  Color _hexColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}

// ── Letter tile ──────────────────────────────────────────────────────────────
class _LetterTile extends StatefulWidget {
  final AlphabetItem item;
  final bool isSelected;
  final bool isLearned;
  final VoidCallback onTap;

  const _LetterTile({
    required this.item,
    required this.isSelected,
    required this.isLearned,
    required this.onTap,
  });

  @override
  State<_LetterTile> createState() => _LetterTileState();
}

class _LetterTileState extends State<_LetterTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _bounce = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _color =>
      Color(int.parse(widget.item.color.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: ScaleTransition(
          scale: _bounce,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? _color
                  : widget.isLearned
                      ? _color.withOpacity(0.15)
                      : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.isSelected ? _color : _color.withOpacity(0.35),
                width: widget.isSelected ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _color.withOpacity(widget.isSelected ? 0.4 : 0.15),
                  blurRadius: widget.isSelected ? 12 : 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.letter,
                  style: GoogleFonts.fredokaOne(
                    fontSize: 32,
                    color: widget.isSelected ? Colors.white : _color,
                  ),
                ),
                Text(
                  widget.item.emoji,
                  style: const TextStyle(fontSize: 18),
                ),
                if (widget.isLearned && !widget.isSelected)
                  const Icon(Icons.star_rounded,
                      color: Color(0xFFFFCA57), size: 14),
              ],
            ),
          ),
        ),
      );
}
