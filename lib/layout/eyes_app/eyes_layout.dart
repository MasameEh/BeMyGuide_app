
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../modules/blind_features/blindfeatures_screen.dart';
import '../../modules/volunteer/volunteerfeatures_screen.dart';

class EyesLayout extends StatelessWidget {
  const EyesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.cyan,
              child: TextButton(onPressed: (){
                navigateTo(context, BlindFeaturesScreen());
              },
                  child: Text(
                    'want to be helped',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
              ),
            ),
            SizedBox(
                height:50.0
            ),
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.cyan,
              child: TextButton(onPressed: (){
                navigateTo(context, VolunteerFeaturesScreen());
              },
                child: Text(
                  'want to volunteer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
