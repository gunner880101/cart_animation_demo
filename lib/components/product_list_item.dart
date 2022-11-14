import 'package:cart_animation_demo/components/product_floating_image.dart';
import 'package:cart_animation_demo/constants.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatefulWidget {
  final int index;
  final GlobalKey fabKey;
  const ProductListItem({super.key, required this.index, required this.fabKey});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  final GlobalKey imageKey = GlobalKey();
  OverlayState? overlayState;
  late OverlayEntry overlayEntry;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        RenderBox renderBox =
            widget.fabKey.currentContext!.findRenderObject() as RenderBox;
        Offset endPos = renderBox.localToGlobal(Offset.zero);
        endPos += Offset(
          renderBox.size.width / 2 - imageWidth / 4,
          renderBox.size.height / 2 - imageWidth / 4,
        );
        renderBox = imageKey.currentContext!.findRenderObject() as RenderBox;
        Offset startPos = renderBox.localToGlobal(Offset.zero);

        overlayState = Overlay.of(context);
        overlayEntry = OverlayEntry(builder: (context) {
          return ProductFloatingImage(
            imageName: fruitImages[widget.index % 5],
            startPos: startPos,
            endPos: endPos,
            imageSize: imageWidth,
            onAnimationEnd: () {
              overlayEntry.remove();
            },
          );
        });
        overlayState?.insert(overlayEntry);
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
