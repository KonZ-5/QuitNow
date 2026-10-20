import 'package:flutter/material.dart';
import '../theme.dart';

class NeoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Widget? icon;
  final bool fullWidth;

  // PERBAIKAN: Mengubah gaya penulisan konstruktor lama menjadi super.key yang ringkas
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
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: 18),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.ink,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: 9),
              widget.icon!,
            ],
          ],
        ),
      ),
    );
  }
}
