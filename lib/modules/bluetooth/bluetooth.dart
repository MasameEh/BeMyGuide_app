// TODO Implement this library.
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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
  Future<void> sendFiles() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    List<String>? filePath =
    res!.files.map((e) => e.path).cast<String>().toList();
    await Share.shareFiles(filePath, text: 'List of files');
  }
  Future<void> sendFiless() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(res !=null){
      List<String>? filePath =
      res!.files.map((e) => e.path).cast<String>().toList();
      await Share.shareFiles(filePath, text: 'List of files');
    }
    else{

    }
  }

}
