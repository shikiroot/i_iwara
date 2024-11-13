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

  static String defaultThumbnailUrl = '$iwaraBaseUrl/images/default-thumbnail.jpg';

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

  // 用户评论
  static String userComments(String userId) => '/profile/$userId/comments';
}

// 视频接口的排序方式
enum SortId {
  trending, date, popularity, likes, views;
}