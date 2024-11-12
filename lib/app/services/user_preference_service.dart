import 'package:get/get.dart';
import 'package:i_iwara/app/models/tag.model.dart';
import 'package:i_iwara/app/services/storage_service.dart';
import 'package:i_iwara/utils/logger_utils.dart';

class UserPreferenceService extends GetxService {
  late final StorageService storageService;
  final String _TAG = 'userPreferenceService';

  // 视频搜索历史
  final RxList<String> videoSearchHistory = <String>[].obs;

  // 视频搜索标签
  final RxList<Tag> videoSearchTags = <Tag>[].obs;

  // 用户喜欢的标签
  final List<String> userLikeTagIds = <String>[];

  // 用户喜欢的作者
  final List<String> userLikeUsernames = <String>[];

  // 搜索记录最大数量
  final RxInt maxSearchRecordCount = 20.obs;

  final String _videoSearchHistoryKey = 'videoSearchHistory';
  final String _videoSearchTagsKey = 'videoSearchTags';
  final String _userLikeTagIdsKey = 'userLikeTagIds';
  final String _userLikeUsernamesKey = 'userLikeUsernames';

  Future<UserPreferenceService> init() async {
    storageService = StorageService();
    _loadVideoSearchHistory();
    LogUtils.i('用户偏好服务初始化完成', _TAG);
    return this;
  }

  void _loadVideoSearchHistory() {
    // 用户喜欢的作者
    try {
      var likeUsernames = storageService.readData(_userLikeUsernamesKey);
      if (likeUsernames != null) {
        // 反序列化
        List<String> list = likeUsernames.split(',');
        userLikeUsernames.addAll(list);
      }
    } catch (e) {
      LogUtils.e('加载用户喜欢的作者失败', tag: _TAG, error: e);
      storageService.deleteData(_userLikeUsernamesKey);
    }

    // 用户喜欢的标签
    try {
      var likeTagIds = storageService.readData(_userLikeTagIdsKey);
      if (likeTagIds != null) {
        // 反序列化
        List<String> list = likeTagIds.split(',');
        userLikeTagIds.addAll(list);
      }
    } catch (e) {
      LogUtils.e('加载用户喜欢的标签失败', tag: _TAG, error: e);
      storageService.deleteData(_userLikeTagIdsKey);
    }

    // 视频搜索历史
    try {
      final String? history = storageService.readData(_videoSearchHistoryKey);
      if (history != null) {
        List<String> list = history.split(',');
        videoSearchHistory.addAll(list);
      }
    } catch (e) {
      LogUtils.e('加载视频搜索历史失败', tag: _TAG, error: e);
      storageService.deleteData('videoSearchHistory');
    }

    // 视频搜索标签
    try {
      final String? tags = storageService.readData(_videoSearchTagsKey);
      if (tags != null) {
        List<Tag> list = (tags as List).map((e) => Tag.fromJson(e)).toList();
        // 判断有没有喜欢的标签，重新赋值
        if (userLikeTagIds.isNotEmpty && list.isNotEmpty) {
          for (var tag in list) {
            if (userLikeTagIds.contains(tag.id)) {
              tag.favorite = true;
            }
          }
        }
        videoSearchTags.addAll(list);
      }
    } catch (e) {
      LogUtils.e('加载视频搜索标签失败', tag: _TAG, error: e);
      storageService.deleteData(_videoSearchHistoryKey);
    }
  }

  // 添加视频搜索历史
  void addVideoSearchHistory(String keyword) {
    if (videoSearchHistory.contains(keyword)) {
      videoSearchHistory.remove(keyword);
    }
    videoSearchHistory.insert(0, keyword);
    if (videoSearchHistory.length > maxSearchRecordCount.value) {
      videoSearchHistory.removeLast();
    }
    storageService.writeData(
        _videoSearchHistoryKey, videoSearchHistory.join(','));
  }

  // 删除视频搜索历史
  void removeVideoSearchHistory(String keyword) {
    videoSearchHistory.remove(keyword);
    storageService.writeData(
        _videoSearchHistoryKey, videoSearchHistory.join(','));
  }

  // 清空视频搜索历史
  void clearVideoSearchHistory() {
    videoSearchHistory.clear();
    storageService.deleteData(_videoSearchHistoryKey);
  }

  // 添加视频搜索标签
  void addVideoSearchTag(Tag tag) {
    if (videoSearchTags.contains(tag)) {
      videoSearchTags.remove(tag);
    }
    videoSearchTags.insert(0, tag);
    if (videoSearchTags.length > maxSearchRecordCount.value) {
      videoSearchTags.removeLast();
    }
    storageService.writeData(
        _videoSearchTagsKey, videoSearchTags.map((e) => e.toJson()).toList());
  }

  // 删除视频搜索标签
  void removeVideoSearchTag(Tag tag) {
    videoSearchTags.remove(tag);
    storageService.writeData(
        _videoSearchTagsKey, videoSearchTags.map((e) => e.toJson()).toList());
  }

  // 清空视频搜索标签
  void clearVideoSearchTags() {
    videoSearchTags.clear();
    storageService.deleteData(_videoSearchTagsKey);
  }

  // 添加用户喜欢的标签
  void addUserLikeTag(String tagId) {
    if (!userLikeTagIds.contains(tagId)) {
      userLikeTagIds.add(tagId);
      storageService.writeData(_userLikeTagIdsKey, userLikeTagIds.join(','));
      // 更新视频搜索标签
      for (var tag in videoSearchTags) {
        // TODO 可能不会触发UI更新
        if (tag.id == tagId) {
          tag.favorite = true;
        }
      }
      storageService.writeData(
          _videoSearchTagsKey, videoSearchTags.map((e) => e.toJson()).toList());
    }
  }

  // 删除用户喜欢的标签
  void removeUserLikeTag(String tagId) {
    if (userLikeTagIds.contains(tagId)) {
      userLikeTagIds.remove(tagId);
      storageService.writeData(_userLikeTagIdsKey, userLikeTagIds.join(','));
      // 更新视频搜索标签
      for (var tag in videoSearchTags) {
        // TODO 可能不会触发UI更新
        if (tag.id == tagId) {
          tag.favorite = false;
        }
      }
      storageService.writeData(
          _videoSearchTagsKey, videoSearchTags.map((e) => e.toJson()).toList());
    }
  }

  // 添加用户喜欢的作者
  void addUserLikeUsername(String username) {
    if (!userLikeUsernames.contains(username)) {
      userLikeUsernames.add(username);
      storageService.writeData(_userLikeUsernamesKey, userLikeUsernames.join(','));
    }
  }

  // 删除用户喜欢的作者
  void removeUserLikeUsername(String username) {
    if (userLikeUsernames.contains(username)) {
      userLikeUsernames.remove(username);
      storageService.writeData(_userLikeUsernamesKey, userLikeUsernames.join(','));
    }
  }

  // 清空用户喜欢的作者
  void clearUserLikeUsernames() {
    userLikeUsernames.clear();
    storageService.deleteData(_userLikeUsernamesKey);
  }

}
