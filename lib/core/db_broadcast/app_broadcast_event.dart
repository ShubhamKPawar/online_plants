import 'package:online_plants_app/core/db_broadcast/app_broadcast_listener.dart';

class AppBroadcastEvent {
  factory AppBroadcastEvent() => _instance;
  late List<AppEventListener> observers;

  AppBroadcastEvent.internal() {
    observers = <AppEventListener>[];
  }

  static final AppBroadcastEvent _instance = AppBroadcastEvent.internal();

  void subscribe(AppEventListener listener) {
    observers.add(listener);
  }

  void notify(dynamic state) {
    for (var obj in observers) {
      obj.onNewEventReceived(state);
    }
  }

  void dispose(AppEventListener thisObserver) {
    for (AppEventListener obj in observers) {
      if (obj == thisObserver) {
        observers.remove(obj);
      }
    }
  }
}
