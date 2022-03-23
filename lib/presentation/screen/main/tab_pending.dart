import 'package:flutter/material.dart';
import 'package:teamvisual/di/locator.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/pending_view_model.dart';

class TabPending extends RootWidget<PendingViewModel>{
  TabPending(): super(getIt());

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return Column();
  }

}