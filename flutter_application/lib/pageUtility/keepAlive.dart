import 'dart:async';

class KeepAliveService {
  Timer? _keepAliveTimer;

  void startKeepAliveTimer(Function() sendKeepAlive) {
    _keepAliveTimer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      sendKeepAlive();
    });
  }

  void stopKeepAliveTimer() {
    if (_keepAliveTimer != null) {
      _keepAliveTimer!.cancel();
      _keepAliveTimer = null;
    }
  }
}
