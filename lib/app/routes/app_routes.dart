
// 定义所有路由路径
abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const POPULAR_VIDEOS =
      ROOT; // /home/popular_videos
  static const GALLERY = _Paths.HOME + _Paths.GALLERY;
  static const SUBSCRIPTIONS = _Paths.HOME + _Paths.SUBSCRIPTIONS;
  static const VIDEO_DETAIL = _Paths.HOME + _Paths.VIDEO_DETAIL;
  static String AUTHOR_PROFILE(String userName) => _Paths.HOME + _Paths.AUTHOR_PROFILE.replaceAll(':userName', userName);
  static String GALLERY_DETAIL(String galleryId) => _Paths.HOME + _Paths.GALLERY_DETAIL.replaceAll(':galleryId', galleryId);

  static const LOGIN = _Paths.LOGIN;
  static const SETTINGS_PAGE = _Paths.SETTINGS_PAGE;
  static const PLAYER_SETTINGS_PAGE = _Paths.PLAYER_SETTINGS_PAGE;
  static const PROXY_SETTINGS_PAGE = _Paths.PROXY_SETTINGS_PAGE;
  static const THEME_SETTINGS_PAGE = _Paths.THEME_SETTINGS_PAGE;
  static const NOT_FOUND = _Paths.NOT_FOUND;
  static const SIGN_IN = _Paths.SIGN_IN;

  static const ROOT = _Paths.ROOT;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const LOGIN = '/login';
  static const VIDEO_DETAIL = '/video_detail';
  static const SETTINGS_PAGE = '/settings_page';
  static const PLAYER_SETTINGS_PAGE = '/player_settings_page';
  static const PROXY_SETTINGS_PAGE = '/proxy_settings_page';
  static const THEME_SETTINGS_PAGE = '/theme_settings_page';
  static const AUTHOR_PROFILE = '/author_profile/:userName';
  static const NOT_FOUND = '/not_found';

  static const GALLERY = '/gallery';
  static const GALLERY_DETAIL = '/gallery_detail/:galleryId';
  static const SUBSCRIPTIONS = '/subscriptions';
  static const SIGN_IN = '/sign_in';

  static const  ROOT = '/';
}
