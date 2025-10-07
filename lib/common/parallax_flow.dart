import 'package:flutter/material.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageSize,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final Size backgroundImageSize;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: backgroundImageSize.width,
      height: backgroundImageSize.height,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.topCenter(Offset.zero),
      ancestor: scrollableBox,
    );

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

    final horizontalAlignment = Alignment(scrollFraction * 2 - 1, 0);

    final listItemSize = context.size;
    final childRect = horizontalAlignment.inscribe(
      backgroundImageSize,
      Offset.zero & listItemSize,
    );

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(childRect.left, 0)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageSize != oldDelegate.backgroundImageSize;
  }
}

// class ParallaxFlowDelegate extends FlowDelegate {
//   ParallaxFlowDelegate({
//     required this.scrollable,
//     required this.listItemContext,
//     required this.backgroundImageHeight,
//   }) : super(repaint: scrollable.position);

//   final ScrollableState scrollable;
//   final BuildContext listItemContext;
//   final double backgroundImageHeight;

//   @override
//   BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
//     // Fix height, allow width to be flexible
//     return BoxConstraints.tightFor(height: backgroundImageHeight);
//   }

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
//     final listItemBox = listItemContext.findRenderObject() as RenderBox;
//     final listItemOffset = listItemBox.localToGlobal(
//       listItemBox.size.topCenter(Offset.zero),
//       ancestor: scrollableBox,
//     );

//     final viewportDimension = scrollable.position.viewportDimension;
//     final scrollFraction =
//         (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

//     final horizontalAlignment = Alignment(scrollFraction * 2 - 1, 0);

//     final listItemSize = context.size;
//     final childSize = context.getChildSize(0) ?? Size.zero;

//     // Use actual child size for positioning
//     final childRect = horizontalAlignment.inscribe(
//       Size(200, 140),
//       Offset.zero & listItemSize,
//     );

//     context.paintChild(
//       0,
//       transform: Transform.translate(
//         offset: Offset(childRect.left, 0),
//       ).transform,
//     );
//   }

//   @override
//   bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
//     return scrollable != oldDelegate.scrollable ||
//         listItemContext != oldDelegate.listItemContext ||
//         backgroundImageHeight != oldDelegate.backgroundImageHeight;
//   }
// }
