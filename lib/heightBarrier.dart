import 'dart:math';

import 'package:game/constant.dart';

class values {
  static Random random = new Random();
  static double fixValue = heightScreen / 2;
  static double temp = fixValue - 200;
  static int heightUp;
  static int heightDown;
  static double canal = 150;

  static double getUp() {
    heightUp = 50 + random.nextInt(fixValue.toInt() - 50);
    return heightUp.toDouble();
  }

  static double getDown(double Up) {
    heightDown = heightScreen.toInt() - heightUp - canal.toInt();
    return heightDown.toDouble();
  }
}
