import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/layout/eyes_app/eyes_layout.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  String? token = CacheHelper.getData(key: 'token');
  if(token == null) {
    widget = LoginScreen();
  } else {
    widget = EyesLayout();
  }
  runApp( MyApp(
  startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {


  final Widget startWidget;
  MyApp({
    required this.startWidget
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme:IconThemeData(
            color: Colors.black,
          ) ,
          backwardsCompatibility: false,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}










