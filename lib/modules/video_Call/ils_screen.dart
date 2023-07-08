import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

import 'ils_speaker_view.dart';
import 'ils_viewer_view.dart';

class ILSScreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final Mode mode;

  const ILSScreen(
      {super.key,
      required this.meetingId,
      required this.token,
      required this.mode});

  @override
  State<ILSScreen> createState() => _ILSScreenState();
}

class _ILSScreenState extends State<ILSScreen> {
  late Room _room;
  bool isJoined = false;

  @override
  void initState() {
    // create room when widget loads
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "John Doe",
      micEnabled: true,
      camEnabled: true,
      defaultCameraIndex:
          1, // Index of MediaDevices will be used to set default camera
      mode: widget.mode,
    );

    // setting the event listener for join and leave events
    setMeetingEventListener();

    // Joining room
    _room.join();

    super.initState();
  }

  // listening to room events
  void setMeetingEventListener() {
    //Setting the joining flag to true when meeting is joined
    _room.on(Events.roomJoined, () {
      if (widget.mode == Mode.CONFERENCE) {
        _room.localParticipant.pin();
      }
      setState(() {
        isJoined = true;
      });
    });

    //Handling navigation when meeting is left
    _room.on(Events.roomLeft, () {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 180, 31, 87),
          title: const Text(
            'VideoSDK ILS QuickStart',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        //Showing the Speaker or Viewer View based on the mode
        body: isJoined
            ? widget.mode == Mode.CONFERENCE
                ? ILSSpeakerView(room: _room)
                : widget.mode == Mode.VIEWER
                    ? ILSViewerView(room: _room)
                    : null
            : const Center(
                child: Text(
                  "Joining...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
