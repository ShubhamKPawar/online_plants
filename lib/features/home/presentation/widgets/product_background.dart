import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_bloc.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_event.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_state.dart';

class ProductBackgroundColor extends StatefulWidget {
  final String imageUrl;

  const ProductBackgroundColor({super.key, required this.imageUrl});

  @override
  State<ProductBackgroundColor> createState() => _ProductBackgroundColorState();
}

class _ProductBackgroundColorState extends State<ProductBackgroundColor> {
  Color backgroundColor = const Color(0xff2b2b2b);

  @override
  void initState() {
    super.initState();
    // Dispatch the event once in initState()
    fetchData();
  }

  fetchData() {
    BlocProvider.of<ProductImageBloc>(context)
        .add(GetProductColorEvent(url: widget.imageUrl));
  }

  @override
  void didUpdateWidget(ProductBackgroundColor oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductImageBloc, ProductImageState>(
      listenWhen: (previous, current) =>
          current is GetProductColorState || current is FailureGetProductState,
      listener: (context, state) {
        // if (state is GetProductColorState) {
        //   // setState(() {
        //   backgroundColor = Color(state.color); // Correctly update color
        //   // });
        // } else if (state is FailureGetProductState) {
        //   // setState(() {
        //   backgroundColor = Colors.black;
        //   // });
        // }
      },
      builder: (context, state) {
        if (state is GetProductColorState) {
          backgroundColor = Color(state.color);
        }
        if (state is FailureGetProductState) {
          backgroundColor = Colors.black;
        }
        return TweenAnimationBuilder<Color?>(
          tween: ColorTween(begin: backgroundColor, end: backgroundColor),
          duration: const Duration(milliseconds: 500),
          builder: (context, color, child) {
            return AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: color ?? backgroundColor,
              ),
              duration: const Duration(milliseconds: 300),
            );
          },
        );
      },
    );
  }
}
