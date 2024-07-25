import 'package:bloc/bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit_bloc.dart';

class CartCubit extends Cubit<CartCubitBloc> {
  CartCubit()
      : super(CartCubitBloc(
          showContainer: false,
          // showText: false, counter: 0
        ));

  void toggleShowContainer(bool value) {
    emit(state.copyWith(showContainer: value));
  }

  // void toggleShowText() {
  //   emit(state.copyWith(showText: !state.showText));
  // }

  // void incrementCounter() {
  //   emit(state.copyWith(counter: state.counter + 1));
  // }

  // void decrementCounter() {
  //   emit(state.copyWith(counter: state.counter - 1));
  // }
}
