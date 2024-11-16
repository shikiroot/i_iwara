enum MediaRating {
  ALL('', '全部的'),
  GENERAL('general', '大众的'),
  ECCHI('ecchi', 'R18'),
  ;

  final String value;
  final String label;

  const MediaRating(this.value, this.label);
}

enum MediaType {
  VIDEO,
  IMAGE;
}
