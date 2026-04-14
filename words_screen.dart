// lib/screens/words_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';
import '../models/tts_service.dart';
import '../widgets/common_widgets.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _tts = TtsService();

  final List<String> _categories = ['All', 'Animals', 'Fruits', 'Nature', 'Toys'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  List<WordItem> _filtered(String cat) => cat == 'All'
      ? AppData.words
      : AppData.words.where((w) => w.category == cat).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5E6), Color(0xFFFFF8FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(children: [
            // Header
            _buildHeader(context),

            // Tab bar
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, 3))
                ],
              ),
              child: TabBar(
                controller: _tabCtrl,
                isScrollable: true,
                indicatorColor: AppColors.sectionColors[1],
                indicatorWeight: 3,
                labelColor: AppColors.sectionColors[1],
                unselectedLabelColor: AppColors.textMid,
                labelStyle: GoogleFonts.fredokaOne(fontSize: 14),
                unselectedLabelStyle: GoogleFonts.nunito(
                    fontSize: 13, fontWeight: FontWeight.w700),
                tabs: _categories
                    .map((c) => Tab(text: c))
                    .toList(),
              ),
            ),

            // Grid
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: _categories.map((cat) {
                  final words = _filtered(cat);
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.92,
                    ),
                    itemCount: words.length,
                    itemBuilder: (_, i) {
                      final w = words[i];
                      return Consumer<AppState>(
                        builder: (_, state, __) => _WordCard(
                          word: w,
                          isLearned: state.learnedWords.contains(w.word),
                          onLearn: () => _learn(context, w, state),
                          onSpeak: () => _tts.speakWord(w.word, w.sentence),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _learn(BuildContext context, WordItem w, AppState state) {
    if (!state.learnedWords.contains(w.word)) {
      state.markWordLearned(w.word);
      _tts.speakCelebration();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RewardPopup(
          stars: 2,
          message: '"${w.word}" learned!\n${w.sentence}',
          onDismiss: () => Navigator.pop(context),
        ),
      );
    }
  }

  Widget _buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFFF9F43), Color(0xFFFFCA57)]),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFFFF9F43).withOpacity(0.4),
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
            child: Text('📖 Words',
                style: GoogleFonts.fredokaOne(
                    fontSize: 24, color: Colors.white)),
          ),
          const StarCounterBadge(),
        ]),
      );
}

// ── Word flip card ───────────────────────────────────────────────────────────
class _WordCard extends StatefulWidget {
  final WordItem word;
  final bool isLearned;
  final VoidCallback onLearn;
  final VoidCallback onSpeak;

  const _WordCard({
    required this.word,
    required this.isLearned,
    required this.onLearn,
    required this.onSpeak,
  });

  @override
  State<_WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<_WordCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipCtrl;
  late Animation<double> _flipAnim;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    super.dispose();
  }

  void _flip() {
    setState(() => _isFlipped = !_isFlipped);
    _isFlipped ? _flipCtrl.forward() : _flipCtrl.reverse();
    widget.onSpeak();
  }

  Color get _color =>
      Color(int.parse(widget.word.color.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _flip,
        child: AnimatedBuilder(
          animation: _flipAnim,
          builder: (_, __) {
            final angle = _flipAnim.value * 3.14159;
            final isFront = angle < 1.5708;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isFront ? _buildFront() : _buildBack(),
            );
          },
        ),
      );

  Widget _buildFront() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border:
              Border.all(color: _color.withOpacity(0.3), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: _color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.word.emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text('Tap to see!',
              style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w700)),
          if (widget.isLearned)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.star_rounded,
                  color: Color(0xFFFFCA57), size: 20),
            ),
        ]),
      );

  Widget _buildBack() => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(3.14159),
        child: Container(
          decoration: BoxDecoration(
            color: _color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _color, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: _color.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.word.emoji, style: const TextStyle(fontSize: 36)),
                Text(
                  widget.word.word,
                  style: GoogleFonts.fredokaOne(fontSize: 22, color: _color),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.word.sentence,
                  style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: AppColors.textMid,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                if (!widget.isLearned)
                  BouncyButton(
                    onTap: widget.onLearn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text('I learned it! ⭐',
                          style: GoogleFonts.fredokaOne(
                              fontSize: 12, color: Colors.white)),
                    ),
                  )
                else
                  Text('✅ Learned!',
                      style: GoogleFonts.fredokaOne(
                          fontSize: 13,
                          color: const Color(0xFF00B894))),
              ],
            ),
          ),
        ),
      );
}
