import 'package:online_plants_app/core/db_broadcast/app_broadcast_listener.dart';

class AppEventBroadcaster {
  factory AppEventBroadcaster() => _instance;
  late List<AppEventListener> observers;

  AppEventBroadcaster.internal() {
    observers = <AppEventListener>[];
  }
  static final AppEventBroadcaster _instance = AppEventBroadcaster.internal();

  void subscribe(AppEventListener listener) {
    if (!observers.contains(listener)) {
      observers.add(listener);
    }
  }

  void notify(dynamic state) {
    for (AppEventListener obj in observers) {
      obj.onNewEventReceived(state);
    }
  }

  void dispose(AppEventListener thisObserver) {
    observers.removeWhere((obj) {
      if (obj == thisObserver) {
        return true; // Remove the observer
      }
      return false;
    });
  }
}
