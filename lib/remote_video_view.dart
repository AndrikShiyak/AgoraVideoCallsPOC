import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_test_app/models/video_call_participant.dart';
import 'package:flutter/material.dart';

class RemoteVideoView extends StatelessWidget {
  const RemoteVideoView({
    super.key,
    required this.agoraEngine,
    // required this.uid,
    required this.channelName,
    // required this.isCameraEnabled,
    required this.participant,
  });

  final RtcEngine agoraEngine;
  // final int uid;
  final String channelName;
  // final bool isCameraEnabled;
  final VideoCallParticipant participant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: participant.isCameraEnabled
          ? AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: agoraEngine,
                canvas: VideoCanvas(uid: participant.uid),
                connection: RtcConnection(channelId: channelName),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
    );
  }
}
