import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/services_data/domain/usecases/user_usecase.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_event.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_state.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';
import 'package:online_plants_app/features/login/domain/usecase/login_usecase.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final HivePref _hivePref;
  final GetUserUsecase _getUserUsecase;
  final AddUpdateUserUsecase _addUpdateUserUsecase;
  final ChangeUserPasswordUseCase _changeUserPasswordUsercase;
  final LoginImageUseCase _imageUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final AppleLoginUseCase _appleLoginUseCase;

  UserInfoBloc({
    required HivePref hivepref,
    required GetUserUsecase getUserUsecase,
    required AddUpdateUserUsecase addUpdateUserUsecase,
    required ChangeUserPasswordUseCase changePasswordUsecase,
    required LoginImageUseCase imageUseCase,
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleLoginUseCase googleLoginUseCase,
    required AppleLoginUseCase appleLoginUseCase,
  })  : _getUserUsecase = getUserUsecase,
        _addUpdateUserUsecase = addUpdateUserUsecase,
        _hivePref = hivepref,
        _changeUserPasswordUsercase = changePasswordUsecase,
        _imageUseCase = imageUseCase,
        _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _appleLoginUseCase = appleLoginUseCase,
        super(UserInitial()) {
    on<GetUserInfoEvent>(_onGetUser);
    on<AddUpdateUserInfoEvent>(_onAddEditUser);
    on<ChangePasswordEvent>(_onChangePassword);
    on<LoginImageEvent>(_onFetchLoginImages);
    on<UserLoginEvent>(_onLoginUser);
    on<UserRegisterEvent>(_onRegisterUser);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<AppleSignInEvent>(_onAppleSignIn);
    on<UserLoggedOutEvent>(_onLoggedOut);
  }

  Future<void> _onGetUser(
      GetUserInfoEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(UserLoading());

      bool isLoggedIn = _hivePref.getIsLoggedIn();
      if (isLoggedIn) {
        String uid = _hivePref.getUserId();
        String email = _hivePref.getUserEmail();
        if (uid.isNotEmpty && email.isNotEmpty) {
          print('get user info.....');
          final response = await _getUserUsecase([uid, email]);
          emit(LoggedInSuccess());
          response.fold(
            (failure) => emit(UserFailure(failure.exception)),
            (success) => emit(GetUserInfoSuccess(success)),
          );
        } else {
          print('11111.');
          _hivePref.setIsLoggedIn(false);
          emit(GetUserInfoSuccess(null));
          emit(LoggedOutSuccess());
        }
      } else {
        print('222222...');
        emit(GetUserInfoSuccess(null));
        emit(LoggedOutSuccess());
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> _onAddEditUser(
      AddUpdateUserInfoEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(UserLoading());
      final response = await _addUpdateUserUsecase(event.model);
      response.fold(
        (failure) => emit(UserFailure(failure.exception)),
        (success) => emit(AddUpdateUserInfoSuccess(success)),
      );
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  Future<void> _onChangePassword(
      ChangePasswordEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(UserLoading());
      final response = await _changeUserPasswordUsercase(
          [event.email, event.previousPassword, event.currentPassword]);
      response.fold(
        (failure) => emit(UserFailure(failure.exception)),
        (success) => emit(ChangePasswordState(success)),
      );
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  // Handler for LoginImageEvent
  Future<void> _onFetchLoginImages(
      LoginImageEvent event, Emitter<UserInfoState> emit) async {
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
      UserLoginEvent event, Emitter<UserInfoState> emit) async {
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
      UserRegisterEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(LoginLoadingState());
      List<String> data = [
        event.email,
        event.password,
        event.userName,
        event.mobileNo,
      ];
      if (data.length > 3) {
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
      GoogleSignInEvent event, Emitter<UserInfoState> emit) async {
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
      AppleSignInEvent event, Emitter<UserInfoState> emit) async {
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

  Future<void> _onLoggedOut(
      UserLoggedOutEvent event, Emitter<UserInfoState> emit) async {
    if (event.isSkip) {
      await _hivePref.clearAllData();
      _hivePref.setIsGuest(true);
    } else {
      _hivePref.clearAllData();
    }
    add(GetUserInfoEvent());
    emit(LoggedOutSuccess());
  }
}
