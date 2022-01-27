import 'package:flutter/foundation.dart';

class BaseViewModel with ChangeNotifier {
  ViewStatus _status = ViewStatus.loading;

  BaseViewModel();

  setStatus(ViewStatus status) => _status = status;

  ViewStatus get status => _status;
}

enum ViewStatus {loading, success, error}