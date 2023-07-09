import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());
  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AppRegisterLoadingState());

    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: user.user?.uid,
      );
    } on FirebaseAuthException catch (e) {
      emit(AppRegisterErrorState(e.message.toString()));
    }
  }

  void userCreate({
    required String? email,
    required String name,
    required String phone,
    required String? uId,
  }) {
    UserDataModel model = UserDataModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState(uId));
      print(uId);
    }).catchError((error) {
      emit(AppCreateUserErrorState(error.toString()));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppRegsiterChangePasswordVisibilityState());
  }
}
