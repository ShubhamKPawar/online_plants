class CartCubitBloc {
  final bool showContainer;
  // final bool showText;
  // final int counter;

  CartCubitBloc({
    required this.showContainer,
    // required this.showText,
    // required this.counter,
  });

  // Copy constructor to facilitate state updates
  CartCubitBloc copyWith({
    bool? showContainer,
    // bool? showText,
    // int? counter,
  }) {
    return CartCubitBloc(
      showContainer: showContainer ?? this.showContainer,
      // showText: showText ?? this.showText,
      // counter: counter ?? this.counter,
    );
  }
}
