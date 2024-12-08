import 'package:flutter/material.dart';
import 'package:i_iwara/app/models/sort.model.dart';

class CommonConstants {
  CommonConstants._internal();

  // 网站基础URL
  static const String iwaraBaseUrl = 'https://www.iwara.tv';

  // api基础URL
  static const String iwaraApiBaseUrl = 'https://api.iwara.tv';

  // 图片资源基础URL
  static const String iwaraImageBaseUrl = 'https://i.iwara.tv';

  // 默认用户头像URL
  static const String defaultAvatarUrl =
      '$iwaraBaseUrl/images/default-avatar.jpg';

  // 默认用户背景URL
  static const String defaultProfileHeaderUrl =
      '$iwaraBaseUrl/images/default-background.jpg';

  static const List<Sort> mediaSorts = [
    Sort(id: SortId.trending, label: '趋势', icon: Icon(Icons.trending_up)),
    Sort(id: SortId.date, label: '最新', icon: Icon(Icons.new_releases)),
    Sort(id: SortId.popularity, label: '受欢迎的', icon: Icon(Icons.star)),
    Sort(id: SortId.likes, label: '点赞数', icon: Icon(Icons.thumb_up)),
    Sort(id: SortId.views, label: '观看次数', icon: Icon(Icons.remove_red_eye)),
  ];

  static String defaultThumbnailUrl =
      '$iwaraBaseUrl/images/default-thumbnail.jpg';

  static bool enableR18 = true;

  static String? applicationName = 'i_iwara';

  static String defaultPlaylistThumbnailUrl =
      '$iwaraBaseUrl/images/default-thumbnail.jpg';

  // 获取用户背景URL
  static userProfileHeaderUrl(String? headerId) {
    if (headerId == null) {
      return defaultProfileHeaderUrl;
    }
    return '$iwaraImageBaseUrl/image/profileHeader/$headerId/$headerId.jpg';
  }
}

class KeyConstants {
  // Auth Token
  static const String authToken = 'auth_token';

  // Access Token
  static const String accessToken = 'access_token';
}

class ApiConstants {
  // 视频列表
  static String videos() => '/videos';

  // 图片
  static String images() => '/images';

  // 作者详情
  static String profilePrefix() => '/profile';

  // 图库详情
  static String galleryDetail() => '/image';

  // 用户详情
  static String userProfile(String userName) => '/profile/$userName';

  // 用户粉丝
  static String userFollowers(String userId) => '/user/$userId/followers';

  // 用户关注
  static String userFollowing(String userId) => '/user/$userId/following';

  // 朋友申请状态
  static String userRelationshipStatus(String userId) =>
      '/user/$userId/friends/status';

  // 加或取消朋友
  static String userAddOrRemoveFriend(String userId) => '/user/$userId/friends';

  // 关注或取消关注
  static String userFollowOrUnfollow(String userId) =>
      '/user/$userId/followers';

  // 视频评论
  static String videoComments(String videoId) => '/video/$videoId/comments';
  static const String rawVideoComments = '/video/{id}/comments';

  // 用户评论
  static String userComments(String userId) => '/profile/$userId/comments';
  static const String rawProfileComments = '/profile/{id}/comments';

  // 图片评论
  static const String rawImageComments = '/image/{id}/comments';

  // 标签
  static String tags() => '/tags';

  // 图片详情
  static String imageDetail(String imageModelId) => '/image/$imageModelId';

  // 相关视频
  static String relatedVideos(String id) => '/video/$id/related';

  // 相关图片
  static String relatedImages(String mediaId) => '/image/$mediaId/related';

  // 视频点赞
  static String videoLikes(String videoId) => '/video/$videoId/likes';

  // 图片点赞
  static String imageLikes(String imageId) => '/image/$imageId/likes';

  // 轻量视频
  static String lightVideo(String videoId) => '/light/video/$videoId';

  // 轻量图库
  static String lightForum(String forumId) => '/light/forum/$forumId';

  // 轻量图片
  static String lightImage(String imageId) => '/light/image/$imageId';

  // 轻量用户
  static String lightProfile(String userId) => '/light/profile/$userId';

  // 轻量播放列表
  static String lightPlaylist(String playlistId) => '/light/playlist/$playlistId';

  // 搜索
  static String search() => '/search';

  // 最爱视频
  static String favoriteVideos() => '/favorites/videos';

  // 最爱图库
  static String favoriteImages() => '/favorites/images';

  // 设为最爱图片
  static String likeImage(String mediaId) => '/image/$mediaId/like';

  // 设为最爱视频
  static String likeVideo(String mediaId) => '/video/$mediaId/like';

  // 用户朋友
  static String userFriends(String userId) => '/user/$userId/friends';

  // 用户请求
  static String userFriendsRequests(String userId) => '/user/$userId/friends/requests';
}

// 视频接口的排序方式
enum SortId {
  trending,
  date,
  popularity,
  likes,
  views;
}
