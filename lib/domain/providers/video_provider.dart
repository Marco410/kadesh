import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoControllerProvider =
    FutureProvider<VideoPlayerController>((ref) async {
  final controller = VideoPlayerController.asset(
    'assets/video/dogs.mp4',
    videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
  );
  await controller.initialize();
  controller.setLooping(true);
  controller.setVolume(0);
  await controller.setPlaybackSpeed(0.7);
  controller.play();
  return controller;
});
