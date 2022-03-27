import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:teamvisual/di/locator.dart';
import '../../main.dart';
import '../utils/navigation_service.dart';

abstract class RootViewModel extends BaseViewModel{

  final SharedPreferences prefs = getIt<SharedPreferences>();

  final NavigationService navigationService = getIt<NavigationService>();

  bool _loading = false;
  bool get loading => _loading;

  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  initialize();

  void showProgress() {
    _loading = true;
    Future.delayed(Duration.zero, () async {
      hideMainAppBar.value = false;
    });
    notify();
  }

  void hideProgress() {
    _loading = false;
    Future.delayed(Duration.zero, () async {
      hideMainAppBar.value = true;
    });

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

  void pt(String msg) {
    debugPrint(msg);
  }

  @override
  void onFutureError(error, Object? key) {
    super.onFutureError(error, key);
    hideProgress();
    pt("Error ${error.toString()} in ${key.toString()}");
  }
}