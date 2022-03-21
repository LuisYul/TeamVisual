import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import '../widgets/custom_alert_dialog.dart';
import 'root_view_model.dart';

abstract class RootWidget<T extends RootViewModel>
    extends HookViewModelWidget {

  final T _viewModel;
  get viewModel => _viewModel;

  final bool _disposable;

  RootWidget(this._viewModel, [this._disposable = false]);

  @override
  Widget build(BuildContext context) {
    init(context);
    return ViewModelBuilder<T>.reactive(
        viewModelBuilder: () => _viewModel,
        builder: (ctx, T viewModel, child) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            if(_viewModel.errorMsg != "") {
              showDialog(
                context: ctx,
                builder: (BuildContext context) => CustomAlertDialog(
                  description: _viewModel.errorMsg,
                  onClick: () => _viewModel.cleanError(),
                ),
              );
            }
          });

          return withProgress(body: buildViewModelWidget(ctx, viewModel));
        },
        disposeViewModel: _disposable,
        onModelReady: (model) => model.initialize(),
    );
  }

  void init(BuildContext context) async {}

  Widget withProgress({required Widget body}) {
    return Stack(
      children: [
        body,
        _viewModel.loading
            ?  AbsorbPointer(
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    const Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 7.0,
                        ),
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    Align(alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/img_logo.png',
                        fit: BoxFit.fitHeight,
                        height: 40,
                      ),
                    )
                  ]
                ),
              )
            )
            : Container(),
      ],
    );
  }

}