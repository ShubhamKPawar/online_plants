import 'package:bloc/bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit_bloc.dart';

class CartCubit extends Cubit<CartCubitBloc> {
  CartCubit()
      : super(CartCubitBloc(
          showContainer: false,
          itemCount: 0,
        ));

  void toggleShowContainer(bool value) {
    emit(state.copyWith(showContainer: value));
  }

  void addToCart() {
    int count = state.itemCount + 1;
    emit(state.copyWith(itemCount: count));
  }
}
