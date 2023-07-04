// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late CachedVideoPlayerController videoController;
  bool isPlaying = false;

  @override
  void initState() {
    videoController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoController.setVolume(1);
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: Stack(
        children: [
          CachedVideoPlayer(videoController),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (isPlaying) {
                    videoController.pause();
                  } else {
                    videoController.play();
                    videoController.initialize();
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
