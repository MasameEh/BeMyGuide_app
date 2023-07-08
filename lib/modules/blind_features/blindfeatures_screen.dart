// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/speech/speechscreen.dart';
import 'package:graduation_project/modules/video_Call/join_screen.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

import '../../layout/eyes_app/cubit/cubit.dart';
import '../../layout/eyes_app/cubit/states.dart';
import '../../shared/components/components.dart';
import '../bluetooth/bluetooth.dart';
import '../settings/settings_screen.dart';

class BlindFeaturesScreen extends StatefulWidget {
  const BlindFeaturesScreen({super.key});

  @override
  State<BlindFeaturesScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BlindFeaturesScreen> {
  bool ar = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
              decoration: const BoxDecoration(
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
                    const Text(
                      'Assistant',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    const Text(
                      'Mode',
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
                      decoration: const BoxDecoration(
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
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('BeMyGuide',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 180, 31, 87))),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, const bluetoothScreen());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(.4)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: Colors.grey.withOpacity(.6),
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                     Text('Send a pic',
                                      style:  GoogleFonts.acme(
                                        color: Color.fromARGB(255, 180, 31, 87),
                                        fontSize: 30.0,
                                      ),
                                     ),
                                        // style: TextStyle(
                                        //   fontSize: 25,
                                        //   color:
                                        //       Color.fromARGB(255, 180, 31, 87),
                                        //   fontWeight: FontWeight.bold,
                                        // )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // defaultButton(
                          //   width: 300.0,
                          //   radius: 20.0,
                          //   height: 60.0,
                          //   borderColor: Colors.black,
                          //   function: () {
                          //     navigateTo(context, bluetoothScreen());
                          //   },
                          //   textColor: Color.fromARGB(255, 180, 31, 87),
                          //   text: 'Bluetooth',
                          //   background: Colors.white,
                          // ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, JoinScreen());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(.4)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.video_call,
                                      color: Colors.grey.withOpacity(.6),
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                     Text('Video Call',
                                         style:  GoogleFonts.acme(
                                        color: Color.fromARGB(255, 180, 31, 87),
                                fontSize: 30.0,
                              ),
                            ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              ar = true;
                              navigateTo(
                                  context,
                                  SpeechScreen(
                                    ar: ar,
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(.4)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.video_call,
                                      color: Colors.grey.withOpacity(.6),
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                     Text('Chatgpt-AR',
                                       style:  GoogleFonts.acme(
                                         color: Color.fromARGB(255, 180, 31, 87),
                                         fontSize: 30.0,
                                       ),
                                     ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              ar = false;
                              navigateTo(
                                  context,
                                  SpeechScreen(
                                    ar: ar,
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(.4)),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Icon(
                                      Icons.video_call,
                                      color: Colors.grey.withOpacity(.6),
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                     Text('Chatgpt-EN',
                                      style:  GoogleFonts.acme(
                                        color: Color.fromARGB(255, 180, 31, 87),
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      },
    );
  }
}
