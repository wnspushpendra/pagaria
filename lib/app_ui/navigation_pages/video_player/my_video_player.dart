import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final FlickManager flickManager;
  const MyVideoPlayer({super.key, required this.flickManager});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {




  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
        flickManager: widget.flickManager
    );
  }
}
