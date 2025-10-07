import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/size.dart';

class AnimateProductToCart extends StatefulWidget {
  final Offset productPosition;
  final Offset cartPosition;
  final VoidCallback onAnimationEnd;
  final String heroKey;
  final String url;

  const AnimateProductToCart({
    super.key,
    required this.productPosition,
    required this.cartPosition,
    required this.onAnimationEnd,
    required this.heroKey,
    required this.url,
  });

  @override
  _AnimateProductToCart createState() => _AnimateProductToCart();
}

class _AnimateProductToCart extends State<AnimateProductToCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    // Animation for position (moving the image)
    _animation = Tween<Offset>(
      begin: widget.productPosition,
      end: widget.cartPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Animation for size (scaling the image)
    _scaleAnimation = Tween<double>(
      begin: 2.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().whenComplete(() => widget.onAnimationEnd());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: Opacity(
            opacity: 1 - _controller.value,
            child: Hero(
              tag: widget.heroKey,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getHeight(15)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    widget.url,
                    fit: BoxFit.cover,
                    width: 30 * _scaleAnimation.value,
                    height: 30 * _scaleAnimation.value,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
