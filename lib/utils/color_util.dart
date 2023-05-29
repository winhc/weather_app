import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  final Random random = Random();

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  List<Color> getRandomGradient() {
    final color1 = _getRandomColor();
    final color2 = _getRandomColor();
    return [color1, color2];
  }
}
