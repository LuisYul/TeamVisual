import 'package:teamvisual/domain/usecase/get_all_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/get_total_evaluations_use_case.dart';

import '../../domain/model/module_entity.dart';
import '../../domain/usecase/get_modules_use_case.dart';
import '../base/root_view_model.dart';
import '../utils/app_constants.dart';

class ModuleViewModel extends RootViewModel {

  final GetModulesUseCase _getModulesUseCase;
  final GetAllPendingUseCase _getAllPendingUseCase;
  final GetTotalEvaluationsUseCase _getTotalEvaluationsUseCase;

  ModuleViewModel(
      this._getModulesUseCase,
      this._getAllPendingUseCase, 
      this._getTotalEvaluationsUseCase,
  );

  String _userName = "";
  String get userName => _userName;

  String _userPhoto = "";
  String get userPhoto => _userPhoto;

  bool _assistModuleOn = false;
  bool get assistModuleOn => _assistModuleOn;

  bool _quizModuleOn = false;
  bool get quizModuleOn => _quizModuleOn;

  bool _thirdModuleOn = false;
  bool get thirdModuleOn => _thirdModuleOn;

  bool _fourthModuleOn = false;
  bool get fourthModuleOn => _fourthModuleOn;

  int _totalPending = 0;
  int get totalPending => _totalPending;

  int _totalEvaluations = 0;
  int get totalEvaluations => _totalEvaluations;

  @override
  initialize() {
    _getModules();
    _userName = prefs.getString(AppConstants.prefsUserName) ?? "";
    _userPhoto = prefs.getString(AppConstants.prefsUserPhoto) ?? "";
    _getAlLPending();
    _getTotalEvaluations();
    notify();
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

  void _getAlLPending() async {
    final result = await runBusyFuture(_getAllPendingUseCase.call(""),
        busyObject: "error_get_modules");
    _totalPending = result.reduce((value, element) => value + element);
  }

  void _getTotalEvaluations() async {
    final result = await runBusyFuture(_getTotalEvaluationsUseCase.call(""),
        busyObject: "error_get_evaluations");
    pt("result tot ev $result");
    _totalEvaluations = result;
  }

}