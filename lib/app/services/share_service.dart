import 'package:get/get.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  /// 分享播放列表详情
  static Future<void> sharePlayListDetail(
      String playlistId, String? playListTitle) async {
    final String url = '${CommonConstants.iwaraBaseUrl}/playlist/$playlistId';
    const String title = '分享播放列表';
    final String text = '哇哦，你看过这个吗？\n'
        '名字叫做：$playListTitle\n'
        '点击链接查看：$url\n\n'
        '我真的是太喜欢这个了，你也来看看吧！';

    try {
      await Share.share(
        text,
        subject: title,
      );
    } catch (e) {
      LogUtils.e('分享播放列表详情失败', error: e, tag: 'ShareService');
      Get.snackbar('分享失败', '分享失败，请稍后再试');
    }
  }

  /// 分享播放列表
  static sharePlayList(String userId) {
    Get.snackbar('分享', '该功能尚未实现');
  }
}
