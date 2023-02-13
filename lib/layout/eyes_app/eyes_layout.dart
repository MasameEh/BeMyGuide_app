
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/eyes_app/cubit/cubit.dart';
import 'package:graduation_project/layout/eyes_app/cubit/states.dart';

import 'package:graduation_project/shared/components/components.dart';

import '../../modules/blind_features/blindfeatures_screen.dart';

import '../../modules/volunteer/volunteerfeatures_screen.dart';
import '../../shared/network/local/cache_helper.dart';

class EyesLayout extends StatefulWidget {
  const EyesLayout({Key? key}) : super(key: key);

  @override
  State<EyesLayout> createState() => _EyesLayoutState();
}

class _EyesLayoutState extends State<EyesLayout> {



  void submit(){
    CacheHelper.saveData(
      key: 'isBlind',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
             BlindFeaturesScreen(),
        );
      }
    });
  }
  void submit1(){
    CacheHelper.saveData(
      key: 'isVolunteer',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
           VolunteerFeaturesScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state)
        {

          },
        builder: (context, state){

          return  Scaffold(
            appBar: AppBar(
              title: Text('See',
              style: TextStyle(
                color: Colors.white ,
              )
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(
                        height: 200.0,
                         width: 320.0 ,
                        function: () {
                            submit();
                            CacheHelper.putBoolean(key: 'isVolunteer', value: false);
                        },
                        text: 'I want an assistant' ,
                        background: Colors.cyan,
                      ),
                      SizedBox(
                          height:50.0
                      ),
                      defaultButton(
                        height: 200.0,
                         width: 320.0 ,
                        function: () {
                          submit1();
                          CacheHelper.putBoolean(key: 'isBlind', value: false);
                        },
                        text: 'I want to volunteer' ,
                        background: Colors.cyan,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          );
        },
    );
  }
}
