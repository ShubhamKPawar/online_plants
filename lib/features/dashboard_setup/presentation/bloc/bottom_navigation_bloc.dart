import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_event.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial()) {
    on<BottomNavigationTabChanged>((event, emit) {
      emit(BottomNavigationTabState(event.tabIndex));
    });
  }
}
