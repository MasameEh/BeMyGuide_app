

import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../settings/settings_screen.dart';

class VolunteerFeaturesScreen extends StatelessWidget {
  const VolunteerFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('volunteer features'),
      ),
      bottomNavigationBar: BottomNavigationBar(

          onTap: (index)
          {
            navigateTo(context, Settings());
          },
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ]
      ),

    );
  }
}
