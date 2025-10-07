import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/connectivity/connectivity_helper.dart';
import 'package:online_plants_app/core/connectivity/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  StreamSubscription<bool>? _subscription;

  ConnectivityCubit() : super(ConnectivityOnline()) {
    _initializeConnection();
  }

  // Initialize connection state and subscribe to changes
  void _initializeConnection() async {
    final isConnected = await ConnectivityHelper.isConnected();
    emit(isConnected ? ConnectivityOnline() : ConnectivityOffline());

    // Listen for connection state changes
    _subscription =
        ConnectivityHelper.onIsConnectedChanged().listen((connected) {
      emit(connected ? ConnectivityOnline() : ConnectivityOffline());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel(); // Cancel subscription when disposing
    return super.close();
  }
}
