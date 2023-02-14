//
//
//
// import 'package:flutter/material.dart';
//
// import '../../shared/components/components.dart';
// import '../settings/settings_screen.dart';
//
// class BlindFeaturesScreen extends StatelessWidget {
//   const BlindFeaturesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blind features'),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//
//           onTap: (index)
//           {
//             navigateTo(context, Settings());
//           },
//           items:[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ]
//       ),
//     );
//   }
// }
// =======
// TODO Implement this library.
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
class BlindFeaturesScreen extends StatefulWidget {
  const BlindFeaturesScreen({super.key});

  @override
  State<BlindFeaturesScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlindFeaturesScreen> {
  File?  _image;
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
      appBar: AppBar(title: Text('Image picker')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                GestureDetector(
                  onTap: pickImageFromCamera,
                  child: Icon(Icons.camera_alt)
                  ),
                CircleAvatar(
                  backgroundImage: _image==null?null:FileImage(_image!),
                  backgroundColor: Colors.white,
                  radius: 80,
                ),
                GestureDetector(
                  onTap: pickImageFromGallery,
                  child: Icon(Icons.camera_alt)
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
      //share text
            ElevatedButton(
              onPressed: (){
                if(nameController.text.isEmpty || pwController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);  
                }
                  else {
                  Share.share('${nameController.text}\n${pwController.text}');
                }
              },
               child: Text('Share texts via Blueooth'),
               ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 10,),
            //Share files
             ElevatedButton(
              onPressed:sendFiles ,
               child: Text('Share files via Blueooth'),
               ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('wifi Name'),
              ],
            ),
             SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'name',
              ),
              controller: nameController,
            ),
             SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                Text('Passwod'),
              ],
            ),
             SizedBox(
              height: 5,
            ),
            TextField(
               decoration: InputDecoration(
                hintText: 'password',
                suffixIcon: IconButton(onPressed: (){setState(() {
                  pwVisible=!pwVisible;
                });}, icon:pwVisible?Icon(Icons.visibility):Icon(Icons.visibility_off)),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: pwVisible,
              controller: pwController,
              
            ),
          ],
        ),
      ),
    );
  }

  void pickImageFromCamera() async {
     var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path) ;
    
    });
  }
  void pickImageFromGallery() async {
     var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path) ;
    
    });
  }
  Future<List<String?>> pickFile()async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
   
   return result!.paths ;
}
//send images
Future<void> sendImage()async {
final res = await ImagePicker().pickImage(source: ImageSource.gallery);
late String paths = res!.path;
await Share.shareFiles([paths],text: 'Image 1');
 }
 //send files
 Future<void> sendFiles()async{
 final res = await FilePicker.platform.pickFiles(allowMultiple: true);
List<String>? filePath = res!.files.map((e) => e.path).cast<String>().toList();
await Share.shareFiles(filePath,text: 'List of files');
 }
  }
// >>>>>>> origin/master
