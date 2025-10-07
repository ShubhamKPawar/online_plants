import 'dart:async';

class LanguageChangeNotifier {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onLanguageChanged => _controller.stream;

  void notifyLanguageChanged() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
