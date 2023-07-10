import 'package:flutter/material.dart';

class MeetingControls extends StatefulWidget {
  final String hlsState;
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onHLSButtonPressed;

  const MeetingControls({
    Key? key,
    required this.hlsState,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onHLSButtonPressed,
  }) : super(key: key);

  @override
  _MeetingControlsState createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool _isFrontCamera = true; // Initial camera selection

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    widget.onToggleCameraButtonPressed(); // Call the provided callback
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: widget.onToggleMicButtonPressed,
          child: const Text('Toggle Mic'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _toggleCamera,
          child: Text(_isFrontCamera ? 'Front Camera' : 'Back Camera'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: widget.onHLSButtonPressed,
          child: Text(
            widget.hlsState == "HLS_STOPPED"
                ? 'Start HLS'
                : widget.hlsState == "HLS_STARTING"
                    ? "Starting HLS"
                    : widget.hlsState == "HLS_STARTED" ||
                            widget.hlsState == "HLS_PLAYABLE"
                        ? "Stop HLS"
                        : widget.hlsState == "HLS_STOPPING"
                            ? "Stopping HLS"
                            : "Start HLS",
          ),
        ),
      ],
    );
  }
}
