import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:teamvisual/di/locator.dart';

import '../utils/navigation_service.dart';

abstract class RootViewModel extends BaseViewModel{

  final NavigationService navigationService
    = getIt<NavigationService>();

  bool _loading = false;
  bool get loading => _loading;

  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  initialize();

  void showProgress() {
    log("showing progress");
    _loading = true;
    notify();
  }

  void hideProgress() {
    _loading = false;
    notify();
  }

  void setErrorMsg(String msg) {
    _errorMsg = msg;
    notify();
  }

  void cleanError() {
    _errorMsg = "";
    notify();
  }

  void notify() {
    notifyListeners();
  }
}