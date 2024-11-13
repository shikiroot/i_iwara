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
  final RxList<Tag> videoSearchTagHistory = <Tag>[].obs;

  // 用户喜欢的作者
  final RxSet<String> userLikeUsernames = <String>{}.obs;

  final maxSearchRecordCount = 20.obs;

  final String _videoSearchHistoryKey = 'videoSearchHistory';
  final String _videoSearchTagHistoryKey = 'videoSearchTagHistory';
  final String _userLikeUsernamesKey = 'userLikeUsernames';

  Future<UserPreferenceService> init() async {
    storageService = StorageService();
    _loadVideoSearchHistory();
    LogUtils.i('用户偏好服务初始化完成', _TAG);
    return this;
  }

  bool isUserSearchTagObject(Tag? tag) {
    if (tag == null) {
      return false;
    }
    String id = tag.id;
    return isUserSearchTagId(id);
  }

  bool isUserSearchTagId(String? tagId) {
    if (tagId == null) {
      return false;
    }
    return videoSearchTagHistory.any((element) => element.id == tagId);
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
      final String? tags = storageService.readData(_videoSearchTagHistoryKey);
      if (tags != null) {
        List<Tag> list = (tags as List).map((e) => Tag.fromJson(e)).toList();
        videoSearchTagHistory.addAll(list);
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
    // 如果已经存在则删除
    String id = tag.id;
    if (videoSearchTagHistory.any((element) => element.id == id)) {
      videoSearchTagHistory.removeWhere((element) => element.id == id);
    }
    // 加载到第一个
    videoSearchTagHistory.insert(0, tag);
    storageService.writeData(_videoSearchTagHistoryKey,
        videoSearchTagHistory.map((e) => e.toJson()).toList());
  }

  // 删除视频搜索标签
  void removeVideoSearchTag(Tag tag) {
    // 通过Id删除
    String id = tag.id;
    videoSearchTagHistory.removeWhere((element) => element.id == id);
    storageService.writeData(_videoSearchTagHistoryKey,
        videoSearchTagHistory.map((e) => e.toJson()).toList());
  }

  void removeVideoSearchTagById(String id) {
    videoSearchTagHistory.removeWhere((element) => element.id == id);
    storageService.writeData(_videoSearchTagHistoryKey,
        videoSearchTagHistory.map((e) => e.toJson()).toList());
  }

  // 清空视频搜索标签
  void clearVideoSearchTags() {
    videoSearchTagHistory.clear();
    storageService.deleteData(_videoSearchTagHistoryKey);
  }

  // 添加用户喜欢的作者
  void addUserLikeUsername(String username) {
    if (!userLikeUsernames.contains(username)) {
      userLikeUsernames.add(username);
      storageService.writeData(
          _userLikeUsernamesKey, userLikeUsernames.join(','));
    }
  }

  // 删除用户喜欢的作者
  void removeUserLikeUsername(String username) {
    if (userLikeUsernames.contains(username)) {
      userLikeUsernames.remove(username);
      storageService.writeData(
          _userLikeUsernamesKey, userLikeUsernames.join(','));
    }
  }

  // 清空用户喜欢的作者
  void clearUserLikeUsernames() {
    userLikeUsernames.clear();
    storageService.deleteData(_userLikeUsernamesKey);
  }
}
