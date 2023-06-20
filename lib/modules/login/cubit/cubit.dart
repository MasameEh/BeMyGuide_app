import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import '../../../models/login_model.dart';



class AppLoginCubit extends Cubit<AppLoginStates> {

  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  UserDataModel? userModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      emit(AppLoginSuccessState(value.user?.uid));
    }).catchError((error){
      emit(AppLoginErrorState(error.toString()));
    });
  }

}
