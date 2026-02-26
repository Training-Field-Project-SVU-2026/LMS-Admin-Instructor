// double getResponsiveSize({
//   required double webSize,
//   required double tabletSize,
//   required double mobileSize,
//   required double width,
// }) {
//   if (width > 1024) {
//     return webSize; // Web / Desktop
//   } else if (width >= 600) {
//     return tabletSize; // Tablet
//   } else {
//     return mobileSize; // Mobile
//   }
// }
import 'package:flutter/widgets.dart';

double getResponsiveSize({
  required BuildContext context,
  required double webSize,
  required double tabletSize,
  required double mobileSize,
}) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 1024) {
    return webSize; // Desktop / Web
  } else if (width >= 600) {
    return tabletSize; // Tablet
  } else {
    return mobileSize; // Mobile
  }
}
