import 'package:i_iwara/app/models/user.model.dart';

class Comment {
  final String id;
  final String body;
  final int numReplies;
  final Comment? parent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final String? videoId;
  final String? profileId;
  final bool approved;

  Comment({
    required this.id,
    this.body = '',
    this.numReplies = 0,
    this.parent,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.videoId,
    this.profileId,
    this.approved = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      body: json['body'] as String? ?? '',
      numReplies: json['numReplies'] as int? ?? 0,
      parent: json['parent'] != null
          ? Comment.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      videoId: json['videoId'] as String?,
      profileId: json['profileId'] as String?,
      approved: json['approved'] as bool? ?? false,
    );
  }

  toJson() {
    return {
      'id': id,
      'body': body,
      'numReplies': numReplies,
      'parent': parent?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'user': user?.toJson(),
      'videoId': videoId,
      'profileId': profileId,
      'approved': approved,
    };
  }
}
