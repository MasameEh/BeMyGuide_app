
import '../../../models/login_model.dart';


abstract class AppRegisterStates {}

class AppRegisterInitialState extends AppRegisterStates{}

class AppRegisterLoadingState extends AppRegisterStates{}

class AppRegisterSuccessState extends AppRegisterStates
{
  final AppLoginModel loginModel;
  AppRegisterSuccessState(this.loginModel);
}

class AppRegisterErrorState extends AppRegisterStates
{
   late String error;
  AppRegisterErrorState(this.error);
}