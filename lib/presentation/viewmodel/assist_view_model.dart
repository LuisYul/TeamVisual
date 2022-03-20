import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:teamvisual/domain/model/assist_entity.dart';
import 'package:teamvisual/domain/model/assist_list_entity.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/usecase/get_assist_types_use_case.dart';
import 'package:teamvisual/domain/usecase/save_assist_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

class AssistViewModel extends RootViewModel {

  final GetAssistTypesUseCase _getAssistTypesUseCase;
  final SaveAssistUseCase _saveAssistUseCase;
  final SendAssistsUseCase _sendAssistsUseCase;

  AssistViewModel(
      this._getAssistTypesUseCase,
      this._saveAssistUseCase,
      this._sendAssistsUseCase,
  );

  List<AssistTypeEntity> _assistTypes = [];
  List<AssistTypeEntity> get assistTypes => _assistTypes;

  List<String> _assistNames = [''];
  List<String> get assistNames => _assistNames;

  int _assistTypeId = 0;
  int get assistTypeId => _assistTypeId;

  int _toggleIndex = 0;
  int get toggleIndex => _toggleIndex;

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  bool _screenDisabled = false;
  bool get screenDisabled => _screenDisabled;


  @override
  initialize() {
    _getAssistTypes();
  }

  void _getCurrentIdAssistType() {
    List<String> names = [];
    for(final i in _assistTypes) {
      if(i.id != 99) names.add(i.name);
      if(true == i.current) {
        _assistTypeId = i.id;
        _toggleIndex = i.index!;
      }
    }

    _assistNames = names;

    if(_assistTypeId == 99) {
      _screenDisabled = true;
    }
    notify();
    hideProgress();
  }

  void _getAssistTypes() async {
    showProgress();
    final result = await runBusyFuture(_getAssistTypesUseCase.call(""),
        busyObject: "error_get_assist_types");
    if(result.isNotEmpty) {
      _assistTypes = result;
      _getCurrentIdAssistType();
    }

  }

  void submitSave(String obs) {
    if(_imageFile == null) {
      setErrorMsg(AppConstants.forceTakePhoto);
      return;
    }
    showProgress();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    var formatterTime = DateFormat('HH:mm:ss');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);

    final assistEntity = AssistEntity(
        userId: prefs.getString(AppConstants.prefsUserId),
        userName: prefs.getString(AppConstants.prefsUserName),
        date: actualDate,
        hour: actualTime,
        lat: "-12.3232111001",
        lng: "-71.3423423423",
        photoPath: _imageFile?.path,
        idAssistType: (_assistTypeId).toString(),
        obs: obs,
        idUserType: prefs.getString(AppConstants.prefsUserTypeId),
        userType: prefs.getString(AppConstants.prefsUserType),
        numDoc: prefs.getString(AppConstants.prefsUserDocNumber),
    );
    //_saveAssist(assistEntity);
    _sendAssists(assistEntity);
  }

  void _sendAssists(AssistEntity assistEntity) async {

    Uint8List? bytes =  await _imageFile?.readAsBytes();
    String base64Image = base64Encode(bytes!);
    assistEntity.photo = base64Image;
    final assists = AssistListEntity(assists: [assistEntity]);
    final result = await runBusyFuture(_sendAssistsUseCase.call(assists),
        busyObject: "error_send_assists").catchError((error) {
         setError(AppConstants.infoNotSent);
    });
    pt("result send photo $result");
    if(result) {
      setError(AppConstants.infoSent);
    } else {
      setError(AppConstants.infoNotSent);
    }

    hideProgress();

  }

  void _saveAssist(AssistEntity assistEntity) async {
    final result = await runBusyFuture(_saveAssistUseCase.call(assistEntity),
        busyObject: "error_get_assist_types");
    debugPrint("result save assist $result");
  }

  void setImageFile(XFile imageFile) {
    _imageFile = imageFile;
    debugPrint("set image path "+_imageFile!.path);
    notify();
  }
}