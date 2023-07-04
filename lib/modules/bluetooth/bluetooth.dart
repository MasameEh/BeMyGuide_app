import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
    return  Scaffold(
      appBar: AppBar(
        title: Text('Glases Connection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              selectedImage=null;
              uploadPhoto(context,'gallery');
            }, child: Text('Select photos from gallrey')),
            ElevatedButton(onPressed: (){
              selectedImage=null;
              uploadPhoto(context,'camera');
            }, child: Text('Take Photo')),
          ],
        ),
      ),
    );

  }
  
}
