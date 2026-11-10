import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// Membatasi lebar konten dan menempatkannya di tengah.
///
/// CONSTRAINT: [ConstrainedBox] mengubah constraint yang diterima child
/// menjadi `maxWidth <= maxWidth`. Di ponsel (lebar < maxWidth) child
/// mengisi seluruh lebar; di tablet/web child berhenti di [maxWidth].
class CenteredContent extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const CenteredContent({
    super.key,
    required this.child,
    this.maxWidth = 840,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        // width: infinity akan "di-clamp" oleh ConstrainedBox menjadi
        // min(maxWidth, lebar parent) sehingga child selalu selebar mungkin.
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}

/// Layout adaptif: 1 kolom (vertikal) pada ruang sempit,
/// 2 kolom (berdampingan) pada ruang lebar / landscape.
///
/// Keputusan memakai [LayoutBuilder], yaitu constraint dari PARENT, bukan
/// lebar layar penuh. Dengan begitu widget tetap benar walau berada di
/// dalam panel yang lebih sempit dari layar (mis. di samping SideNav).
class AdaptiveColumns extends StatelessWidget {
  /// Widget kolom kiri (atau bagian atas pada 1 kolom).
  final List<Widget> primary;

  /// Widget kolom kanan (atau bagian bawah pada 1 kolom).
  final List<Widget> secondary;

  /// Lebar minimum dari parent agar memakai 2 kolom.
  final double breakpoint;

  /// Jarak antar kolom / antar bagian.
  final double gap;

  /// Perbandingan lebar kolom pada mode 2 kolom.
  final int primaryFlex;
  final int secondaryFlex;

  const AdaptiveColumns({
    super.key,
    required this.primary,
    required this.secondary,
    this.breakpoint = 560,
    this.gap = 24,
    this.primaryFlex = 1,
    this.secondaryFlex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: primaryFlex,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: primary,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                flex: secondaryFlex,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: secondary,
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...primary,
            SizedBox(height: gap),
            ...secondary,
          ],
        );
      },
    );
  }
}


/// Pengganti [Row] yang menjadi 1 KOLOM (vertikal) pada layar 220 - 330 dp.
///
/// Pemakaian sama seperti Row. Pada mode tumpuk:
///  - [Expanded]/[Flexible] dilepas (child dipakai langsung), karena di
///    dalam Column, Expanded akan mencoba mengisi tinggi tak terbatas.
///  - `SizedBox(width: n)` (jarak horizontal) diubah menjadi `SizedBox(height: n)`.
///  - Anak-anak diratakan ke kiri ([stackAlignment]).
class AdaptiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment stackAlignment;

  /// Paksa mode tumpuk (true) / baris (false). Null = otomatis dari lebar layar.
  final bool? forceStack;

  const AdaptiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.stackAlignment = CrossAxisAlignment.start,
    this.forceStack,
  });

  static Widget _toStacked(Widget w) {
    if (w is Flexible) return w.child;
    if (w is SizedBox && w.width != null && w.height == null && w.child == null) {
      return SizedBox(height: w.width);
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    final bool stacked = forceStack ?? Responsive.of(context).isStacked;

    if (!stacked) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: stackAlignment,
      children: children.map(_toStacked).toList(),
    );
  }
}
