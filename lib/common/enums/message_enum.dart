enum MessageEnum {
  text('text'),
  video('video'),
  gif('gif'),
  audio('audio'),
  image('image');

  final String type;
  const MessageEnum(this.type);
}

extension ConvertMessageType on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'text':
        return MessageEnum.text;
      case 'gif':
        return MessageEnum.gif;
      case 'video':
        return MessageEnum.video;
      case 'image':
        return MessageEnum.image;
      default:
        return MessageEnum.text;
    }
  }
}
