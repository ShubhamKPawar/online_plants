// import 'package:equatable/equatable.dart';

abstract class CartEvent {
  const CartEvent();

  // @override
  // List<Object> get props => [];
}

class CartShowContainerEvent extends CartEvent {
  final bool showContainer;

  const CartShowContainerEvent(this.showContainer);

  // @override
  // List<Object> get props => [tabIndex];
}
