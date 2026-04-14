// lib/widgets/common_widgets.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_theme.dart';
import '../models/app_state.dart';

// ── Bouncy button ────────────────────────────────────────────────────────────
class BouncyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scale;

  const BouncyButton({
    super.key,
    required this.child,
    required this.onTap,
    this.scale = 0.92,
  });

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: ScaleTransition(scale: _scaleAnim, child: widget.child),
      );
}

// ── Star counter badge ───────────────────────────────────────────────────────
class StarCounterBadge extends StatelessWidget {
  const StarCounterBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final stars = context.watch<AppState>().totalStars;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white38),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('⭐', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(
          '$stars',
          style: GoogleFonts.fredokaOne(fontSize: 16, color: Colors.white),
        ),
      ]),
    );
  }
}

// ── Rabbit mascot SVG ────────────────────────────────────────────────────────
class RabbitMascot extends StatefulWidget {
  final double size;
  final bool animate;

  const RabbitMascot({super.key, this.size = 100, this.animate = true});

  @override
  State<RabbitMascot> createState() => _RabbitMascotState();
}

class _RabbitMascotState extends State<RabbitMascot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _float = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _float,
        builder: (_, child) => Transform.translate(
          offset: widget.animate ? Offset(0, _float.value) : Offset.zero,
          child: child,
        ),
        child: SizedBox(
          width: widget.size,
          height: widget.size * 1.2,
          child: CustomPaint(painter: _RabbitPainter()),
        ),
      );
}

class _RabbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..style = PaintingStyle.fill;

    // Ears
    paint.color = const Color(0xFFFDEEF1);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.35, h * 0.22), width: w * 0.22, height: h * 0.42), paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.65, h * 0.22), width: w * 0.22, height: h * 0.42), paint);
    paint.color = const Color(0xFFF4A0B0);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.35, h * 0.22), width: w * 0.12, height: h * 0.3), paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.65, h * 0.22), width: w * 0.12, height: h * 0.3), paint);

    // Head
    paint.color = const Color(0xFFFDEEF1);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.54), width: w * 0.72, height: h * 0.54), paint);

    // Cheeks
    paint.color = const Color(0xFFFFADC0).withOpacity(0.6);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.3, h * 0.6), width: w * 0.22, height: h * 0.12), paint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.7, h * 0.6), width: w * 0.22, height: h * 0.12), paint);

    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(w * 0.38, h * 0.5), w * 0.1, paint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.5), w * 0.1, paint);
    paint.color = const Color(0xFF2D2D2D);
    canvas.drawCircle(Offset(w * 0.4, h * 0.51), w * 0.06, paint);
    canvas.drawCircle(Offset(w * 0.64, h * 0.51), w * 0.06, paint);
    paint.color = Colors.white;
    canvas.drawCircle(Offset(w * 0.42, h * 0.49), w * 0.025, paint);
    canvas.drawCircle(Offset(w * 0.66, h * 0.49), w * 0.025, paint);

    // Nose
    paint.color = const Color(0xFFFF8FAB);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.6), width: w * 0.1, height: h * 0.06), paint);

    // Smile
    final smilePath = Path()
      ..moveTo(w * 0.42, h * 0.65)
      ..quadraticBezierTo(w * 0.5, h * 0.72, w * 0.58, h * 0.65);
    canvas.drawPath(smilePath, Paint()
      ..color = const Color(0xFFFF8FAB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round);

    // Body
    paint.color = const Color(0xFFFDEEF1);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.88), width: w * 0.5, height: h * 0.28), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Section card ─────────────────────────────────────────────────────────────
class SectionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const SectionCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BouncyButton(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: color.withOpacity(0.3), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 44)),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.fredokaOne(fontSize: 18, color: color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: AppColors.textMid,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reward popup ─────────────────────────────────────────────────────────────
class RewardPopup extends StatefulWidget {
  final int stars;
  final String message;
  final VoidCallback onDismiss;

  const RewardPopup({
    super.key,
    required this.stars,
    required this.message,
    required this.onDismiss,
  });

  @override
  State<RewardPopup> createState() => _RewardPopupState();
}

class _RewardPopupState extends State<RewardPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _scale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(_ctrl);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('🎉', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 8),
                Text(
                  widget.message,
                  style: GoogleFonts.fredokaOne(
                      fontSize: 22, color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < widget.stars; i++) ...[
                    const Text('⭐', style: TextStyle(fontSize: 28)),
                    if (i < widget.stars - 1) const SizedBox(width: 4),
                  ],
                ]),
                const SizedBox(height: 6),
                Text(
                  '+${widget.stars} Stars!',
                  style: GoogleFonts.fredokaOne(
                      fontSize: 20, color: AppColors.secondary),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: BouncyButton(
                    onTap: widget.onDismiss,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, Color(0xFFFF9F43)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Text(
                        'Awesome! 🚀',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
}

// ── Progress row ─────────────────────────────────────────────────────────────
class ProgressRow extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;

  const ProgressRow({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label,
                style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: AppColors.textMid,
                    fontWeight: FontWeight.w700)),
            Text('$value / $max',
                style: GoogleFonts.fredokaOne(fontSize: 13, color: color)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: max > 0 ? value / max : 0,
              minHeight: 10,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      );
}
