import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';
import 'package:online_plants_app/features/login/domain/usecase/Login_image_usecase.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_event.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginImageUseCase _imageUseCase;

  LoginBloc({
    required LoginImageUseCase imageUseCase,
  })  : _imageUseCase = imageUseCase,
        super(LoginInitial()) {
    on<LoginImageEvent>(_onFetchLoginImages);
  }

  // Handler for LoginImageEvent
  Future<void> _onFetchLoginImages(
      LoginImageEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final response = await _imageUseCase(NoParams());
    response.fold(
      (failure) => emit(FailureLoginState(failure.exception)),
      (success) => emit(LoginImageListState(success)),
    );
  }
}
