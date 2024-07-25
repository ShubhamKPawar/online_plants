// ignore_for_file: constant_identifier_names

abstract class AppEventListener {
  void onNewEventReceived(AppEvent state);
}

enum AppEvent {
  USER_LOGIN,
}
