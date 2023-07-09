import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../layout/eyes_app/cubit/cubit.dart';
import '../../layout/eyes_app/cubit/states.dart';
import '../../shared/components/localization/app_local.dart';
import '../../shared/network/styles/colors.dart';

class Settings extends StatelessWidget {
  var emailAddressController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        nameController.text = (userModel?.name)!;
        phoneController.text = (userModel?.phone)!;
        emailAddressController.text = (userModel?.email)!;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text("${getLang(context, 'Settings')}"),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white, //
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Container(
                width: 34.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white.withOpacity(.3),
                ),
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Home_background.png'),
                  opacity: 80.0,
                  fit: BoxFit.fill,
                ),
              ),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Image.asset(
                        'assets/gp-logo.png',
                        scale: 2,
                        fit: BoxFit.fitHeight,
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Color.fromARGB(255, 250, 250, 250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "${getLang(context, 'please enter your name')}";
                                  }
                                  return null;
                                },
                                label: "${getLang(context, 'User Name')}",
                                prefix: Icons.person,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                controller: emailAddressController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "${getLang(context, 'please enter your email address')}";
                                  }
                                  return null;
                                },
                                label: "${getLang(context, 'Email Address')}",
                                prefix: Icons.email_outlined,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "${getLang(context, 'please enter your phone number')}";
                                  }
                                  return null;
                                },
                                label: "${getLang(context, 'Phone Number')}",
                                prefix: Icons.phone,
                              ),
                              const SizedBox(height: 15.0),
                              ConditionalBuilder(
                                condition: state is! AppUserUpdateLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      AppCubit.get(context).updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: "${getLang(context, 'update')}",
                                  width: 150.0,
                                  radius: 40.0,
                                  background: lighten(Colors.pink, .2),
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              const SizedBox(height: 15.0),
                              defaultButton(
                                function: () {
                                  signOut(context);
                                },
                                text: 'Sign out',
                                width: 150.0,
                                radius: 40.0,
                                background: lighten(Colors.pink, .2),
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
    );
  }
}
