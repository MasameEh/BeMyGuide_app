import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

import '../../shared/components/components.dart';
import '../settings/settings_screen.dart';


class bluetoothScreen extends StatefulWidget {
  const bluetoothScreen({super.key});

  @override
  State<bluetoothScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<bluetoothScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool pwVisible = true;
  var nameController = TextEditingController();
  var pwController = TextEditingController();
  SnackBar snackBar = SnackBar(
    content: Text('missing name or passwoed'),
  );
  List<String> imagePaths = [];
  List<String> imageNames = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon:Icon(Icons.arrow_back) ,
        onPressed: () {
          Navigator.pop(context);
        },
      ),

          title: Text('Blind page')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),

            //Share files

            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('   wifi Name'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '   name',
              ),
              controller: nameController,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('   Passwod'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '   password',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        pwVisible = !pwVisible;
                      });
                    },
                    icon: pwVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: pwVisible,
              controller: pwController,
            ),
            SizedBox(
              height: 10,
            ),
            //share text(name&password)
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || pwController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Share.share('${nameController.text}\n${pwController.text}');
                }
              },
              child: Text('send wifi name&password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: sendFiless,
              child: Text('Send images'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

          onTap: (index)
          {
            navigateTo(context, Settings());
          },
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ]
      ),
    );
  }
// pick image from camera
  void pickImageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }
// pick image from gallery
  void pickImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }
// pick files
  Future<List<String?>> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    return result!.paths;
  }

//send images(only one image)
  Future<void> sendImage() async {
    final res = await ImagePicker().pickImage(source: ImageSource.gallery);
    late String paths = res!.path;
    await Share.shareFiles([paths], text: 'Image 1');
  }

  //send files(more than one image)

  Future<void> sendFiless() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(res !=null){
      List<String>? filePath =
      res.files.map((e) => e.path).cast<String>().toList();
      await Share.shareFiles(filePath, text: 'List of files');
    }
    else{
    }
  }
  //upload image to API
  void _uploadOneFile(File file) async {
   String fileName = file.path.split('/').last;

   FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
   });

  Dio dio = new Dio();

  dio.post("https://192.168.1.x/upload", data: data)
  .then((response) => print(response))
  .catchError((error) => print(error));
}


Future getImage() async {
     File _image;
     final picker = ImagePicker(); 

    var _pickedFile = await picker.getImage(
    source: ImageSource.camera,
    imageQuality: 50, // <- Reduce Image quality
    maxHeight: 500,  // <- reduce the image size
    maxWidth: 500);

   _image = _pickedFile!.path as File;


  _uploadOneFile(_image);

}
 
//upload multi files to API
  void _upload(List<File> files) async {
  Dio dio = Dio();

  for (File file in files) {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    try {
      Response response = await dio.post("https://192.168.1.x/upload", data: data);
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
void selectAndUploadFiles() async {
  List<File> selectedFiles = [];

  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Specify the file types you want to allow
    );

    if (result != null) {
      selectedFiles = result.paths.map((path) => File(path!)).toList();
      _upload(selectedFiles);
    }
  } catch (error) {
    print('Error selecting files: $error');
  }
}


}