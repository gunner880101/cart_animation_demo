import 'package:cart_animation_demo/constants.dart';
import 'package:flutter/material.dart';

class ProductFloatingImage extends StatefulWidget {
  final int index;
  const ProductFloatingImage({super.key, required this.index});

  @override
  State<ProductFloatingImage> createState() => _ProductFloatingImageState();
}

class _ProductFloatingImageState extends State<ProductFloatingImage>
    with TickerProviderStateMixin {
  late double left;
  late double top;
  late double size;

  @override
  void initState() {
    super.initState();

    left = 0;
    top = 0;
    size = 150;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: left,
      top: top,
      duration: const Duration(seconds: 3),
      child: GestureDetector(
        onTap: () {},
        child: Image.asset(
          fruitImages[widget.index],
          width: size,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
