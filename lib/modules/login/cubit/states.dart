

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