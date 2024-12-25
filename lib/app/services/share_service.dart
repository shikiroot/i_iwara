import 'package:get/get.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  /// 分享播放列表详情
  static Future<void> sharePlayListDetail(
      String playlistId, String? playListTitle) async {
    final String url = '${CommonConstants.iwaraBaseUrl}/playlist/$playlistId';
    String title = t.share.sharePlayList;
    String text = '${t.share.wowDidYouSeeThis}\n'
        '${t.share.nameIs}: $playListTitle\n'
        '${t.share.clickLinkToView}: $url\n\n'
        '${t.share.iReallyLikeThis}';

    try {
      await Share.share(
        text,
        subject: title,
      );
    } catch (e) {
      LogUtils.e('分享播放列表详情失败', error: e, tag: 'ShareService');
      Get.snackbar(t.share.share, t.errors.failedToOperate);
    }
  }

  /// 分享播放列表
  static sharePlayList(String userId) {
    Get.snackbar(t.share.share, t.errors.failedToOperate);
  }
}
