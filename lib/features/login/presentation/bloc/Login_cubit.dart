import 'package:bloc/bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_cubit_bloc.dart';

class LoginCubit extends Cubit<LoginCubitBloc> {
  LoginCubit()
      : super(LoginCubitBloc(
          currentPage: 0,
        ));

  void changeCurrentPage(int value) {
    emit(state.copyWith(currentPage: value));
  }
}
