// Tıbbi motif içeren dekoratif arka plan widget'ı.
// Tüm ekranlarda ortak arka plan olarak kullanılır.

import 'package:diyabetansiyon/core/constants/app_constants.dart';
import 'package:diyabetansiyon/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class HealthBackground extends StatelessWidget {
  final Widget child;

  const HealthBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.background),
        Opacity(
          opacity: 0.04,
          child: Image.asset(
            AppConstants.healthPatternPath,
            repeat: ImageRepeat.repeat,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.none,
            alignment: Alignment.topLeft,
          ),
        ),
        child,
      ],
    );
  }
}
