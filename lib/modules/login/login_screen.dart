

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project/layout/eyes_app/eyes_layout.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPass = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if(state is AppLoginSuccessState) {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId)
                .then((value) {
              navigateAndFinish(context, EyesLayout());

            });
          }
            if(state is AppLoginErrorState)
            {
              showToast(
                  text: state.error,
                  state: ToastStates.ERROR,
              );
            }
            // if(state.loginModel.status == true)
            // {
            //   print(state.loginModel.message);
            //   print(state.loginModel.data?.token);
            //   CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
            //   {
            //     navigateAndFinish(context,  EyesLayout());
            //   });
            // }else
            // {
              // print(state.loginModel.message);
              //
              // Fluttertoast.showToast(
              //     msg:  state.loginModel.message,
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
            // }

        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsetsDirectional.only(start: 15.0),
                child: Text(
                  'See',
                  style: TextStyle(
                    color: Colors.white,) ,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text('Login',
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailAddressController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate())
                            {
                              AppLoginCubit.get(context).userLogin(
                                email: emailAddressController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          isPassword: isPass,
                          suffix: isPass? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          suffixPressed: ()
                          {
                            setState(() {
                              isPass =! isPass;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate())
                              {
                                AppLoginCubit.get(context).userLogin(
                                  email: emailAddressController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN' ,
                            background: Colors.cyan,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen(),);
                              },
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.cyan,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
