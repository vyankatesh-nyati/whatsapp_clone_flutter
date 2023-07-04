enum StatusEnum {
  text('text'),
  media('media');

  final String type;
  const StatusEnum(this.type);
}

extension ConvertStatusType on String {
  StatusEnum toStatusEnum() {
    switch (this) {
      case 'text':
        return StatusEnum.text;
      case 'media':
        return StatusEnum.media;
      default:
        return StatusEnum.text;
    }
  }
}
