abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates{}

class AppLoginLoadingState extends AppLoginStates{}

class AppLoginSuccessState extends AppLoginStates{}

class AppLoginErrorState extends AppLoginStates
{
   late String error;
  AppLoginErrorState(this.error);
}