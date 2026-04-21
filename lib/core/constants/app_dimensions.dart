// Ekran boyutuna göre ölçeklenen padding, font ve boyut sabitleri.
// Responsive tasarım için tek kaynak noktası.

import 'package:flutter/widgets.dart';

class AppDimensions {
  AppDimensions._();

  static double scaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width / 390).clamp(0.8, 1.3);
  }

  static double fontXS(BuildContext context) => 10 * scaleFactor(context);
  static double fontSM(BuildContext context) => 12 * scaleFactor(context);
  static double fontMD(BuildContext context) => 14 * scaleFactor(context);
  static double fontLG(BuildContext context) => 16 * scaleFactor(context);
  static double fontXL(BuildContext context) => 20 * scaleFactor(context);
  static double fontXXL(BuildContext context) => 24 * scaleFactor(context);

  static double spacingXS(BuildContext context) => 4 * scaleFactor(context);
  static double spacingSM(BuildContext context) => 8 * scaleFactor(context);
  static double spacingMD(BuildContext context) => 16 * scaleFactor(context);
  static double spacingLG(BuildContext context) => 24 * scaleFactor(context);
  static double spacingXL(BuildContext context) => 32 * scaleFactor(context);

  static EdgeInsets screenPadding(BuildContext context) => EdgeInsets.fromLTRB(
    spacingMD(context),
    spacingMD(context),
    spacingMD(context),
    100,
  );

  static double cardRadius(BuildContext context) => 16 * scaleFactor(context);
  static double cardPadding(BuildContext context) => 16 * scaleFactor(context);

  static double chartHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return (height * 0.28).clamp(180, 260);
  }

  static double iconSM(BuildContext context) => 16 * scaleFactor(context);
  static double iconMD(BuildContext context) => 22 * scaleFactor(context);
  static double iconLG(BuildContext context) => 28 * scaleFactor(context);

  static double inputHeight(BuildContext context) => 52 * scaleFactor(context);
  static double inputRadius(BuildContext context) => 12 * scaleFactor(context);

  static double statCardHeight(BuildContext context) => 90 * scaleFactor(context);
}
