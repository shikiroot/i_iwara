class Tag {
  final String id;
  final String type;
  final bool sensitive;
  bool favorite;

  Tag(
      {required this.id,
      required this.type,
      this.sensitive = false,
      this.favorite = false});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      type: json['type'],
      sensitive: json['sensitive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'sensitive': sensitive,
      'favorite': favorite,
    };
  }
}
