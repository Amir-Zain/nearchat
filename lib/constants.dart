import 'dart:ui';

class Constants {
  static double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;
  static double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;
  static double screenHeightSafearea = screenHeight -
      ((window.padding.top / window.devicePixelRatio) +
          (window.padding.bottom / window.devicePixelRatio));

  static double blockSizeHorizontal = screenWidth / 100;
  static double blockSizeVertical = screenHeight / 100;
}
