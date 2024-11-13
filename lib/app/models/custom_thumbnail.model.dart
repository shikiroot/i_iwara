
class CustomThumbnail {
  final String id;
  final String type;
  final String path;
  final String name;
  final String mime;
  final int? size;
  final int? width;
  final int? height;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomThumbnail({
    required this.id,
    required this.type,
    required this.path,
    required this.name,
    required this.mime,
    this.size,
    this.width,
    this.height,
    required this.createdAt,
    required this.updatedAt,
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

}