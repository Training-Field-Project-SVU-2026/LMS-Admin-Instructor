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

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1024;
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}
