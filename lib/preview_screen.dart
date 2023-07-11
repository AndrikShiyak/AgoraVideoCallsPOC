import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_test_app/call_screen.dart';
import 'package:agora_test_app/local_video_view.dart';
import 'package:agora_test_app/models/video_call_participant.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// const appId = "f470dd8524eb40c6ad99417bf58942d4";
// const token =
//     "007eJxTYLhTrLQvcca6B8tMOn48dW0tsFzn7rD8cn3aJU6RNU9DGs8oMKSZmBukpFiYGpmkJpkYJJslplhamhiaJ6WZWliaGKWYvP6+OqUhkJFBX4qNgREKQXxuhpLU4hLnjMS8vNQcBgYAw7MjaQ==";
// const channelName = "testChannel";

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({
    super.key,
    required this.appId,
    required this.token,
    required this.channelName,
  });

  final String appId;
  final String token;
  final String channelName;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  // int uid = 0; // uid of the local user
  // int? _remoteUid; // uid of the remote user
  late RtcEngine agoraEngine; // Agora engine instance

  // bool _isCameraOn = true;
  // bool _isMicrophoneOn = true;
  bool _previewStarted = false;
  late final VideoCallParticipant _localParticipant;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _localParticipant = VideoCallParticipant(
        uid: 0,
        isCameraEnabled: true,
        isAudioEnabled: true,
      );

      await setupVideoSDKEngine();
      _startPreview();
    });
  }

  // Release the resources when you leave
  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await agoraEngine.leaveChannel();
    await agoraEngine.stopPreview();
    agoraEngine.release();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(RtcEngineContext(
      appId: widget.appId,
      // appId: 'f470dd8524eb40c6ad99417bf58942d4',
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    // agoraEngine.registerEventHandler(
    //   RtcEngineEventHandler(
    //     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
    //       // showMessage(
    //       //     "Local user uid:${connection.localUid} joined the channel");
    //       // setState(() {
    //       //   _isJoined = true;
    //       // });
    //     },
    //     onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
    //       // showMessage("Remote user uid:$remoteUid joined the channel");
    //       setState(() {
    //         _remoteUid = remoteUid;
    //       });
    //     },
    //     onUserOffline: (RtcConnection connection, int remoteUid,
    //         UserOfflineReasonType reason) {
    //       // showMessage("Remote user uid:$remoteUid left the channel");
    //       setState(() {
    //         _remoteUid = null;
    //       });
    //     },
    //   ),
    // );
  }

  void _startPreview() async {
    await agoraEngine.startPreview();

    setState(() {
      _previewStarted = true;
    });
  }

  void _toggleAudio() async {
    final isAudioEnabled = _localParticipant.isAudioEnabled;

    setState(() {
      _localParticipant.isAudioEnabled = !isAudioEnabled;
    });
    await agoraEngine.enableLocalAudio(!isAudioEnabled);
  }

  void _togglePreview() async {
    final isCameraEnabled = _localParticipant.isCameraEnabled;

    if (isCameraEnabled) {
      await agoraEngine.stopPreview();
      await agoraEngine.enableLocalVideo(!isCameraEnabled);
    } else {
      await agoraEngine.startPreview();
      await agoraEngine.enableLocalVideo(!isCameraEnabled);
    }

    setState(() {
      _localParticipant.isCameraEnabled = !_localParticipant.isCameraEnabled;
    });

    print('adkfjjsdfjskdf ${_localParticipant.isCameraEnabled}');
  }

  void _join() async {
    // await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: widget.token,
      // token:
      //     '007eJxTYHBZVTZ7Nkv/HZUwv5eGa4qW/MxYwdu9bIqPu+fUKx1V39IUGNJMzA1SUixMjUxSk0wMks0SUywtTQzNk9JMLSxNjFJMPv1andIQyMhQtvEUKyMDBIL4XAzJGYl5eak5hkbGDAwAan4jHQ==',
      channelId: widget.channelName,
      // channelId: 'channel123',
      options: options,
      uid: _localParticipant.uid,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CallScreen(
          // isCameraOn: _isCameraOn,
          // isMicrophoneOn: _isMicrophoneOn,
          localParticipant: _localParticipant,
          agoraEngine: agoraEngine,
          // remoteUid: _remoteUid,
          channelName: widget.channelName,
          // channelName: 'channel123',
        ),
      ),
    );
  }

  // void leave() {
  //   setState(() {
  //     _isJoined = false;
  //     _remoteUid = null;
  //   });
  //   agoraEngine.leaveChannel();
  // }

  // void _leave() {
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _previewStarted
          ? Column(
              children: [
                Expanded(
                  child: LocalVideoView(
                    agoraEngine: agoraEngine,
                    participant: _localParticipant,
                    //  VideoCallParticipant(
                    //   uid: 0,
                    //   isCameraEnabled: true,
                    // ),
                  ),
                  // AgoraVideoView(
                  //   controller: VideoViewController(
                  //     rtcEngine: agoraEngine,
                  //     canvas: const VideoCanvas(
                  //       uid: 0,
                  //     ),
                  //   ),
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
                        icon: Icon(_localParticipant.isAudioEnabled
                            ? Icons.mic
                            : Icons.mic_off),
                        iconSize: 40,
                        color: Colors.white,
                      ),
                      // IconButton(
                      //   onPressed: _leave,
                      //   icon: const Icon(Icons.call_end),
                      //   iconSize: 40,
                      //   color: Colors.red,
                      // ),
                      IconButton(
                        onPressed: _togglePreview,
                        icon: Icon(_localParticipant.isCameraEnabled
                            ? Icons.videocam
                            : Icons.videocam_off),
                        iconSize: 40,
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: _join,
                        icon: const Icon(Icons.arrow_forward),
                        iconSize: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
