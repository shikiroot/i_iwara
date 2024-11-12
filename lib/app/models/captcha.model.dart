// models/captcha.model.dart
class Captcha {
  final String id;
  final String data; // Base64 image data URI

  Captcha({required this.id, required this.data});

  factory Captcha.fromJson(Map<String, dynamic> json) {
    return Captcha(
      id: json['id'],
      data: json['data'],
    );
  }
}
