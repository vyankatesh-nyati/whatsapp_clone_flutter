import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/controller/chat_details_controller.dart';

class BottomMessageSheet extends ConsumerStatefulWidget {
  const BottomMessageSheet({super.key});

  @override
  ConsumerState<BottomMessageSheet> createState() => _BottomMessageSheetState();
}

class _BottomMessageSheetState extends ConsumerState<BottomMessageSheet> {
  final TextEditingController _messageEdiitingController =
      TextEditingController();
  final FocusNode _keyBoardNode = FocusNode();
  bool showSendButton = false;
  bool _isShowEmojiPicker = false;
  FlutterSoundRecorder? _soundRecorder;
  bool _isInitRecorder = false;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    openAudio();
  }

  @override
  void dispose() {
    super.dispose();
    _messageEdiitingController.dispose();
    _soundRecorder!.closeRecorder();
    _isInitRecorder = false;
  }

  void openAudio() async {
    _soundRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (context.mounted) {
        showSnackbar(
            context: context, content: "Mic permission is not allowed");
      }
    } else {
      await _soundRecorder!.openRecorder();
      _isInitRecorder = true;
    }
  }

  void sendMessage() {
    if (showSendButton) {
      final String text = _messageEdiitingController.text;
      final timesent = DateFormat.Hm().format(DateTime.now());

      ref.read(chatDetailsControllerProvider).sendTextMessage(
            timesent: timesent,
            text: text,
            type: MessageEnum.text,
            context: context,
          );

      _messageEdiitingController.clear();
      setState(() {
        showSendButton = false;
      });
    } else {
      if (!_isInitRecorder) {
        return;
      }
    }
  }

  void sendImage() async {
    File? pickedFile = await pickImageFormGallery(context);
    if (pickedFile != null) {
      final timesent = DateFormat.Hm().format(DateTime.now());
      if (context.mounted) {
        ref.read(chatDetailsControllerProvider).sendFileMessage(
              timesent: timesent,
              chatImage: pickedFile,
              type: MessageEnum.image,
              context: context,
            );
      }
    }
  }

  void sendVideo() async {
    File? pickedVideo = await pickVideoFromGallery(context);
    if (pickedVideo != null) {
      final timesent = DateFormat.Hm().format(DateTime.now());
      if (context.mounted) {
        ref.read(chatDetailsControllerProvider).sendFileMessage(
              timesent: timesent,
              chatImage: pickedVideo,
              type: MessageEnum.video,
              context: context,
            );
      }
    }
  }

  void sendAudio() async {
    if (!_isInitRecorder) {
      return;
    }
    final Directory tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/flutter_sound.aac';

    if (_isRecording) {
      await _soundRecorder!.stopRecorder();
      final timesent = DateFormat.Hm().format(DateTime.now());
      if (context.mounted) {
        ref.read(chatDetailsControllerProvider).sendFileMessage(
              timesent: timesent,
              chatImage: File(path),
              type: MessageEnum.audio,
              context: context,
            );
      }
    } else {
      await _soundRecorder!.startRecorder(toFile: path);
    }
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageEdiitingController,
                focusNode: _keyBoardNode,
                onTap: () {
                  setState(() {
                    _isShowEmojiPicker = false;
                  });
                },
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    setState(() {
                      showSendButton = false;
                    });
                  } else {
                    setState(() {
                      showSendButton = true;
                    });
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Message",
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
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: sendVideo,
                        icon: const Icon(Icons.video_camera_back),
                        color: appBarTextColor,
                      ),
                      // const SizedBox(width: 10),
                      // Icon(
                      //   Icons.gif,
                      //   color: appBarTextColor,
                      // ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: sendImage,
                        icon: const Icon(Icons.camera_alt),
                        color: appBarTextColor,
                      ),
                      const SizedBox(width: 20),
                    ],
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
            showSendButton
                ? CircleAvatar(
                    backgroundColor: tabColor,
                    radius: 28,
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: tabColor,
                    radius: 28,
                    child: IconButton(
                      onPressed: sendAudio,
                      icon: Icon(_isRecording ? Icons.close : Icons.mic),
                    ),
                  ),
          ],
        ),
        _isShowEmojiPicker
            ? SizedBox(
                height: 350,
                child: EmojiPicker(
                  textEditingController: _messageEdiitingController,
                  onEmojiSelected: (category, emoji) {
                    if (_messageEdiitingController.text.trim().isEmpty) {
                      setState(() {
                        showSendButton = false;
                      });
                    } else {
                      setState(() {
                        showSendButton = true;
                      });
                    }
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
