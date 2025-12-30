import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:flutter/material.dart';

class CorpoMateriaisWidget extends StatelessWidget {
  const CorpoMateriaisWidget({super.key, required this.corpo});

  final List<Widget> corpo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PhysicalShape(
        clipper: _PontasBaixoClipper(radius: 20, notchDepth: 70, triangles: 4, sidePadding: 0),
        color: AppCores.violetaClaroPairado,
        elevation: 10,
        shadowColor: AppCores.cinza,
        child: SizedBox(
          height: 600,
          width: .infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(crossAxisAlignment: .start, children: corpo),
          ),
        ),
      ),
    );
  }
}

class _PontasBaixoClipper extends CustomClipper<Path> {
  final double radius;
  final double notchDepth;
  final int triangles;
  final double sidePadding;

  _PontasBaixoClipper({
    required this.radius,
    required this.notchDepth,
    required this.triangles,
    required this.sidePadding,
  });

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    final double usableWidth = (size.width - 2 * sidePadding).clamp(0.0, size.width);
    final double notchWidth = triangles > 0 ? usableWidth / triangles : usableWidth;

    double x = size.width - sidePadding;
    path.lineTo(x, size.height - notchDepth);

    for (int i = 0; i < triangles; i++) {
      final double tipX = x - notchWidth / 2;
      path.lineTo(tipX, size.height);
      x -= notchWidth;
      path.lineTo(x, size.height - notchDepth);
    }

    path.lineTo(sidePadding, size.height - notchDepth);
    path.lineTo(0, radius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _PontasBaixoClipper oldClipper) {
    return oldClipper.radius != radius ||
        oldClipper.notchDepth != notchDepth ||
        oldClipper.triangles != triangles ||
        oldClipper.sidePadding != sidePadding;
  }
}
