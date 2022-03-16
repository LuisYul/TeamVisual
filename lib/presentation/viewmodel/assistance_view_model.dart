import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';

class AssistanceViewModel extends RootViewModel {

  List<TextStyle> _listStyles = [];
  List<TextStyle> get listStyles => _listStyles;

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  @override
  initialize() {

  }

  void setListStyles(List<TextStyle> listStyles) {
    _listStyles = listStyles;
    notifyListeners();
  }

  void setImageFile(XFile imageFile) {
    _imageFile = imageFile;
    notify();
  }
}