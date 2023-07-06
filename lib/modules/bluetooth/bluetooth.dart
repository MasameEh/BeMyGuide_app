import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/components.dart';
import '../settings/settings_screen.dart';

class bluetoothScreen extends StatefulWidget {
  const bluetoothScreen({super.key});

  @override
  State<bluetoothScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<bluetoothScreen> {
   File? selectedImage;
//select image from gallery
Future<void> selectImageFromGallery() async {
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }
}
//select image from Camera
Future<void> selectImageFromCamera() async {
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

  if (pickedImage != null) {
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }
}
List<File> selectedImages = [];
 Future<void> selectImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        selectedImages = pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      });
    }
  }
/********************************* */
void uploadPhoto(BuildContext context,String type) async {
if(type=='gallery'){
   await selectImageFromGallery();
}
else{
  await selectImageFromCamera();
}
  if (selectedImage == null) {
     SnackBar snackBar4 = SnackBar(content: Text('No Image selected'),duration: Duration(seconds: 5),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar4);
    print('No image selected');
    
  }
else{
  Dio dio = Dio();

  try {
    FormData formData = FormData.fromMap({
      'images': await MultipartFile.fromFile(selectedImage!.path),
    });

    Response response = await dio.post('https://2edb-45-242-56-239.ngrok-free.app/images', data: formData);

    if (response.statusCode == 200) {
      // Upload successful
      SnackBar snackBar = SnackBar(content: Text('Photo uploaded successfully'),duration: Duration(seconds: 10),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('-****************Photo uploaded successfully');
    } else {
      // Upload failed
      SnackBar snackBar2 = SnackBar(content: Text('Photo uploaded failed'),duration: Duration(seconds: 10),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      print('Photo upload failed');
    }
  } catch (error) {
    // Error occurred during the upload
     SnackBar snackBar3 = SnackBar(content: Text('Error uploading photo: $error'),duration: Duration(seconds: 10),);
     ScaffoldMessenger.of(context).showSnackBar(snackBar3);
    print('Error uploading photo: $error');
   
  }
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.white, //
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Container(
                  width: 34.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white.withOpacity(.3),
                  ),
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 20,
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        navigateTo(context, Settings());
                      },
                ),
              ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Home_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text(
                      'Glasses Conection',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                   
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Color.fromARGB(255, 250, 250, 250),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/gp-logo.png',
                                scale: 6,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('BeMyGuide',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 180, 31, 87))),
                            ],
                          ),
                         
                          defaultButton(
                            width: 330.0,
                            radius: 20.0,
                            height: 60.0,
                            borderColor: Colors.black.withOpacity(.4),
                            function: () {
                             selectedImage = null;
                            uploadPhoto(context, 'gallery');
                            },
                            textColor: Color.fromARGB(255, 180, 31, 87),
                            text: 'Select photos from gallrey',
                            background: Colors.white,
                          ),
                          SizedBox(height: 20,),
                          defaultButton(
                            width: 330.0,
                            radius: 20.0,
                            height: 60.0,
                            borderColor: Colors.black.withOpacity(.4),
                            function: () {
                            selectedImage = null;
                            uploadPhoto(context, 'camera');
                            },
                            textColor: Color.fromARGB(255, 180, 31, 87),
                            text: 'Take Photo',
                            background: Colors.white,
                          ),
                        
                    
                      Image.asset(
                        'assets/Header.png',
                        scale: 1,
                        fit: BoxFit.fitHeight,
                        opacity: AlwaysStoppedAnimation(.3),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );


  }
  
}
