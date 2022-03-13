import 'package:flutter/foundation.dart';

class BaseChangeNotifier extends ChangeNotifier {
  ViewStatus _status = ViewStatus.complete;
  
  ViewStatus get status => _status;

  void setStatus(ViewStatus stautus) {
    _status = status;
    notifyListeners();
  }
}

enum ViewStatus {loading, complete, error}