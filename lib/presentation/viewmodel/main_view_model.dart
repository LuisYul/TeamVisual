import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:teamvisual/domain/usecase/get_assist_types_use_case.dart';
import 'package:teamvisual/domain/usecase/get_modules_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';

class MainViewModel extends RootViewModel {

  final GetModulesUseCase _getModulesUseCase;
  final GetAssistTypesUseCase _getAssistTypesUseCase;

  MainViewModel(
      this._getModulesUseCase,
      this._getAssistTypesUseCase,
  );

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  String _currentTabTitle = "Módulos";
  String get currentTabTile => _currentTabTitle;

  bool _reverse = false;
  bool get reverse => _reverse;

  @override
  initialize() {
    debugPrint("init main view model");
    _getModules();
  }

  void _getModules() async {
    showProgress();
    final result = await runBusyFuture(_getModulesUseCase.call(1),
        busyObject: "error_get_modules");
    if(result.isNotEmpty) {
      debugPrint(result.length.toString());
    }
    hideProgress();
  }

  void _getAssistTypes() async {
    showProgress();
    final result = await runBusyFuture(_getModulesUseCase.call(1),
        busyObject: "error_get_modules");
    if(result.isNotEmpty) {
      debugPrint(jsonEncode(result));
    }
    hideProgress();
  }

  void setCurrentTab(int index, String title) {
    if (index < _currentTabIndex) {
      _reverse = true;
    }
    _currentTabIndex = index;
    _currentTabTitle = title;
    notify();
  }

}