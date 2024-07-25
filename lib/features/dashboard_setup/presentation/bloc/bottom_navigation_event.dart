// import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent {
  const BottomNavigationEvent();

  // @override
  // List<Object> get props => [];
}

class BottomNavigationTabChanged extends BottomNavigationEvent {
  final int tabIndex;

  const BottomNavigationTabChanged(this.tabIndex);

  // @override
  // List<Object> get props => [tabIndex];
}
