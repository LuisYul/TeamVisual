import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamvisual/presentation/base/root_widget.dart';
import 'package:teamvisual/presentation/viewmodel/assist_view_model.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'dart:io';
import '../../../di/locator.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class TabAssist extends RootWidget<AssistViewModel> {
  TabAssist() : super(getIt());

  final TextEditingController _obsController = TextEditingController();

  final String path = "/data/user/0/com.visualimpact.teamvisual/cache/417095e1-1152-460f-9c19-beabb18a3e798130362856397493148.jpg";

  // @override
  // void init() async {
  //
  //   // var img = File(path);
  //   // var decodedImage = await decodeImageFromList(img.readAsBytesSync());
  // }

  @override
  Widget buildViewModelWidget(BuildContext context, viewModel) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Padding(
        padding: EdgeInsets.all(10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _toggleAssistTypes(),
              _photoContainer(),
              SizedBox(height: 10.h,),
              SizedBox(
                width: double.infinity,
                child: _takePhotoButton(context)
              ),
              SizedBox(height: 10.h,),
              _textFieldObs(),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _sendButton(context),
                    flex: 1,
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: _clearButton(),
                    flex: 1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleAssistTypes() {
    return Center(
      child: ToggleSwitch(
        minWidth: ScreenUtil().screenWidth,
        initialLabelIndex: viewModel.screenDisabled
            ? null
            : viewModel.assistTypeId - 1,
        totalSwitches: viewModel.assistNames.length,
        labels: viewModel.assistNames,
        changeOnTap: false,
        onToggle: (index) {
          debugPrint('switched to: $index');
        },
      ),
    );
  }

  Widget _photoContainer() {
    return Card(
      color: Colors.white12,
      child:(viewModel.imageFile == null)
          ? null
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.file(
          //  File(path),
          File(viewModel.imageFile.path),
          height: 320.h,
        ),
      ),
    );
  }

  Widget _textFieldObs() {
    return TextField(
      controller: _obsController,
      style: GoogleFonts.montserrat(
          fontSize: 15.sp,
          color: Colors.black,
          letterSpacing: 0.24,
          fontWeight: FontWeight.w500
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black54,
              width: 2.0
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: 'Escriba su observación aquí',
        labelText: 'Observación',
        prefixText: ' ',
        focusColor: Colors.black54,
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        suffixStyle: TextStyle(
            color: Colors.redAccent
        ),
      ),
    );
  }

  Widget _takePhotoButton(BuildContext context) {
    return PrimaryButton(
      title: "Tomar foto",
      icon: CupertinoIcons.camera,
      onClick: () => _openCamera(context),
      disabled: viewModel.screenDisabled,
    );
  }

  Widget _sendButton(BuildContext context) {
    return PrimaryButton(
      title: "Enviar",
      icon: CupertinoIcons.arrow_up_circle_fill,
      onClick: () => viewModel.submitSave(_obsController.text),
      disabled: viewModel.screenDisabled,
    );
  }

  Widget _clearButton() {
    return SecondaryButton(
      title: "Limpiar",
      icon: CupertinoIcons.clear_circled,
      onClick: () {

      },
      disabled: viewModel.screenDisabled,
    );
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera ,
      imageQuality: 25,
    );
    viewModel.setImageFile(pickedFile);
  }
}