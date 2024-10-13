import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLifecycleManager with WidgetsBindingObserver {

  AppLifecycleManager() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      if (kDebugMode) {
        print("App is in the background");
      }
    } else if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print("App resumed");
      }
    } else if (state == AppLifecycleState.detached) {
      if (kDebugMode) {
        print("App is being terminated");
      }
    }
  }
}
