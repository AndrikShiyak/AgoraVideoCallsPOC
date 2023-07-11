import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_test_app/models/video_call_participant.dart';
import 'package:flutter/material.dart';

class LocalVideoView extends StatefulWidget {
  const LocalVideoView({
    super.key,
    required this.agoraEngine,
    // required this.uid,
    required this.participant,
  });

  final RtcEngine agoraEngine;
  // final int uid;
  final VideoCallParticipant participant;

  @override
  State<LocalVideoView> createState() => _LocalVideoViewState();
}

class _LocalVideoViewState extends State<LocalVideoView> {
  @override
  void didUpdateWidget(covariant LocalVideoView oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('jskdfklsdlkfs ${widget.participant.isCameraEnabled}');
  }

  @override
  Widget build(BuildContext context) {
    print('sdjfjksdfs ${widget.participant.isCameraEnabled}');
    return widget.participant.isCameraEnabled
        ? AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: widget.agoraEngine,
              canvas: VideoCanvas(uid: widget.participant.uid),
            ),
          )
        : Container(color: Colors.black);
  }
}
