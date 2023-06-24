import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/eyes_app/eyes_layout.dart';
import 'package:graduation_project/modules/blind_features/blindfeatures_screen.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/volunteer/volunteerfeatures_screen.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/components/constants.dart';
import 'package:graduation_project/shared/network/TextToSpeech.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

import 'layout/eyes_app/cubit/cubit.dart';
import 'layout/eyes_app/cubit/states.dart';
import 'modules/speech/speechscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  TextToSpeech.iniTts();
  Widget widget;
  var uId = CacheHelper.getData(key: 'uId');
  if(uId == null) {
      widget = LoginScreen();
    } else {
      widget = EyesLayout();
    }
  // if(token == null) {
  //   widget = LoginScreen();
  // } else {
  //   widget = EyesLayout();
  // }
  runApp( MyApp(
  startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              //scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                //backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backwardsCompatibility: false,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
