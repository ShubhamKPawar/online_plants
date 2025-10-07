import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/connectivity/orientation_state.dart';

class OrientationCubit extends Cubit<OrientationState> {
  OrientationCubit() : super(OrientationInitial()) {
    portraitUpdate();
  }

  void orientationUpdate(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      portraitUpdate();
    } else {
      landscapeUpdate();
    }
  }

  void portraitUpdate() {
    emit(OrientationPortrait());
  }

  void landscapeUpdate() {
    emit(OrientationLandscape());
  }
}
