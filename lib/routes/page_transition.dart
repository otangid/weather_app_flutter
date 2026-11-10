import 'package:material_ui/material_ui.dart';

class PageTransition extends PageTransitionsBuilder {
  const PageTransition();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 1. Animasi Masuk: Halaman baru membesar dari 0.85 ke 1.0 (Zoom In)
    final zoomIn = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut, // Membuat pergerakan melambat di akhir agar halus
      ),
    );

    // 2. Animasi Keluar: Halaman lama mengecil dari 1.0 ke 1.15 (Zoom Out menjauh)
    // Atau bisa diatur 1.0 ke 0.95 jika ingin efek menumpuk ke belakang
    final zoomOut = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut));

    // 3. Gabungkan: Zoom In (Halaman Baru) + Fade + Zoom Out (Halaman Lama)
    return ScaleTransition(
      scale: zoomIn,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: zoomOut, child: child),
      ),
    );
  }
}
