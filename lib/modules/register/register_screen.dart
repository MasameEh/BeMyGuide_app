
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

import '../../layout/eyes_app/eyes_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  bool isPass = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, state) {
          if(state is AppCreateUserSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId);
            navigateAndFinish(context,  EyesLayout());
            // if(state.loginModel.status == true)
            // {
            //   print(state.loginModel.message);
            //   print(state.loginModel.data?.token);
            //   CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
            //   {
            //
            //     navigateAndFinish(context,  EyesLayout());
            //   });
            // }else
            // {
            //   print(state.loginModel.message);
            //
            //   Fluttertoast.showToast(
            //       msg:  state.loginModel.message,
            //       toastLength: Toast.LENGTH_LONG,
            //       gravity: ToastGravity.BOTTOM,
            //       timeInSecForIosWeb: 5,
            //       backgroundColor: Colors.red,
            //       textColor: Colors.white,
            //       fontSize: 16.0
            //   );
            // }
          }
          if(state is AppRegisterErrorState)
          {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Colors.white, //
              ),
              leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_outlined),
              ),
            ),
            body: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/SignUp.png'),
                          fit: BoxFit.fill,),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset('assets/gp-logo.png',
                              scale:2,
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.height*.35,),
                            Text("Sign Up",
                              style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0,
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
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    defaultFormField(
                                      controller: nameController,
                                      type: TextInputType.name,
                                      validate: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your name';
                                        }
                                        return null;
                                      },
                                      label: 'User Name',
                                      prefix: Icons.person,
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
                                          AppRegisterCubit.get(context).userRegister(
                                            email: emailAddressController.text,
                                            password: passwordController.text,
                                            name: nameController.text ,
                                            phone: phoneController.text ,
                                          );
                                        }
                                      },
                                      validate: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your password';
                                        }else if(value.length < 6){
                                          return 'password is too short';
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
                                    defaultFormField(
                                      controller: phoneController,
                                      type: TextInputType.phone,
                                      validate: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your phone number';
                                        }
                                        return null;
                                      },
                                      label: 'Phone Number',
                                      prefix: Icons.phone,
                                    ),
                                    SizedBox(
                                        height: 15.0
                                    ),
                                    ConditionalBuilder(
                                      condition: state is! AppRegisterLoadingState,
                                      builder: (context) => defaultButton(
                                        function: () {
                                          if (formKey.currentState!.validate())
                                          {
                                            AppRegisterCubit.get(context).userRegister(
                                              email: emailAddressController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                            );
                                          }
                                        },
                                        text: 'Sign up' ,
                                        width: 150.0,
                                        radius: 40.0,
                                        background: lighten(Colors.pink, .2),
                                      ),
                                      fallback: (context) => Center(child: CircularProgressIndicator()),
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

