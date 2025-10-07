abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartContainerState extends CartState {
  final bool showContainer;

  const CartContainerState(this.showContainer);
}

class AddToCartState extends CartState {
  const AddToCartState();
}
