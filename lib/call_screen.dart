import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_test_app/local_video_view.dart';
import 'package:agora_test_app/models/video_call_participant.dart';
import 'package:agora_test_app/remote_video_view.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    // required this.isCameraOn,
    // required this.isMicrophoneOn,
    required this.agoraEngine,
    required this.channelName,
    required this.localParticipant,
  });

  // final bool isCameraOn;
  // final bool isMicrophoneOn;
  final RtcEngine agoraEngine;
  final String channelName;
  final VideoCallParticipant localParticipant;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // late bool _isCameraOn;
  // late bool _isMicrophoneOn;
  // int? _remoteUid;
  // final Set<int> _remoteUid = {};
  final Set<VideoCallParticipant> _remoteParticipants = {};
  // late final VideoCallParticipant _localParticipant;

  @override
  void initState() {
    super.initState();

    // _isCameraOn = widget.isCameraOn;
    // _isMicrophoneOn = widget.isMicrophoneOn;

    // _localParticipant =
    //     VideoCallParticipant(uid: 0, isCameraEnabled: _isCameraOn);

    _registerCallbacks();
  }

  @override
  void dispose() {
    super.dispose();
    widget.agoraEngine.leaveChannel();
  }

  void _registerCallbacks() {
    widget.agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          // showMessage(
          //     "Local user uid:${connection.localUid} joined the channel");
          // setState(() {
          //   _isJoined = true;
          // });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            // _remoteUid.add(rUid);
            _remoteParticipants.add(
              VideoCallParticipant(uid: remoteUid),
            );
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            // _remoteUid.removeWhere((element) => element == rUid);
            _remoteParticipants
                .removeWhere((element) => element.uid == remoteUid);
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          // setState(() {
          //   _remoteUid.clear();
          // });
        },
        onRemoteVideoStateChanged:
            (connection, remoteUid, RemoteVideoState state, reason, elapsed) {
          final participant = _remoteParticipants
              .firstWhere((element) => element.uid == remoteUid);
          if (state == RemoteVideoState.remoteVideoStateStarting) {
            setState(() {
              participant.isCameraEnabled = true;
            });
          } else if (state == RemoteVideoState.remoteVideoStateStopped) {
            setState(() {
              participant.isCameraEnabled = false;
            });
          }

          print('afjksdjlfsdkf $state');
        },
      ),
    );
  }

  void _toggleVideo() async {
    final isCameraEnabled = widget.localParticipant.isCameraEnabled;

    if (isCameraEnabled) {
      // await agoraEngine.stopPreview();
      await widget.agoraEngine.enableLocalVideo(!isCameraEnabled);
    } else {
      // await agoraEngine.startPreview();
      await widget.agoraEngine.enableLocalVideo(!isCameraEnabled);
    }

    setState(() {
      // _isCameraOn = !_isCameraOn;
      widget.localParticipant.isCameraEnabled = !isCameraEnabled;
    });

    // print('dsjkfjskdflks $_isCameraOn');
  }

  void _toggleAudio() async {
    setState(() {
      widget.localParticipant.isAudioEnabled =
          !widget.localParticipant.isAudioEnabled;

      // _isMicrophoneOn = !_isMicrophoneOn;
    });
    await widget.agoraEngine
        .enableLocalAudio(widget.localParticipant.isAudioEnabled);
  }

  void _leave() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                LocalVideoView(
                  agoraEngine: widget.agoraEngine,
                  // uid: _isCameraOn ? 0 : 1,
                  participant: widget.localParticipant,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // children: List.of(_remoteUid.map(
                      children: List.of(
                        _remoteParticipants.map(
                          (e) => RemoteVideoView(
                            agoraEngine: widget.agoraEngine,
                            channelName: widget.channelName,
                            participant: e,
                            // uid: e.uid,
                            // isCameraEnabled: e.isCameraEnabled,
                          ),
                          // AgoraVideoView(
                          //   controller: VideoViewController.remote(
                          //     rtcEngine: widget.agoraEngine,
                          //     canvas: VideoCanvas(uid: e),
                          //     connection:
                          //         RtcConnection(channelId: _controller.text),
                          //     useFlutterTexture: _isUseFlutterTexture,
                          //     useAndroidSurfaceView: _isUseAndroidSurfaceView,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                //  Column(
                //   children: [
                //     Container(
                //       height: 240,
                //       decoration: BoxDecoration(border: Border.all()),
                //       child: Center(child: _localPreview()),
                //     ),
                //     const SizedBox(height: 10),
                //     //Container for the Remote video
                //     Container(
                //       height: 240,
                //       decoration: BoxDecoration(border: Border.all()),
                //       child: Center(child: _remoteVideo()),
                //     ),
                //   ],
                // ),
                ),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: _toggleAudio,
                    icon: Icon(widget.localParticipant.isAudioEnabled
                        ? Icons.mic
                        : Icons.mic_off),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: _leave,
                    icon: const Icon(Icons.call_end),
                    iconSize: 40,
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: _toggleVideo,
                    icon: Icon(widget.localParticipant.isCameraEnabled
                        ? Icons.videocam
                        : Icons.videocam_off),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // // Display local video preview
  // Widget _localPreview() {
  //   if (_isCameraOn) {
  //     return AgoraVideoView(
  //       controller: VideoViewController(
  //         rtcEngine: widget.agoraEngine,
  //         canvas: VideoCanvas(uid: _isCameraOn ? 0 : 1),
  //       ),
  //     );
  //   } else {
  //     return const Text(
  //       'Video disabled',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }

  // // Display remote user's video
  // Widget _remoteVideo() {
  //   if (_remoteUid != null) {
  //     return AgoraVideoView(
  //       controller: VideoViewController.remote(
  //         rtcEngine: widget.agoraEngine,
  //         canvas: VideoCanvas(uid: _remoteUid),
  //         connection: RtcConnection(channelId: widget.channelName),
  //       ),
  //     );
  //   } else {
  //     const msg = 'Waiting for a remote user to join';
  //     return const Text(
  //       msg,
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }
}
