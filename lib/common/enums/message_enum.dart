enum MessageEnum {
  text('text', 'text'),
  video('video', '📽 video'),
  gif('gif', '🖼 gif'),
  audio('audio', '🎵 audio'),
  image('image', '📷 image');

  final String type;
  final String message;
  const MessageEnum(this.type, this.message);
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
