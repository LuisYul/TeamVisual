import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
import '../widgets/custom_dialog.dart';

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
    _determinePosition();
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

  }

  void _getAssistTypes() async {
    showProgress();
    final result = await runBusyFuture(_getAssistTypesUseCase.call(""),
        busyObject: "error_get_assist_types");
    if(result.isNotEmpty) {
      _assistTypes = result;
      _getCurrentIdAssistType();
    }
    hideProgress();
  }

  void submitSave(String obs, BuildContext context) {
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
        lat: "",
        lng: "",
        photoPath: _imageFile?.path,
        idAssistType: (_assistTypeId).toString(),
        obs: obs,
        idUserType: prefs.getString(AppConstants.prefsUserTypeId),
        userType: prefs.getString(AppConstants.prefsUserType),
        numDoc: prefs.getString(AppConstants.prefsUserDocNumber),
    );
    _sendAssists(assistEntity, context);
  }

  void _sendAssists(AssistEntity assistEntity, BuildContext context) async {

    final position = await  _determinePosition();
    assistEntity.lat = position.latitude.toString();
    assistEntity.lng = position.longitude.toString();

    Uint8List? bytes =  await _imageFile?.readAsBytes();
    if(bytes != null) {
      String base64Image = base64Encode(bytes);
      assistEntity.photo = base64Image;
    }
    final assists = AssistListEntity(assists: [assistEntity]);
    final result = await runBusyFuture(_sendAssistsUseCase.call(assists),
        busyObject: "error_send_assists").catchError((error) {
          _saveAssist(assistEntity);
          _showDialogError(context);
    });
    if(result) {
      _showDialogSuccess(context);
    } else {
      _saveAssist(assistEntity);
      _showDialogError(context);
    }

    hideProgress();

  }

  void _saveAssist(AssistEntity assistEntity) async {
    await runBusyFuture(_saveAssistUseCase.call(assistEntity),
        busyObject: "error_save_assist");
  }

  void setImageFile(XFile imageFile) {
    _imageFile = imageFile;
    debugPrint("set image path "+_imageFile!.path);
    notify();
  }

  void _showDialogError(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
        title: "Atención",
        description: AppConstants.savedInPending,
        firstButtonText: "OK",
        color: Colors.red,
        icon: CupertinoIcons.exclamationmark,
        firstClick: () => {
          navigationService.replaceTo("/main")
        },
      ),
    );
  }

  void _showDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
        title: "Atención",
        description: "Se envió la información correctamente",
        firstButtonText: "OK",
        color: Colors.green,
        icon: CupertinoIcons.checkmark_alt,
        firstClick: () => {
          navigationService.replaceTo("/main")
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, '
              'we cannot request permissions.');
    }

    pt("position ${Geolocator.getCurrentPosition()}");
    return await Geolocator.getCurrentPosition();
  }
}