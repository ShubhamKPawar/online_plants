abstract class BottomNavigationState {
  const BottomNavigationState();
}

class BottomNavigationInitial extends BottomNavigationState {}

class BottomNavigationTabState extends BottomNavigationState {
  final int tabIndex;

  const BottomNavigationTabState(this.tabIndex);
}

class BottomNavigationPageChangeState extends BottomNavigationState {
  final int tabIndex;

  const BottomNavigationPageChangeState(this.tabIndex);
}
