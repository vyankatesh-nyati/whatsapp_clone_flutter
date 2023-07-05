// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';

import 'package:whatsapp_clone_flutter/models/others_status.dart';

class ViewStoryScreen extends StatefulWidget {
  static const routeName = '/view-story';
  const ViewStoryScreen({
    Key? key,
    required this.othersStatus,
  }) : super(key: key);
  final OthersStatusModel othersStatus;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  final storyController = StoryController();
  List<StoryItem?> storyItems = [];

  @override
  void initState() {
    super.initState();
    storyItems = widget.othersStatus.statusList.map((story) {
      if (story.statusType == StatusEnum.image) {
        return StoryItem.pageImage(
          url: story.url,
          caption: story.caption,
          controller: storyController,
          shown: story.isSeen,
        );
      } else if (story.statusType == StatusEnum.video) {
        return StoryItem.pageVideo(
          story.url,
          controller: storyController,
          caption: story.caption,
          shown: story.isSeen,
        );
      }
      return StoryItem.text(
        shown: story.isSeen,
        title: story.title,
        backgroundColor: Color(story.backgroundColor),
        textStyle: TextStyle(
          fontSize: story.fontSize,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.othersStatus.profileUrl),
          ),
          title: Text(
            widget.othersStatus.name,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        toolbarOpacity: 0.6,
        backgroundColor: const Color(0x44000000),
      ),
      body: StoryView(
        inline: true,
        storyItems: storyItems,
        controller: storyController,
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
