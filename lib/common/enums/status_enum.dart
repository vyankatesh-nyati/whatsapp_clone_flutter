enum StatusEnum {
  text('text'),
  video('video'),
  image('image');

  final String type;
  const StatusEnum(this.type);
}

extension ConvertStatusType on String {
  StatusEnum toStatusEnum() {
    switch (this) {
      case 'text':
        return StatusEnum.text;
      case 'video':
        return StatusEnum.video;
      case 'image':
        return StatusEnum.image;
      default:
        return StatusEnum.text;
    }
  }
}
