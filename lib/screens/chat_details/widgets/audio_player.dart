// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

class AudioPlayer extends ConsumerStatefulWidget {
  const AudioPlayer({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageModel messageData;

  @override
  ConsumerState<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends ConsumerState<AudioPlayer> {
  FlutterSoundPlayer? _audioPlayer;
  bool _isInitSoundPlayer = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    openPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer!.closePlayer();
  }

  void openPlayer() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openPlayer();
    _isInitSoundPlayer = true;
  }

  void audioPlayer() async {
    if (!_isInitSoundPlayer) {
      return;
    }
    if (_isPlaying) {
      await _audioPlayer!.pausePlayer();
    } else {
      await _audioPlayer!.startPlayer(
        fromURI: widget.messageData.text,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final otherProfileUrl = ref.watch(chatDetailsProvider).profileUrl;
    final userDetails = ref.watch(userProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            widget.messageData.senderId == userDetails!.id
                ? userDetails.profileUrl
                : otherProfileUrl,
          ),
        ),
        IconButton(
          onPressed: audioPlayer,
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 40,
            color: appBarTextColor,
          ),
        ),
      ],
    );
  }
}
