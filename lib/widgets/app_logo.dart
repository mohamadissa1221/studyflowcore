import 'package:flutter/material.dart';
import '../core/colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 150});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 6),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/studyflowcore1.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
