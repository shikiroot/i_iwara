
import 'package:i_iwara/app/models/user.model.dart';

class Comment {
  final String id;
  final String? body;
  final int? numReplies;
  final dynamic parent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final String? videoId;
  final String? profileId;

  Comment({
    required this.id,
    this.body,
    this.numReplies,
    this.parent,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.videoId,
    this.profileId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      body: json['body'] as String?,
      numReplies: json['numReplies'] as int?,
      parent: json['parent'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      videoId: json['videoId'] as String?,
      profileId: json['userId'] as String?,
    );
  }
}