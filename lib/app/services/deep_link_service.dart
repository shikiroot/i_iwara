import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';

class DeepLinkService extends GetxService {
  final _appLinks = AppLinks();
  
  Future<void> init() async {
    // 监听所有链接事件
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri);
      }
    });
    
    // 检查初始链接（从外部打开应用时）
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _handleLink(uri);
    }
  }

  void _handleLink(Uri uri) {
    // 处理不同类型的链接
    final pathSegments = uri.pathSegments;
    
    if (pathSegments.isEmpty) return;

    switch (pathSegments[0]) {
      case 'video':
        if (pathSegments.length > 1) {
          final videoId = pathSegments[1];
          NaviService.navigateToVideoDetailPage(videoId);
        }
        break;
        
      case 'profile':
        if (pathSegments.length > 1) {
          final userName = pathSegments[1];
          NaviService.navigateToAuthorProfilePage(userName);
        }
        break;
        
      case 'playlist':
        if (pathSegments.length > 1) {
          final playlistId = pathSegments[1];
          NaviService.navigateToPlayListDetail(playlistId, isMine: false);
        }
        break;
        
      case 'image':
        if (pathSegments.length > 1) {
          final imageId = pathSegments[1];
          NaviService.navigateToGalleryDetailPage(imageId);
        }
        break;
    }
  }
}
