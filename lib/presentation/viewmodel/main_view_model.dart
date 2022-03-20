import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/usecase/get_assist_types_use_case.dart';
import 'package:teamvisual/domain/usecase/get_modules_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

class MainViewModel extends RootViewModel {

  final GetModulesUseCase _getModulesUseCase;
  final GetAssistTypesUseCase _getAssistTypesUseCase;

  MainViewModel(
      this._getModulesUseCase,
      this._getAssistTypesUseCase,
  );

  String _userName = "";
  String get userName => _userName;

  String _userType = "";
  String get userType => _userType;

  String _userPhoto = "";
  String get userPhoto => _userPhoto;

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  String _currentTabTitle = "Módulos";
  String get currentTabTile => _currentTabTitle;

  bool _reverse = false;
  bool get reverse => _reverse;

  bool _assistModuleOn = false;
  bool get assistModuleOn => _assistModuleOn;

  bool _quizModuleOn = false;
  bool get quizModuleOn => _quizModuleOn;

  bool _thirdModuleOn = false;
  bool get thirdModuleOn => _thirdModuleOn;

  bool _fourthModuleOn = false;
  bool get fourthModuleOn => _fourthModuleOn;

  @override
  initialize() {
    _getModules();
    _userName = prefs.getString(AppConstants.prefsUserName) ?? "";
    _userType = prefs.getString(AppConstants.prefsUserType) ?? "";
    _userPhoto = prefs.getString(AppConstants.prefsUserPhoto) ?? "";
    notify();
    pt("init main viewmodel");
  }

  void _getModules() async {
    showProgress();
    final result = await runBusyFuture(_getModulesUseCase.call(1),
        busyObject: "error_get_modules");
    if(result.isNotEmpty) {
      _checkModulePermissions(result);
    }
    hideProgress();
  }

  void _checkModulePermissions(List<ModuleEntity> modules) {
    bool assistModule = false;
    bool quizModule = false;
    bool thirdModule = false;
    bool fourthModule = false;
    for(final i in modules) {
      if(i.id == AppConstants.assistModuleId) assistModule = true;
      if(i.id == AppConstants.quizModuleId) quizModule = true;
      if(i.id == AppConstants.thirdModuleId) thirdModule = true;
      if(i.id == AppConstants.fourthModuleId) fourthModule = true;
    }
    _assistModuleOn = assistModule;
    _quizModuleOn = quizModule;
    _thirdModuleOn = thirdModule;
    _fourthModuleOn = fourthModule;
    notify();
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
    pt("current tab index $index");
    _currentTabTitle = title;
    notify();
  }

}