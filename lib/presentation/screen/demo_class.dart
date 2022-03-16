import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class CameraWidget extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return CameraWidgetState();
  }

}

class CameraWidgetState extends State{
  XFile? imageFile;

  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        title: Text("Pick Image Camera"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                //child:( imageFile==null)?Text("Choose Image"): Image.file( File(imageFile!.path)),
                child:Image.file( File("/data/user/0/com.visualimpact.teamvisual/app_flutter/3a06eb13-bbff-4034-9a11-ebe54799c8ae61445465471952171.jpg")),
              ),
              MaterialButton(
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: (){
                  _openCamera(context);
                },
                child: Text("Select Image"),

              )
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera ,
    );

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile!.path);
    File savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
    setState(() {
      imageFile = pickedFile;
    });
    //Navigator.pop(context);
  }
}