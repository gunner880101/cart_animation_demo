import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class TossAnimationPainter extends CustomPainter {
  final Animation<double> animation;
  final bool? isAnimating;
  final Offset? startPosition;
  final Offset? endPosition;

  TossAnimationPainter({
    required this.animation,
    this.isAnimating,
    this.startPosition,
    this.endPosition,
  }) : super(repaint: animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(0, size.height / 4)
      ..quadraticBezierTo(
        size.width / 3,
        -size.height / 4,
        size.width,
        size.height,
      );
  }

  // load the image async and then draw with `canvas.drawImage(image, Offset.zero, Paint());`
  Future<ui.Image> loadImageAsset(String assetName) async {
    final data = await rootBundle.load(assetName);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = animation.value;

    if (animationPercent == 0 || animationPercent == 1) return;

    // final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.0;

    // canvas.drawPath(path, paint);

    final metrics = _createAnyPath(size).computeMetrics();
    final metric = metrics.elementAt(0);
    final offset = animationPercent * metric.length;
    if (metric.getTangentForOffset(offset) == null) return;
    final pos = metric.getTangentForOffset(offset)!.position;
    final radius = 20 * (1 - animation.value);
    canvas.drawCircle(pos, radius, paint..color = Colors.blue);
    // loadImageAsset('assets/images/pic1.jpg')
    //     .then((image) => canvas.drawImage(image, pos, paint));
  }

  @override
  bool shouldRepaint(TossAnimationPainter oldDelegate) {
    return true;
  }

  Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    // ComputeMetrics can only be iterated once!
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, ui.PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        // There might be a more efficient way of extracting an entire path
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }
}
