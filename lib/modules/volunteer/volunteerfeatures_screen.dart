import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/localization/app_local.dart';

import '../../shared/components/components.dart';
import '../settings/settings_screen.dart';
import '../speech/speechscreen.dart';
import '../video_Call/join_screen.dart';
import '../video_Call/volunteer_joinScreen.dart';

class VolunteerFeaturesScreen extends StatelessWidget {
  VolunteerFeaturesScreen({Key? key}) : super(key: key);
  bool ar = true;

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
                Text(
                  "${getLang(context, "h1")}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      color: Colors.white),
                ),
                Text(
                  "${getLang(context, "h2")}",
                  style: const TextStyle(
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
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, VolunteerJoinScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                                Text("${getLang(context, 'feature2')}",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 180, 31, 87),
                                      fontWeight: FontWeight.bold,
                                    )),
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
                            border:
                                Border.all(color: Colors.black.withOpacity(.4)),
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
                                Text("${getLang(context, "feature3")}",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 180, 31, 87),
                                      fontWeight: FontWeight.bold,
                                    )),
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
  }
}
