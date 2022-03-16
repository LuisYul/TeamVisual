import 'dart:convert';
import 'dart:developer';
import 'package:teamvisual/domain/usecase/get_assistance_types_use_case.dart';
import 'package:teamvisual/domain/usecase/get_modules_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';

class MainViewModel extends RootViewModel {

  final GetModulesUseCase _getModulesUseCase;
  final GetAssistanceTypesUseCase _getAssistanceTypesUseCase;

  MainViewModel(
      this._getModulesUseCase,
      this._getAssistanceTypesUseCase,
  );

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  String _currentTabTitle = "Módulos";
  String get currentTabTile => _currentTabTitle;

  bool _reverse = false;
  bool get reverse => _reverse;

  @override
  initialize() {
    log("init main view model");
    _getModules();
  }

  void _getModules() async {
    showProgress();
    final result = await runBusyFuture(_getModulesUseCase.call(1),
        busyObject: "error_get_modules");
    if(result.isNotEmpty) {
      log(result.length.toString());
    }
    hideProgress();
  }

  void _getAssistanceTypes() async {
    showProgress();
    final result = await runBusyFuture(_getModulesUseCase.call(1),
        busyObject: "error_get_modules");
    if(result.isNotEmpty) {
      log(jsonEncode(result));
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