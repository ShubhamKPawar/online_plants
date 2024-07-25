// import 'package:equatable/equatable.dart';

abstract class BottomNavigationState {
  const BottomNavigationState();

  // @override
  // List<Object> get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {}

class BottomNavigationTabState extends BottomNavigationState {
  final int tabIndex;

  const BottomNavigationTabState(this.tabIndex);

  // @override
  // List<Object> get props => [tabIndex];
}
