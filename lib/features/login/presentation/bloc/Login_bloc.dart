import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';
import 'package:online_plants_app/features/login/domain/usecase/login_usecase.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_event.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginImageUseCase _imageUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final AppleLoginUseCase _appleLoginUseCase;

  LoginBloc({
    required LoginImageUseCase imageUseCase,
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleLoginUseCase googleLoginUseCase,
    required AppleLoginUseCase appleLoginUseCase,
  })  : _imageUseCase = imageUseCase,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _appleLoginUseCase = appleLoginUseCase,
        super(LoginInitial()) {
    on<LoginImageEvent>(_onFetchLoginImages);
    on<UserLoginEvent>(_onLoginUser);
    on<UserRegisterEvent>(_onRegisterUser);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<AppleSignInEvent>(_onAppleSignIn);
  }

  // Handler for LoginImageEvent
  Future<void> _onFetchLoginImages(
      LoginImageEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoadingState());
      final response = await _imageUseCase(NoParams());
      response.fold(
        (failure) => emit(FailureLoginState(failure.exception)),
        (success) => emit(LoginImageListState(success)),
      );
    } catch (e) {
      emit(FailureLoginState(e.toString()));
    }
  }

//Handle login state
  Future<void> _onLoginUser(
      UserLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      List<String> data = [event.email, event.password];
      if (data.length > 1) {
        final response = await _loginUseCase([event.email, event.password]);
        response.fold(
          (failure) => emit(LoginFailureState(failure.exception)),
          (success) => emit(LoginUserState(success)),
        );
      } else {
        emit(LoginFailureState('Less data'));
      }
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  //Handle register state
  Future<void> _onRegisterUser(
      UserRegisterEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      List<String> data = [event.email, event.password, event.userName];
      if (data.length > 2) {
        final response = await _registerUseCase(data);
        response.fold(
          (failure) => emit(LoginFailureState(failure.exception)),
          (success) => emit(RegisterUserState(success)),
        );
      } else {
        emit(LoginFailureState('Less data'));
      }
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  //handle google sign in
  Future<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      final response = await _googleLoginUseCase(NoParams());
      response.fold(
        (failure) => emit(LoginFailureState(failure.exception)),
        (success) => emit(GoogleLoginState(success)),
      );
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  //handle apple sign in
  Future<void> _onAppleSignIn(
      AppleSignInEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      final response = await _appleLoginUseCase(NoParams());
      response.fold(
        (failure) => emit(LoginFailureState(failure.exception)),
        (success) => emit(AppleLoginState(success)),
      );
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
