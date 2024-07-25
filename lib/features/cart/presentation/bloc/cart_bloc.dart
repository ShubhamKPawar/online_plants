import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartShowContainerEvent>((event, emit) {
      emit(CartContainerState(event.showContainer));
    });
  }
}
