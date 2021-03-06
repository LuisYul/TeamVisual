import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/usecase/delete_tables_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/send_evaluations_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/sync_use_case.dart';
import 'package:teamvisual/domain/usecase/val_version_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import '../../domain/usecase/sign_in_use_case.dart';
import 'package:teamvisual/presentation/utils/string_extension.dart';

class LoginViewModel extends RootViewModel {

  final SignInUseCase _signInUseCase;
  final ValVersionUseCase _valVersionUseCase;
  final SyncUseCase _syncUseCase;
  final DeleteTablesUseCase _deleteTablesUseCase;
  final SendAssistsPendingUseCase _sendAssistsPendingUseCase;
  final SendEvaluationsPendingUseCase _sendEvaluationsPendingUseCase;

  LoginViewModel(
      this._signInUseCase,
      this._valVersionUseCase,
      this._syncUseCase,
      this._deleteTablesUseCase,
      this._sendAssistsPendingUseCase,
      this._sendEvaluationsPendingUseCase,
  );

  @override
  initialize() {

  }

  void _sendAssistsPending() async {
    await runBusyFuture(_sendAssistsPendingUseCase.call(""),
        busyObject: "error_send_pending");
  }

  void _sendEvaluationsPending() async {
    await runBusyFuture(_sendEvaluationsPendingUseCase.call(""),
        busyObject: "error_send_pending");
  }

  void _valVersion(SignInEntity signInEntity) async {
    showProgress();
    final result = await runBusyFuture(_valVersionUseCase
        .call(ValVersionEntity.currentVersion),
        busyObject: "error_val_version");
    if(result) {
      _signIn(signInEntity);
    } else {
      setErrorMsg(AppConstants.upVersion);
      hideProgress();
    }
  }

  void _signIn(SignInEntity signInEntity) async {
    final result = await runBusyFuture(_signInUseCase.call(signInEntity),
        busyObject: "error_sign_in");
    final status = result.loginStatus;
    if(status.equalsIgnoreCase("true")) {
      _sync(result);
    } else {
      setErrorMsg(result.error);
      hideProgress();
    }
  }

  void _sync(UserEntity userEntity) async {
    final syncEntity = SyncEntity(
        tables: TableEntity.tablesSync,
        params: ParamsEntity(
            idUser: userEntity.idUser,
            idApp: AppConstants.idApp.toString(),
            idUserType: userEntity.idUserType
        )
    );
    final result = await runBusyFuture(_syncUseCase.call(syncEntity),
        busyObject: "error_sync");
    if(result) {
      navigationService.navigateTo("/main");
    } else {
      setErrorMsg(AppConstants.genericError);
    }
    hideProgress();
  }

  void submitLogin(String user, String password) {
    _sendAssistsPending();
    _sendEvaluationsPending();
    final signInEntity = SignInEntity(user: user, password: password);
    _valVersion(signInEntity);
  }

  void submitClearData() async {
    await runBusyFuture(_deleteTablesUseCase.call(""));
    setErrorMsg(AppConstants.dataCleared);
  }

  @override
  void onFutureError(error, Object? key) {
    super.onFutureError(error, key);
    if(key.toString() != "error_send_pending") {
      hideProgress();
      setErrorMsg(AppConstants.genericError);
    }
  }

}