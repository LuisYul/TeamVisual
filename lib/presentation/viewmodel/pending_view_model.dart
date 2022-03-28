import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamvisual/domain/usecase/get_all_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_pending_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import '../../domain/usecase/send_evaluations_pending_use_case.dart';
import '../utils/app_constants.dart';
import '../widgets/custom_dialog.dart';

class PendingViewModel extends RootViewModel {

  final GetAllPendingUseCase _getAllPendingUseCase;
  final SendAssistsPendingUseCase _sendAssistsPendingUseCase;
  final SendEvaluationsPendingUseCase _sendEvaluationsPendingUseCase;

  PendingViewModel(
      this._getAllPendingUseCase,
      this._sendAssistsPendingUseCase,
      this._sendEvaluationsPendingUseCase,
  );

  int _totalAssistPending = 0;
  int get totalAssistPending => _totalAssistPending;

  int _totalEvaluationsPending = 0;
  int get totalEvaluationsPending => _totalEvaluationsPending;

  @override
  initialize() {
    _getAlLPending();
  }

  void _getAlLPending() async {
    final result = await runBusyFuture(_getAllPendingUseCase.call(""),
        busyObject: "error_get_modules");

    _totalAssistPending = result[0];
    _totalEvaluationsPending = result[1];
    notify();
  }

  void sendAssistsPending(BuildContext context) async {
    if(_totalAssistPending == 0) return;
    showProgress();
    final result = await runBusyFuture(_sendAssistsPendingUseCase.call(""),
        busyObject: "error_send_assists").catchError((error) {
      _showDialogError(context);
    });
    if(result) {
      _showDialogSuccess(context);
    } else {
      _showDialogError(context);
    }
    hideProgress();
  }

  void sendEvaluationsPending(BuildContext context) async {
    if(_totalEvaluationsPending == 0) return;
    showProgress();
    final result = await runBusyFuture(_sendEvaluationsPendingUseCase.call(""),
        busyObject: "error_send_evaluations").catchError((error) {
      _showDialogError(context);
    });
    if(result) {
      _showDialogSuccess(context);
    } else {
      _showDialogError(context);
    }
    hideProgress();
  }

  void _showDialogError(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          title: "Atención",
          description: AppConstants.genericError,
          firstButtonText: "OK",
          firstClick: () => {
            navigationService.navigateTo("/main")
          },
        ),
      ),
    );
  }

  void _showDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomDialog(
          title: "Atención",
          description: AppConstants.infoSent,
          firstButtonText: "OK",
          firstClick: () => {
            navigationService.navigateTo("/main")
          },
        ),
      ),
    );
  }

}