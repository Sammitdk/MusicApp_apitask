import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class Internet with ChangeNotifier{

  bool isOnline = true;
  void listener() => InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        isOnline = true;
        notifyListeners();
        break;
      case InternetConnectionStatus.disconnected:
        isOnline = false;
        notifyListeners();
        break;
    }
  });
}
