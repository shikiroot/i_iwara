class Tag {
  final String id;
  final String type;

  Tag({required this.id, required this.type});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      type: json['type'],
    );
  }
}