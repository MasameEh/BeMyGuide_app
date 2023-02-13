

abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates{}

class AppLoginSuccessState extends AppLoginStates{
  final String? uId;

  AppLoginSuccessState(this.uId);

}

class AppLoginErrorState extends AppLoginStates
{
   final String error;
  AppLoginErrorState(this.error);
}
class  AppgetUserLoadingState extends AppLoginStates {}

class AppgetUserSuccessState extends AppLoginStates{}

class AppgetUserErrorState extends AppLoginStates
{
final String error;

AppgetUserErrorState(this.error);
}
