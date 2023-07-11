import 'package:agora_test_app/home_screen.dart';
import 'package:flutter/material.dart';

const appId = "f470dd8524eb40c6ad99417bf58942d4";
const token =
    "007eJxTYGALfMCfn3Mt+4nimWe7PZbWnL7Juu1FYorkkbv7P6uFFaxTYEgzMTdISbEwNTJJTTIxSDZLTLG0NDE0T0oztbA0MUoxWTVpVUpDICMD2+JWBkYoBPG5GUpSi0ucMxLz8lJzGBgAw+oj0w==";
const channelName = "testChannel";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Build UI
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // scaffoldMessengerKey: scaffoldMessengerKey,
      home: HomeScreen(),
      //  Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Get started with Video Calling'),
      //   ),
      //   body: _isConnected
      //       ? PreviewScreen(
      //           agoraEngine: agoraEngine,
      //           uid: uid,
      //         )
      //       : Center(
      //           child: ElevatedButton(
      //             onPressed: _openPreview,
      //             child: const Text("Connect"),
      //           ),
      //         ),

      //   // ListView(
      //   //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      //   //   children: [
      //   //     // Container for the local video
      //   //     Container(
      //   //       height: 240,
      //   //       decoration: BoxDecoration(border: Border.all()),
      //   //       child: Center(child: _localPreview()),
      //   //     ),
      //   //     const SizedBox(height: 10),
      //   //     //Container for the Remote video
      //   //     Container(
      //   //       height: 240,
      //   //       decoration: BoxDecoration(border: Border.all()),
      //   //       child: Center(child: _remoteVideo()),
      //   //     ),
      //   //     // Button Row
      //   //     Row(
      //   //       children: <Widget>[
      //   //         Expanded(
      //   //           child: ElevatedButton(
      //   //             onPressed: _isJoined ? null : () => {join()},
      //   //             child: const Text("Join"),
      //   //           ),
      //   //         ),
      //   //         const SizedBox(width: 10),
      //   //         Expanded(
      //   //           child: ElevatedButton(
      //   //             onPressed: _isJoined ? () => {leave()} : null,
      //   //             child: const Text("Leave"),
      //   //           ),
      //   //         ),
      //   //       ],
      //   //     ),
      //   //     if (_isJoined) ...[
      //   //       Row(
      //   //         children: <Widget>[
      //   //           Expanded(
      //   //             child: ElevatedButton(
      //   //               onPressed: _videoEnabled ? null : enableVideo,
      //   //               child: const Text("Enable Video"),
      //   //             ),
      //   //           ),
      //   //           const SizedBox(width: 10),
      //   //           Expanded(
      //   //             child: ElevatedButton(
      //   //               onPressed: _videoEnabled ? disableVideo : null,
      //   //               child: const Text("Disable Video"),
      //   //             ),
      //   //           ),
      //   //         ],
      //   //       ),
      //   //       Row(
      //   //         children: <Widget>[
      //   //           Expanded(
      //   //             child: ElevatedButton(
      //   //               onPressed: _isMuted ? null : mute,
      //   //               child: const Text("Mute"),
      //   //             ),
      //   //           ),
      //   //           const SizedBox(width: 10),
      //   //           Expanded(
      //   //             child: ElevatedButton(
      //   //               onPressed: _isMuted ? unMute : null,
      //   //               child: const Text("Unmute"),
      //   //             ),
      //   //           ),
      //   //         ],
      //   //       ),
      //   //     ],
      //   //     // Button Row ends
      //   //   ],
      //   // )),
      // ),
    );
  }

// Display local video preview
//   Widget _localPreview() {
//     // if (_isJoined) {
//     //   if (_videoEnabled) {
//     if (_isConnected) {
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: agoraEngine,
//           canvas: VideoCanvas(uid: 0),
//         ),
//       );
//     } else {
//       return const Text(
//         'Video disabled',
//         textAlign: TextAlign.center,
//       );
//     }

//     //   } else {
//     //     return const Text(
//     //       'Video disabled',
//     //       textAlign: TextAlign.center,
//     //     );
//     //   }
//     // } else {
//     //   return const Text(
//     //     'Join a channel',
//     //     textAlign: TextAlign.center,
//     //   );
//     // }
//   }

// // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: agoraEngine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: channelName),
//         ),
//       );
//     } else {
//       String msg = '';
//       if (_isJoined) msg = 'Waiting for a remote user to join';
//       return Text(
//         msg,
//         textAlign: TextAlign.center,
//       );
//     }
//   }
}
