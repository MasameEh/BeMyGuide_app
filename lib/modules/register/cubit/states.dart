
abstract class AppRegisterStates {}

class AppRegisterInitialState extends AppRegisterStates {}

class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates {}

class AppRegisterErrorState extends AppRegisterStates {
  late String error;
  AppRegisterErrorState(this.error);
}

class AppCreateUserSuccessState extends AppRegisterStates {
  final String? uId;

  AppCreateUserSuccessState(this.uId);
}

class AppCreateUserErrorState extends AppRegisterStates {
  late String error;
  AppCreateUserErrorState(this.error);
}


class AppRegisterChangePasswordVisibilityState extends AppRegisterStates{}

