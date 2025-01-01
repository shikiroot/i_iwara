
import 'package:i_iwara/app/models/user.model.dart';

class PostModel {
  final String id;
  final String title;
  final String body;
  final int? numViews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;


  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.numViews,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      numViews: json['numViews'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'numViews': numViews,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}