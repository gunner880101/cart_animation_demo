import 'package:cart_animation_demo/utils/path_util.dart';
import 'package:flutter/material.dart';

class ProductFloatingImage extends StatefulWidget {
  final String imageName;
  final Offset startPos;
  final Offset endPos;
  final double imageSize;
  final Function onAnimationEnd;
  const ProductFloatingImage({
    super.key,
    required this.imageName,
    required this.startPos,
    required this.endPos,
    required this.imageSize,
    required this.onAnimationEnd,
  });

  @override
  State<ProductFloatingImage> createState() => _ProductFloatingImageState();
}

class _ProductFloatingImageState extends State<ProductFloatingImage>
    with TickerProviderStateMixin {
  late Path _path;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _path = createTossAnimationPath(start: widget.startPos, end: widget.endPos);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    Animation animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onAnimationEnd();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: calculatePos(_controller.value).dx,
      top: calculatePos(_controller.value).dy,
      child: Image.asset(
        widget.imageName,
        width: calculateSize(_controller.value),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Offset calculatePos(double value) {
    final metrics = _path.computeMetrics();
    final metric = metrics.elementAt(0);
    final offset = value * metric.length;
    return metric.getTangentForOffset(offset)!.position;
  }

  double calculateSize(double value) => _controller.value < 0.5
      ? widget.imageSize
      : widget.imageSize * (1.5 - _controller.value);
}
