import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/network/endpoints.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {

  AppRegisterCubit() : super(AppRegisterInitialState());
  static AppRegisterCubit get(context) => BlocProvider.of(context);

  AppLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = AppLoginModel.fromJson(value.data);
      emit(AppRegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(AppRegisterErrorState(error.toString()));
    });
  }
}
