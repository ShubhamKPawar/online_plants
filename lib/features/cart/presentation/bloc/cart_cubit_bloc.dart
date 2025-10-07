class CartCubitBloc {
  final bool showContainer;
  final int itemCount;

  CartCubitBloc({
    required this.showContainer,
    required this.itemCount,
  });

  // Copy constructor to facilitate state updates
  CartCubitBloc copyWith({
    bool? showContainer,
    int? itemCount,
  }) {
    return CartCubitBloc(
      showContainer: showContainer ?? this.showContainer,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
