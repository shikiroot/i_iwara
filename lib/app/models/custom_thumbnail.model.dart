class CustomThumbnail {
  final String id;
  final String type;
  final String path;
  final String name;
  final String mime;
  final int? size;
  final int? width;
  final int? height;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomThumbnail({
    required this.id,
    required this.type,
    required this.path,
    required this.name,
    required this.mime,
    this.size,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomThumbnail.fromJson(Map<String, dynamic> json) {
    return CustomThumbnail(
      id: json['id'],
      type: json['type'],
      path: json['path'],
      name: json['name'],
      mime: json['mime'],
      size: json['size'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'path': path,
      'name': name,
      'mime': mime,
      'size': size,
      'width': width,
      'height': height,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
