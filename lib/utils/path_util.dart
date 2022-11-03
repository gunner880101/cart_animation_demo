import 'dart:math';

import 'package:flutter/material.dart';

Path createTossAnimationPath({
  required Offset start,
  required Offset end,
}) {
  final controlPoint = Offset(
    (start.dx + end.dx) / 2,
    min(start.dy, end.dy) - 100,
  );
  return Path()
    ..moveTo(start.dx, start.dy)
    ..quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      end.dx,
      end.dy,
    );
}
