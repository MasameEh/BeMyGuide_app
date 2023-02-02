import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/network/endpoints.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {

  AppLoginCubit() : super(AppLoginInitialState());
  static AppLoginCubit get(context) => BlocProvider.of(context);

  AppLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = AppLoginModel.fromJson(value.data);
      emit(AppLoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(AppLoginErrorState(error.toString()));
    });
  }
}
