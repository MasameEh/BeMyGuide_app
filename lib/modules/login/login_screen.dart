

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graduation_project/layout/eyes_app/eyes_layout.dart';
import 'package:graduation_project/modules/forgotpass/forgotpassScreen.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
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
            body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/SignUp.png'),
                      fit: BoxFit.fill,),
                  ),
                    child: Form(
                      key: formKey,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset('assets/gp-logo.png',
                              scale:2,
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.height*.35,),
                            Text("Log In",
                              style:  GoogleFonts.acme(
                                color: Colors.white,
                                fontSize: 45.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                             Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:Radius.circular(40),
                                      topRight: Radius.circular(40)
                                  ),
                                  color: Color.fromARGB(255, 250, 250, 250),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height:20.0 ,),
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
                                        prefix: Icons.email_rounded,
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
                                          } else if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                        label: 'Password',
                                        prefix: Icons.lock_rounded,
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
                                          width: 150.0,
                                          radius: 40.0,
                                          text: 'Log In' ,
                                          background: lighten(Colors.pink, .2),
                                        ),
                                        fallback: (context) => Center(child: CircularProgressIndicator()),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateTo(context, ForgotPassword(),);
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                            color: darken(Colors.blue, .2),
                                          ),
                                        ),
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
                                              'Sign Up',
                                              style:
                                              TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontWeight: FontWeight.w600,
                                                color: darken(Colors.blue, .2),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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