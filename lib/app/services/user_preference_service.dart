import 'dart:convert';

import 'package:get/get.dart';
import 'package:i_iwara/app/models/tag.model.dart';
import 'package:i_iwara/app/repositories/commons_repository.dart';
import 'package:i_iwara/utils/logger_utils.dart';

class UserPreferenceService extends GetxService {
  final String _TAG = 'UserPreferenceService';

  // 视频搜索历史
  final RxList<String> videoSearchHistory = <String>[].obs;

  // 视频搜索标签
  final RxList<Tag> videoSearchTagHistory = <Tag>[].obs;

  // 用户喜欢的作者
  final RxSet<String> userLikeUsernames = <String>{}.obs;

  final int maxSearchRecordCount = 20;

  final String _videoSearchHistoryKey = 'videoSearchHistory';
  final String _videoSearchTagHistoryKey = 'videoSearchTagHistory';
  final String _userLikeUsernamesKey = 'userLikeUsernames';

  Future<UserPreferenceService> init() async {
    await _loadUserPreferences();
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

  Future<void> _loadUserPreferences() async {
    await _loadUserLikeUsernames();
    await _loadVideoSearchHistory();
    await _loadVideoSearchTagHistory();
  }

  // 加载用户喜欢的作者
  Future<void> _loadUserLikeUsernames() async {
    try {
      final String? data = await CommonsRepository.instance.getData(_userLikeUsernamesKey);
      if (data != null && data.isNotEmpty) {
        List<dynamic> list = jsonDecode(data);
        userLikeUsernames.addAll(list.cast<String>());
      }
    } catch (e) {
      LogUtils.e('加载用户喜欢的作者失败', tag: _TAG, error: e);
      await CommonsRepository.instance.deleteData(_userLikeUsernamesKey);
    }
  }

  // 加载视频搜索历史
  Future<void> _loadVideoSearchHistory() async {
    try {
      final String? data = await CommonsRepository.instance.getData(_videoSearchHistoryKey);
      if (data != null && data.isNotEmpty) {
        List<dynamic> list = jsonDecode(data);
        videoSearchHistory.addAll(list.cast<String>());
      }
    } catch (e) {
      LogUtils.e('加载视频搜索历史失败', tag: _TAG, error: e);
      await CommonsRepository.instance.deleteData(_videoSearchHistoryKey);
    }
  }

  // 加载视频搜索标签
  Future<void> _loadVideoSearchTagHistory() async {
    try {
      final String? data = await CommonsRepository.instance.getData(_videoSearchTagHistoryKey);
      if (data != null && data.isNotEmpty) {
        List<dynamic> list = jsonDecode(data);
        List<Tag> tags = list.map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList();
        videoSearchTagHistory.addAll(tags);
      }
    } catch (e) {
      LogUtils.e('加载视频搜索标签失败', tag: _TAG, error: e);
      await CommonsRepository.instance.deleteData(_videoSearchTagHistoryKey);
    }
  }

  // 添加视频搜索历史
  Future<void> addVideoSearchHistory(String keyword) async {
    if (videoSearchHistory.contains(keyword)) {
      videoSearchHistory.remove(keyword);
    }
    videoSearchHistory.insert(0, keyword);
    if (videoSearchHistory.length > maxSearchRecordCount) {
      videoSearchHistory.removeLast();
    }
    try {
      await CommonsRepository.instance.setData(
        _videoSearchHistoryKey,
        jsonEncode(videoSearchHistory.toList()),
      );
    } catch (e) {
      LogUtils.e('保存视频搜索历史失败', tag: _TAG, error: e);
    }
  }

  // 删除视频搜索历史
  Future<void> removeVideoSearchHistory(String keyword) async {
    videoSearchHistory.remove(keyword);
    try {
      await CommonsRepository.instance.setData(
        _videoSearchHistoryKey,
        jsonEncode(videoSearchHistory.toList()),
      );
    } catch (e) {
      LogUtils.e('删除视频搜索历史失败', tag: _TAG, error: e);
    }
  }

  // 清空视频搜索历史
  Future<void> clearVideoSearchHistory() async {
    videoSearchHistory.clear();
    try {
      await CommonsRepository.instance.deleteData(_videoSearchHistoryKey);
    } catch (e) {
      LogUtils.e('清空视频搜索历史失败', tag: _TAG, error: e);
    }
  }

  // 添加视频搜索标签
  Future<void> addVideoSearchTag(Tag tag) async {
    String id = tag.id;
    if (videoSearchTagHistory.any((element) => element.id == id)) {
      videoSearchTagHistory.removeWhere((element) => element.id == id);
    }
    videoSearchTagHistory.insert(0, tag);
    try {
      List<Map<String, dynamic>> tagList = videoSearchTagHistory.map((e) => e.toJson()).toList();
      await CommonsRepository.instance.setData(
        _videoSearchTagHistoryKey,
        jsonEncode(tagList),
      );
    } catch (e) {
      LogUtils.e('保存视频搜索标签失败', tag: _TAG, error: e);
    }
  }

  // 删除视频搜索标签
  Future<void> removeVideoSearchTag(Tag tag) async {
    String id = tag.id;
    videoSearchTagHistory.removeWhere((element) => element.id == id);
    await _saveVideoSearchTagHistory();
  }

  // 通过ID删除视频搜索标签
  Future<void> removeVideoSearchTagById(String id) async {
    videoSearchTagHistory.removeWhere((element) => element.id == id);
    await _saveVideoSearchTagHistory();
  }

  // 保存视频搜索标签到数据库
  Future<void> _saveVideoSearchTagHistory() async {
    try {
      List<Map<String, dynamic>> tagList = videoSearchTagHistory.map((e) => e.toJson()).toList();
      await CommonsRepository.instance.setData(
        _videoSearchTagHistoryKey,
        jsonEncode(tagList),
      );
    } catch (e) {
      LogUtils.e('保存视频搜索标签失败', tag: _TAG, error: e);
    }
  }

  // 清空视频搜索标签
  Future<void> clearVideoSearchTags() async {
    videoSearchTagHistory.clear();
    try {
      await CommonsRepository.instance.deleteData(_videoSearchTagHistoryKey);
    } catch (e) {
      LogUtils.e('清空视频搜索标签失败', tag: _TAG, error: e);
    }
  }

  // 添加用户喜欢的作者
  Future<void> addUserLikeUsername(String username) async {
    if (!userLikeUsernames.contains(username)) {
      userLikeUsernames.add(username);
      try {
        await CommonsRepository.instance.setData(
          _userLikeUsernamesKey,
          jsonEncode(userLikeUsernames.toList()),
        );
      } catch (e) {
        LogUtils.e('保存用户喜欢的作者失败', tag: _TAG, error: e);
      }
    }
  }

  // 删除用户喜欢的作者
  Future<void> removeUserLikeUsername(String username) async {
    if (userLikeUsernames.contains(username)) {
      userLikeUsernames.remove(username);
      try {
        await CommonsRepository.instance.setData(
          _userLikeUsernamesKey,
          jsonEncode(userLikeUsernames.toList()),
        );
      } catch (e) {
        LogUtils.e('删除用户喜欢的作者失败', tag: _TAG, error: e);
      }
    }
  }

  // 清空用户喜欢的作者
  Future<void> clearUserLikeUsernames() async {
    userLikeUsernames.clear();
    try {
      await CommonsRepository.instance.deleteData(_userLikeUsernamesKey);
    } catch (e) {
      LogUtils.e('清空用户喜欢的作者失败', tag: _TAG, error: e);
    }
  }
}
