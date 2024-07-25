// import 'package:equatable/equatable.dart';

abstract class CartState {
  const CartState();

  // @override
  // List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartContainerState extends CartState {
  final bool showContainer;

  const CartContainerState(this.showContainer);

  // @override
  // List<Object> get props => [tabIndex];
}
