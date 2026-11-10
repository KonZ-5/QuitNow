import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class NeoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Widget? icon;
  final bool fullWidth;

  const NeoButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.green,
    this.icon,
    this.fullWidth = true,
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    final label = Text(
      widget.text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.bold,
        fontSize: r.isUltraNarrow ? 14 : 16,
        color: AppColors.ink,
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.fullWidth ? double.infinity : null,
        constraints: BoxConstraints(minHeight: r.isUltraNarrow ? 46 : 52),
        padding: EdgeInsets.symmetric(
          horizontal: r.isUltraNarrow ? 10 : 18,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: AppColors.ink, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink,
              offset: _isPressed ? const Offset(1, 1) : const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        transform: Matrix4.translationValues(
          _isPressed ? 3.0 : 0.0,
          _isPressed ? 3.0 : 0.0,
          0.0,
        ),
        // CONSTRAINT: LayoutBuilder memeriksa apakah parent memberi lebar
        // terbatas. Jika ya, teks dibungkus Flexible sehingga membungkus
        // baris (wrap) alih-alih overflow. Jika parent memberi lebar tak
        // terbatas (mis. langsung di dalam Row), teks tampil apa adanya
        // karena Flexible di lebar tak terbatas akan menimbulkan error.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool bounded = constraints.hasBoundedWidth;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize:
                  widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              children: [
                bounded ? Flexible(child: label) : label,
                if (widget.icon != null) ...[
                  SizedBox(width: r.isUltraNarrow ? 6 : 9),
                  widget.icon!,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
