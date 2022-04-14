import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_infos/outils/app_colors.dart';

class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;
  final double radius;
  const GlassMorphism(
      {Key? key,
      required this.blur,
      required this.opacity,
      required this.child,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).mode.isDark
                ? AppColors.primary.withOpacity(opacity)
                : Colors.grey.withOpacity(opacity),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            border: Border.all(
              width: 1.5,
              color: AppColors.primary.withOpacity(opacity),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
