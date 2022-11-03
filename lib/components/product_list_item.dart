import 'package:cart_animation_demo/constants.dart';
import 'package:cart_animation_demo/providers/widget_key_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListItem extends StatefulWidget {
  final int index;
  const ProductListItem({super.key, required this.index});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  final GlobalKey imageKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<WidgetKeyProvider>(context, listen: false).startAnimation(
          imageKey: imageKey,
          imageName: fruitImages[widget.index % 5],
        );
      },
      child: Row(
        children: [
          Image.asset(
            fruitImages[widget.index % 5],
            key: imageKey,
            width: imageWidth,
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            child: Text(
              fruitTitles[widget.index % 5],
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
