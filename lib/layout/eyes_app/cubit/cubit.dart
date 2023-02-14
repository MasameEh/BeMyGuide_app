
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/eyes_app/cubit/states.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';

import '../../../models/login_model.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserDataModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(CacheHelper.getData(key:'uId')).get().then((value) {
      print(value.data());

      userModel = UserDataModel.fromJson(value.data());
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }


  void updateUser({
    required String name,
    required String phone,
  }) {
    emit(AppUserUpdateLoadingState());

    UserDataModel model = UserDataModel(
      name: name,
      phone: phone,
      email: userModel?.email,
      uId: userModel?.uId,
      // isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUserUpdateErrorState());
    });
  }
}