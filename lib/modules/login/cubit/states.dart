import 'package:graduation_project/models/login_model.dart';

abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates{}

class AppLoginSuccessState extends AppLoginStates
{
  final AppLoginModel loginModel;
  AppLoginSuccessState(this.loginModel);
}

class AppLoginErrorState extends AppLoginStates
{
   late String error;
  AppLoginErrorState(this.error);
}