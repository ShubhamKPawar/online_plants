class LoginCubitBloc {
  final int currentPage;
  // final bool showText;
  // final int counter;

  LoginCubitBloc({
    required this.currentPage,
    // required this.showText,
    // required this.counter,
  });

  // Copy constructor to facilitate state updates
  LoginCubitBloc copyWith({
    int? currentPage,
  }) {
    return LoginCubitBloc(
      currentPage: currentPage ?? 0,
    );
  }
}
