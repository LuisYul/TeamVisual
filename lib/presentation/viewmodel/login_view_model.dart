import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
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

  LoginViewModel(
      this._signInUseCase,
      this._valVersionUseCase,
      this._syncUseCase,
  );

  @override
  initialize() {

  }

  void _valVersion(SignInEntity signInEntity) async {
    showProgress();
    final result = await runBusyFuture(_valVersionUseCase
        .call(ValVersionEntity.currentVersion),
        busyObject: "error_sign_in");
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
    final status = result.loginStatus ?? "";
    if(status.equalsIgnoreCase("true")) {
      _sync(result);
    } else {
      setErrorMsg(result.error ?? AppConstants.genericError);
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
    final signInEntity = SignInEntity(user: user, password: password);
    _valVersion(signInEntity);
  }


  @override
  void dispose() {
    super.dispose();
  }
}