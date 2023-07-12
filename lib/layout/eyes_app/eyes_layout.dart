import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/eyes_app/cubit/cubit.dart';
import 'package:graduation_project/layout/eyes_app/cubit/states.dart';

import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/localization/app_local.dart';

import '../../modules/blind_features/blindfeatures_screen.dart';

import '../../modules/settings/settings_screen.dart';
import '../../modules/volunteer/volunteerfeatures_screen.dart';
import '../../shared/network/local/cache_helper.dart';

class EyesLayout extends StatefulWidget {
  const EyesLayout({Key? key}) : super(key: key);

  @override
  State<EyesLayout> createState() => _EyesLayoutState();
}

class _EyesLayoutState extends State<EyesLayout> {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
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
                      "${getLang(context, "title1")}",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    Text(
                      "${getLang(context, "title2")}",
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
                          const SizedBox(
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
                          defaultButton(
                            width: 330.0,
                            radius: 20.0,
                            height: 60.0,
                            borderColor: Colors.black.withOpacity(.4),
                            function: () {
                              // submit();
                              // CacheHelper.putBoolean(
                              //     key: 'isBlind', value: false);
                              navigateAndFinish(
                                context,
                                const BlindFeaturesScreen(),
                              );
                              AppCubit.get(context).getUserData();
                            },
                            textColor: Color.fromARGB(255, 180, 31, 87),
                            text: "${getLang(context, "title3")}",
                            fontSize: 30.0,
                            background: Colors.white,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            width: 330.0,
                            height: 60.0,
                            radius: 20.0,
                            function: () {
                              // submit1();
                              // CacheHelper.putBoolean(
                              //     key: 'isVolunteer', value: false);
                              navigateAndFinish(
                                context,
                                VolunteerFeaturesScreen(),
                              );
                              AppCubit.get(context).getUserData();
                            },
                            borderColor: Colors.black.withOpacity(.4),
                            textColor: Color.fromARGB(255, 180, 31, 87),
                            text: "${getLang(context, "title4")}",
                            fontSize: 30.0,
                            background: Colors.white,
                          ),
                          Image.asset(
                            'assets/Header.png',
                            scale: 1,
                            fit: BoxFit.fitHeight,
                            opacity: const AlwaysStoppedAnimation(.3),
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
  void submit() {
    CacheHelper.saveData(
      key: 'isBlind',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          const BlindFeaturesScreen(),
        );
      }
    });
  }

  void submit1() {
    CacheHelper.saveData(
      key: 'isVolunteer',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          VolunteerFeaturesScreen(),
        );
      }
    });
  }
}
