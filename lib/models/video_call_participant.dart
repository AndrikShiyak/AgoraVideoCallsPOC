import 'package:equatable/equatable.dart';

class VideoCallParticipant extends Equatable {
  VideoCallParticipant({
    required this.uid,
    this.isCameraEnabled = false,
    this.isAudioEnabled = false,
  });

  final int uid;
  bool isCameraEnabled;
  bool isAudioEnabled;

  @override
  List<Object?> get props => [uid];
}
