// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/status/controller/status_controller.dart';

class CheckUploadedFileScreen extends ConsumerStatefulWidget {
  static const routeName = '/check-uploaded-file';

  const CheckUploadedFileScreen({
    Key? key,
    required this.pickedFile,
  }) : super(key: key);

  final File pickedFile;

  @override
  ConsumerState<CheckUploadedFileScreen> createState() =>
      _CheckUploadedFileScreenState();
}

class _CheckUploadedFileScreenState
    extends ConsumerState<CheckUploadedFileScreen> {
  late int fileTypeLastIndex;
  late String fileType;
  late CachedVideoPlayerController videoController;
  bool isPlaying = false;
  bool _isShowEmojiPicker = false;
  final FocusNode _keyBoardNode = FocusNode();
  final TextEditingController _captionEditiongController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fileTypeLastIndex = widget.pickedFile.path.lastIndexOf('.');
    fileType = widget.pickedFile.path.substring(fileTypeLastIndex + 1);
    if (fileType != "jpg" || fileType != "png" || fileType != "jpeg") {
      videoController = CachedVideoPlayerController.file(widget.pickedFile)
        ..initialize().then((value) {
          videoController.setVolume(1);
          videoController.play();
          videoController.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    _captionEditiongController.dispose();
  }

  void uploadImageVideoStatus() {
    StatusEnum statusType = StatusEnum.video;
    if (fileType == "jpg" || fileType == "png" || fileType == "jpeg") {
      statusType = StatusEnum.image;
    }
    ref.read(statusControllerProvider).addNewStatus(
          context: context,
          title: "",
          backgroundColor: Colors.blue.value,
          fontSize: 34,
          caption: _captionEditiongController.text.trim(),
          isSeen: false,
          statusType: statusType,
          statusFile: widget.pickedFile,
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: CachedVideoPlayer(videoController),
    );

    if (fileType == "jpg" || fileType == "png" || fileType == "jpeg") {
      bodyContent = Image.file(widget.pickedFile);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: bodyContent,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 8,
              right: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _captionEditiongController,
                          focusNode: _keyBoardNode,
                          maxLines: 1,
                          onTap: () {
                            setState(() {
                              _isShowEmojiPicker = false;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Add a caption...",
                            filled: true,
                            fillColor: mobileChatBoxColor,
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.emoji_emotions),
                              onPressed: () {
                                if (_isShowEmojiPicker) {
                                  setState(() {
                                    _isShowEmojiPicker = !_isShowEmojiPicker;
                                    _keyBoardNode.requestFocus();
                                  });
                                } else {
                                  setState(() {
                                    _isShowEmojiPicker = !_isShowEmojiPicker;
                                    _keyBoardNode.unfocus();
                                  });
                                }
                              },
                              color: appBarTextColor,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: tabColor,
                        radius: 28,
                        child: IconButton(
                          onPressed: uploadImageVideoStatus,
                          icon: const Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                  _isShowEmojiPicker
                      ? SizedBox(
                          height: 350,
                          child: EmojiPicker(
                            textEditingController: _captionEditiongController,
                            config: Config(
                              bgColor: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
