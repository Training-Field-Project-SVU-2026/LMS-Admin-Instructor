double getResponsiveSize({
  required double webSize,
  required double mobileSize,
  required double width,
}) {
  if (width > 1024) {
    return webSize; // Web / Desktop
  } else {
    return mobileSize; // Mobile
  }
}
