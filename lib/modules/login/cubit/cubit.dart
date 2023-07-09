import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import '../../../models/login_model.dart';
import 'package:flutter/material.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;

  UserDataModel? userModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(AppLoginLoadingState());

    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AppLoginSuccessState(user.user?.uid));
    } on FirebaseAuthException catch (e) {
      String error = '';

      if (e.code == 'wrong-password') {
        error = 'Incorrect password. Please try again.';
      } else if (e.code == 'network-request-failed') {
        error = 'No Internet Connection';
      } else if (e.code == 'user-not-found') {
        error =
            'User not found. Please check your email or sign up for a new account.';
      } else if (e.code == 'too-many-requests') {
        error = 'Too many attempts please try later';
      } else if (e.code == 'unknown') {
        error = 'Email and Password Fields are required';
      } else if (e.code == 'invalid-email') {
        error = 'Invalid email address. Please enter a valid email.';
      } else {
        error = e.code.toString();
      }
      emit(AppLoginErrorState(error));
    }
  }

  void changePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
