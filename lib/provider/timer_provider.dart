import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timeout/utils/enums.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;

  //timeout status to help determine logout
  TimeoutStatus timeoutStatus = TimeoutStatus.idle;

  //count down timer to logout user out
  void startTimer() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(minutes: 5), logout);
    notifyListeners();
  }

  //stops timer and sets status
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    timeoutStatus = TimeoutStatus.idle;
    notifyListeners();
  }

  //resets timer to make timer restart
  void restartTimer() {
    if (_timer == null) {
      startTimer();
    } else {
      stopTimer();
      startTimer();
    }
  }

  //stop timer then set status
  void logout(Timer timer) {
    stopTimer();
    timeoutStatus = TimeoutStatus.completed;
    notifyListeners();
  }
}
