import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamvisual/presentation/widgets/custom_dialog.dart';

class CustomAlertDialog extends StatelessWidget {
    const CustomAlertDialog({
      Key? key,
      required this.description,
      required this.onClick,
    }): super(key: key);

    final String description;
    final VoidCallback onClick;

    @override
    Widget build(BuildContext context) {
     return CustomDialog(
       title: "Atención",
       description: description,
       firstButtonText: "OK",
       firstClick: onClick,
     );
    }
}