import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/status/controller/status_controller.dart';

class TextStatusScreen extends ConsumerStatefulWidget {
  static const routeName = '/text-status';
  const TextStatusScreen({super.key});

  @override
  ConsumerState<TextStatusScreen> createState() => _TextStatusScreenState();
}

class _TextStatusScreenState extends ConsumerState<TextStatusScreen> {
  int backgroundColor = Colors.blue.value;
  double _value = 34;
  final TextEditingController _statusController = TextEditingController();
  bool _isShowEmojiPicker = false;
  final FocusNode _keyBoardNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _statusController.dispose();
    _keyBoardNode.dispose();
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  void colorChange() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: Color(backgroundColor),
              onColorChanged: (value) {
                setState(() {
                  backgroundColor = value.value;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void uploadTextStatus() {
    if (_statusController.text.trim().isEmpty) {
      return;
    }
    ref.read(statusControllerProvider).addNewStatus(
          context: context,
          title: _statusController.text.trim(),
          backgroundColor: backgroundColor,
          fontSize: _value,
          caption: " ",
          isSeen: false,
          statusType: StatusEnum.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(backgroundColor),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: TextField(
                        controller: _statusController,
                        focusNode: _keyBoardNode,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Type a status",
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: _value),
                        ),
                        maxLines: 25,
                        minLines: 1,
                        style: TextStyle(fontSize: _value),
                        onTap: () {
                          setState(() {
                            _isShowEmojiPicker = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                _isShowEmojiPicker
                    ? SizedBox(
                        height: 350,
                        child: EmojiPicker(
                          config: Config(
                            bgColor: Colors.black.withOpacity(0.9),
                          ),
                          textEditingController: _statusController,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close, size: 28),
                  ),
                  const Spacer(),
                  IconButton(
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
                    icon: const Icon(Icons.emoji_emotions, size: 28),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: colorChange,
                    icon: const Icon(Icons.color_lens, size: 28),
                  )
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 350,
              child: SfSlider.vertical(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
                min: 5,
                max: 100.0,
                interval: 10,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                activeColor: darken(Color(backgroundColor), .2),
                inactiveColor: Colors.white54,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: uploadTextStatus,
          shape: const CircleBorder(),
          backgroundColor: tabColor,
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
