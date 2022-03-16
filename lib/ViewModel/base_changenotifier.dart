import 'package:flutter/foundation.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late ViewStatus _status;

  BaseChangeNotifier(this._status);
  
  ViewStatus get status => _status;

  void setStatus(ViewStatus status) {
    _status = status;
    notifyListeners();
  }
}

enum ViewStatus {loading, complete, error}