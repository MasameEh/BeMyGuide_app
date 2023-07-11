import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

import '../../shared/components/localization/app_local.dart';
import '../../shared/network/video_call_api.dart';
import 'ils_screen.dart';

class JoinScreen extends StatelessWidget {
  final _meetingIdController = TextEditingController();

  JoinScreen({super.key});

  //Creates new Meeting Id and joins it in CONFERNCE mode.
  void onCreateButtonPressed(BuildContext context) async {
    // call api to create meeting and navigate to ILSScreen with meetingId,token and mode
    await createMeeting().then((meetingId) {
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: Mode.CONFERENCE,
          ),
        ),
      );
    });
  }

  //Join the provided meeting with given Mode and meetingId
  void onJoinButtonPressed(BuildContext context, Mode mode) {
    // check meeting id is not null or invaild
    // if meeting id is vaild then navigate to ILSScreen with meetingId, token and mode
    String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: mode,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${getLang(context, "Please enter valid meeting id")}"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white, //
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Home_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Text(
                  "${getLang(context, 'feature2')}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      color: Colors.white),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                //Creating a new meeting
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Color.fromARGB(255, 250, 250, 250),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/gp-logo.png',
                                  scale: 6,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('BeMyGuide',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 180, 31, 87))),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => onCreateButtonPressed(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 180, 31, 87)),
                          ),
                          child: Text("${getLang(context, 'Create Meeting')}"),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            hintText: "${getLang(context, 'Enter Meeting Id')}",
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          controller: _meetingIdController,
                        ),
                        const SizedBox(height: 20),
                        //Joining the meeting as viewer
                        ElevatedButton(
                          onPressed: () =>
                              onJoinButtonPressed(context, Mode.CONFERENCE),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 180, 31, 87)),
                          ),
                          child: Text("${getLang(context, 'Join_b')}"),
                        ),
                        Image.asset(
                          'assets/Header.png',
                          scale: 1,
                          fit: BoxFit.fitHeight,
                          opacity: const AlwaysStoppedAnimation(.3),
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
    );
  }
}
