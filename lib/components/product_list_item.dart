import 'package:cart_animation_demo/constants.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatefulWidget {
  final int index;
  const ProductListItem({super.key, required this.index});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          fruitImages[widget.index % 5],
          width: 100,
          fit: BoxFit.fitWidth,
        ),
        Expanded(
          child: Text(
            fruitTitles[widget.index % 5],
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
