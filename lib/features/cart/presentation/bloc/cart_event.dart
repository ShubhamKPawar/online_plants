abstract class CartEvent {
  const CartEvent();
}

class CartShowContainerEvent extends CartEvent {
  final bool showContainer;

  const CartShowContainerEvent(this.showContainer);
}

class AddToCartEvent extends CartEvent {
  const AddToCartEvent();
}
