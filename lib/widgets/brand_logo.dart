import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders assets/logo_vector.svg at the given size.
class BrandLogo extends StatelessWidget {
  final double size;
  final double borderRadius;

  const BrandLogo({
    super.key,
    required this.size,
    this.borderRadius = 0.28,
  });

  @override
  Widget build(BuildContext context) {
    final radius = size * borderRadius;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          'assets/logo_vector.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
