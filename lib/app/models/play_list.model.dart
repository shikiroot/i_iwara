import 'package:i_iwara/common/constants.dart';

class PlaylistModel {
  String id;
  String title;
  int numVideos;
  String thumbnailUrl; // 封面图，截至2024-11-29，目前iwara并没有真正的为playlist设置封面图，如果后续iwara添加了，可以在这里添加

  PlaylistModel({
    required this.id,
    required this.title,
    required this.numVideos,
    required this.thumbnailUrl,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json['id'],
      title: json['title'],
      numVideos: json['numVideos'],
      thumbnailUrl: json['thumbnailUrl'] ?? CommonConstants.defaultPlaylistThumbnailUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'numVideos': numVideos,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
