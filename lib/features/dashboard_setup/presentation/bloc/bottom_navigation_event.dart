abstract class BottomNavigationEvent {
  const BottomNavigationEvent();
}

class BottomNavigationTabChanged extends BottomNavigationEvent {
  final int tabIndex;

  const BottomNavigationTabChanged(this.tabIndex);
}

class BottomNavigationPageChanged extends BottomNavigationEvent {
  final int tabIndex;

  const BottomNavigationPageChanged(this.tabIndex);
}
