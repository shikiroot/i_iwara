///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhCn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonZhCn common = _TranslationsCommonZhCn._(_root);
	@override late final _TranslationsAuthZhCn auth = _TranslationsAuthZhCn._(_root);
	@override late final _TranslationsErrorsZhCn errors = _TranslationsErrorsZhCn._(_root);
	@override late final _TranslationsFriendsZhCn friends = _TranslationsFriendsZhCn._(_root);
	@override late final _TranslationsAuthorProfileZhCn authorProfile = _TranslationsAuthorProfileZhCn._(_root);
	@override late final _TranslationsFavoritesZhCn favorites = _TranslationsFavoritesZhCn._(_root);
	@override late final _TranslationsGalleryDetailZhCn galleryDetail = _TranslationsGalleryDetailZhCn._(_root);
	@override late final _TranslationsPlayListZhCn playList = _TranslationsPlayListZhCn._(_root);
}

// Path: common
class _TranslationsCommonZhCn implements TranslationsCommonEn {
	_TranslationsCommonZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Love Iwara';
	@override String get ok => '确定';
	@override String get cancel => '取消';
	@override String get save => '保存';
	@override String get delete => '删除';
	@override String get loading => '加载中...';
	@override String get privacyHint => '隐私内容，不与展示';
	@override String get latest => '最新';
	@override String get likesCount => '点赞数';
	@override String get viewsCount => '观看次数';
	@override String get popular => '受欢迎的';
	@override String get trending => '趋势';
	@override String get commentList => '评论列表';
	@override String get sendComment => '发表评论';
	@override String get send => '发表';
	@override String get retry => '重试';
	@override String get premium => '高级会员';
	@override String get follower => '粉丝';
	@override String get friend => '朋友';
	@override String get video => '视频';
	@override String get following => '关注';
	@override String get cancelFriendRequest => '取消申请';
	@override String get addFriend => '添加朋友';
	@override String get removeFriend => '解除朋友';
	@override String get followed => '已关注';
	@override String get follow => '关注';
	@override String get specialFollow => '特别关注';
	@override String get specialFollowed => '已特别关注';
	@override String get gallery => '图库';
	@override String get playlist => '播放列表';
	@override String get commentPostedSuccessfully => '评论发表成功';
	@override String get commentPostedFailed => '评论发表失败';
	@override String get success => '成功';
	@override String get commentDeletedSuccessfully => '评论已删除';
	@override String get commentUpdatedSuccessfully => '评论已更新';
	@override String totalComments({required Object count}) => '评论 ${count} 条';
	@override String get writeYourCommentHere => '写下你的评论...';
	@override String get tmpNoReplies => '暂无回复';
	@override String get loadMore => '加载更多';
	@override String get noMoreDatas => '没有更多数据了';
	@override String get selectTranslationLanguage => '选择翻译语言';
	@override String get translate => '翻译';
	@override String get translateFailedPleaseTryAgainLater => '翻译失败，请稍后重试';
	@override String get translationResult => '翻译结果';
	@override String get justNow => '刚刚';
	@override String minutesAgo({required Object num}) => '${num}分钟前';
	@override String hoursAgo({required Object num}) => '${num}小时前';
	@override String daysAgo({required Object num}) => '${num}天前';
	@override String editedAt({required Object num}) => '编辑于${num}前';
	@override String get editComment => '编辑评论';
	@override String get commentUpdated => '评论已更新';
	@override String get replyComment => '回复评论';
	@override String get reply => '回复';
	@override String get edit => '编辑';
	@override String get unknownUser => '未知用户';
	@override String get me => '我';
	@override String get author => '作者';
	@override String get admin => '管理员';
	@override String viewReplies({required Object num}) => '查看回复 (${num})';
	@override String get hideReplies => '隐藏回复';
	@override String get confirmDelete => '确认删除';
	@override String get areYouSureYouWantToDeleteThisItem => '确定要删除这条记录吗？';
	@override String get tmpNoComments => '暂无评论';
	@override String get refresh => '刷新';
	@override String get back => '返回';
	@override String get tips => '提示';
	@override String get linkIsEmpty => '链接地址为空';
	@override String get linkCopiedToClipboard => '链接地址已复制到剪贴板';
	@override String get imageCopiedToClipboard => '图片已复制到剪贴板';
	@override String get copyImageFailed => '复制图片失败';
	@override String get mobileSaveImageIsUnderDevelopment => '移动端的保存图片功能还在开发中';
	@override String get imageSavedTo => '图片已保存到';
	@override String get saveImageFailed => '保存图片失败';
	@override String get close => '关闭';
	@override String get more => '更多';
	@override String get moreFeaturesToBeDeveloped => '更多功能待开发';
	@override String get all => '全部';
	@override String selectedRecords({required Object num}) => '已选择 ${num} 条记录';
	@override String get cancelSelectAll => '取消全选';
	@override String get selectAll => '全选';
	@override String get exitEditMode => '退出编辑模式';
	@override String areYouSureYouWantToDeleteSelectedItems({required Object num}) => '确定要删除选中的 ${num} 条记录吗？';
	@override String get searchHistoryRecords => '搜索历史记录...';
	@override String get settings => '设置';
	@override String get subscriptions => '订阅';
	@override String videoCount({required Object num}) => '${num} 个视频';
	@override String get share => '分享';
	@override String get areYouSureYouWantToShareThisPlaylist => '要分享这个播放列表吗?';
	@override String get editTitle => '编辑标题';
	@override String get editMode => '编辑模式';
	@override String get pleaseEnterNewTitle => '请输入新标题';
	@override String get createPlayList => '创建播放列表';
	@override String get create => '创建';
}

// Path: auth
class _TranslationsAuthZhCn implements TranslationsAuthEn {
	_TranslationsAuthZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get logout => '退出登录';
	@override String get email => '邮箱';
	@override String get password => '密码';
	@override String get loginOrRegister => '登录 / 注册';
	@override String get register => '注册';
	@override String get pleaseEnterEmail => '请输入邮箱';
	@override String get pleaseEnterPassword => '请输入密码';
	@override String get passwordMustBeAtLeast6Characters => '密码至少需要6位';
	@override String get pleaseEnterCaptcha => '请输入验证码';
	@override String get captcha => '验证码';
	@override String get refreshCaptcha => '刷新验证码';
	@override String get captchaNotLoaded => '无法加载验证码';
	@override String get loginSuccess => '登录成功';
	@override String get emailVerificationSent => '邮箱指令已发送';
}

// Path: errors
class _TranslationsErrorsZhCn implements TranslationsErrorsEn {
	_TranslationsErrorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get error => '错误';
	@override String get required => '此项必填';
	@override String get invalidEmail => '邮箱格式不正确';
	@override String get networkError => '网络错误，请重试';
	@override String get errorWhileFetching => '获取信息失败';
	@override String get commentCanNotBeEmpty => '评论内容不能为空';
	@override String get errorWhileFetchingReplies => '获取回复时出错，请检查网络连接';
	@override String get canNotFindCommentController => '无法找到评论控制器';
	@override String get errorWhileLoadingGallery => '在加载图库时出现了错误';
	@override String get howCouldThereBeNoDataItCantBePossible => '啊？怎么会没有数据呢？出错了吧 :<';
	@override String unsupportedImageFormat({required Object str}) => '不支持的图片格式: ${str}';
	@override String get invalidGalleryId => '无效的图库ID';
}

// Path: friends
class _TranslationsFriendsZhCn implements TranslationsFriendsEn {
	_TranslationsFriendsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFriend => '点击恢复好友';
	@override String get friendsList => '好友列表';
	@override String get friendRequests => '好友请求';
	@override String get friendRequestsList => '好友请求列表';
}

// Path: authorProfile
class _TranslationsAuthorProfileZhCn implements TranslationsAuthorProfileEn {
	_TranslationsAuthorProfileZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get noMoreDatas => '没有更多数据了';
	@override String get userProfile => '用户资料';
}

// Path: favorites
class _TranslationsFavoritesZhCn implements TranslationsFavoritesEn {
	_TranslationsFavoritesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFavorite => '点击恢复最爱';
	@override String get myFavorites => '我的最爱';
}

// Path: galleryDetail
class _TranslationsGalleryDetailZhCn implements TranslationsGalleryDetailEn {
	_TranslationsGalleryDetailZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get copyLink => '复制链接地址';
	@override String get copyImage => '复制图片';
	@override String get saveAs => '另存为';
	@override String get saveToAlbum => '保存到相册';
	@override String get publishedAt => '发布时间';
	@override String get viewsCount => '观看次数';
	@override String get imageLibraryFunctionIntroduction => '图库功能介绍';
	@override String get rightClickToSaveSingleImage => '右键保存单张图片';
	@override String get batchSave => '批量保存';
	@override String get keyboardLeftAndRightToSwitch => '键盘的左右控制切换';
	@override String get keyboardUpAndDownToZoom => '键盘的上下控制缩放';
	@override String get mouseWheelToSwitch => '鼠标的滚轮滑动控制切换';
	@override String get ctrlAndMouseWheelToZoom => 'CTRL + 鼠标滚轮控制缩放';
	@override String get moreFeaturesToBeDiscovered => '更多功能待发现...';
	@override String get authorOtherGalleries => '作者的其他图库';
	@override String get relatedGalleries => '相关图库';
}

// Path: playList
class _TranslationsPlayListZhCn implements TranslationsPlayListEn {
	_TranslationsPlayListZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get myPlayList => '我的播放列表';
	@override String get friendlyTips => '友情提示';
	@override String get dearUser => '亲爱的用户';
	@override String get iwaraPlayListSystemIsNotPerfectYet => 'iwara的播放列表系统目前还不太完善';
	@override String get notSupportSetCover => '不支持设置封面';
	@override String get notSupportDeleteList => '不能删除列表';
	@override String get notSupportSetPrivate => '无法设为私密';
	@override String get yesCreateListWillAlwaysExistAndVisibleToEveryone => '没错...创建的列表会一直存在且对所有人可见';
	@override String get smallSuggestion => '小建议';
	@override String get useLikeToCollectContent => '如果您比较注重隐私，建议使用"点赞"功能来收藏内容';
	@override String get welcomeToDiscussOnGitHub => '如果你有其他的建议或想法，欢迎来 GitHub 讨论!';
	@override String get iUnderstand => '明白了';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.appName': return 'Love Iwara';
			case 'common.ok': return '确定';
			case 'common.cancel': return '取消';
			case 'common.save': return '保存';
			case 'common.delete': return '删除';
			case 'common.loading': return '加载中...';
			case 'common.privacyHint': return '隐私内容，不与展示';
			case 'common.latest': return '最新';
			case 'common.likesCount': return '点赞数';
			case 'common.viewsCount': return '观看次数';
			case 'common.popular': return '受欢迎的';
			case 'common.trending': return '趋势';
			case 'common.commentList': return '评论列表';
			case 'common.sendComment': return '发表评论';
			case 'common.send': return '发表';
			case 'common.retry': return '重试';
			case 'common.premium': return '高级会员';
			case 'common.follower': return '粉丝';
			case 'common.friend': return '朋友';
			case 'common.video': return '视频';
			case 'common.following': return '关注';
			case 'common.cancelFriendRequest': return '取消申请';
			case 'common.addFriend': return '添加朋友';
			case 'common.removeFriend': return '解除朋友';
			case 'common.followed': return '已关注';
			case 'common.follow': return '关注';
			case 'common.specialFollow': return '特别关注';
			case 'common.specialFollowed': return '已特别关注';
			case 'common.gallery': return '图库';
			case 'common.playlist': return '播放列表';
			case 'common.commentPostedSuccessfully': return '评论发表成功';
			case 'common.commentPostedFailed': return '评论发表失败';
			case 'common.success': return '成功';
			case 'common.commentDeletedSuccessfully': return '评论已删除';
			case 'common.commentUpdatedSuccessfully': return '评论已更新';
			case 'common.totalComments': return ({required Object count}) => '评论 ${count} 条';
			case 'common.writeYourCommentHere': return '写下你的评论...';
			case 'common.tmpNoReplies': return '暂无回复';
			case 'common.loadMore': return '加载更多';
			case 'common.noMoreDatas': return '没有更多数据了';
			case 'common.selectTranslationLanguage': return '选择翻译语言';
			case 'common.translate': return '翻译';
			case 'common.translateFailedPleaseTryAgainLater': return '翻译失败，请稍后重试';
			case 'common.translationResult': return '翻译结果';
			case 'common.justNow': return '刚刚';
			case 'common.minutesAgo': return ({required Object num}) => '${num}分钟前';
			case 'common.hoursAgo': return ({required Object num}) => '${num}小时前';
			case 'common.daysAgo': return ({required Object num}) => '${num}天前';
			case 'common.editedAt': return ({required Object num}) => '编辑于${num}前';
			case 'common.editComment': return '编辑评论';
			case 'common.commentUpdated': return '评论已更新';
			case 'common.replyComment': return '回复评论';
			case 'common.reply': return '回复';
			case 'common.edit': return '编辑';
			case 'common.unknownUser': return '未知用户';
			case 'common.me': return '我';
			case 'common.author': return '作者';
			case 'common.admin': return '管理员';
			case 'common.viewReplies': return ({required Object num}) => '查看回复 (${num})';
			case 'common.hideReplies': return '隐藏回复';
			case 'common.confirmDelete': return '确认删除';
			case 'common.areYouSureYouWantToDeleteThisItem': return '确定要删除这条记录吗？';
			case 'common.tmpNoComments': return '暂无评论';
			case 'common.refresh': return '刷新';
			case 'common.back': return '返回';
			case 'common.tips': return '提示';
			case 'common.linkIsEmpty': return '链接地址为空';
			case 'common.linkCopiedToClipboard': return '链接地址已复制到剪贴板';
			case 'common.imageCopiedToClipboard': return '图片已复制到剪贴板';
			case 'common.copyImageFailed': return '复制图片失败';
			case 'common.mobileSaveImageIsUnderDevelopment': return '移动端的保存图片功能还在开发中';
			case 'common.imageSavedTo': return '图片已保存到';
			case 'common.saveImageFailed': return '保存图片失败';
			case 'common.close': return '关闭';
			case 'common.more': return '更多';
			case 'common.moreFeaturesToBeDeveloped': return '更多功能待开发';
			case 'common.all': return '全部';
			case 'common.selectedRecords': return ({required Object num}) => '已选择 ${num} 条记录';
			case 'common.cancelSelectAll': return '取消全选';
			case 'common.selectAll': return '全选';
			case 'common.exitEditMode': return '退出编辑模式';
			case 'common.areYouSureYouWantToDeleteSelectedItems': return ({required Object num}) => '确定要删除选中的 ${num} 条记录吗？';
			case 'common.searchHistoryRecords': return '搜索历史记录...';
			case 'common.settings': return '设置';
			case 'common.subscriptions': return '订阅';
			case 'common.videoCount': return ({required Object num}) => '${num} 个视频';
			case 'common.share': return '分享';
			case 'common.areYouSureYouWantToShareThisPlaylist': return '要分享这个播放列表吗?';
			case 'common.editTitle': return '编辑标题';
			case 'common.editMode': return '编辑模式';
			case 'common.pleaseEnterNewTitle': return '请输入新标题';
			case 'common.createPlayList': return '创建播放列表';
			case 'common.create': return '创建';
			case 'auth.login': return '登录';
			case 'auth.logout': return '退出登录';
			case 'auth.email': return '邮箱';
			case 'auth.password': return '密码';
			case 'auth.loginOrRegister': return '登录 / 注册';
			case 'auth.register': return '注册';
			case 'auth.pleaseEnterEmail': return '请输入邮箱';
			case 'auth.pleaseEnterPassword': return '请输入密码';
			case 'auth.passwordMustBeAtLeast6Characters': return '密码至少需要6位';
			case 'auth.pleaseEnterCaptcha': return '请输入验证码';
			case 'auth.captcha': return '验证码';
			case 'auth.refreshCaptcha': return '刷新验证码';
			case 'auth.captchaNotLoaded': return '无法加载验证码';
			case 'auth.loginSuccess': return '登录成功';
			case 'auth.emailVerificationSent': return '邮箱指令已发送';
			case 'errors.error': return '错误';
			case 'errors.required': return '此项必填';
			case 'errors.invalidEmail': return '邮箱格式不正确';
			case 'errors.networkError': return '网络错误，请重试';
			case 'errors.errorWhileFetching': return '获取信息失败';
			case 'errors.commentCanNotBeEmpty': return '评论内容不能为空';
			case 'errors.errorWhileFetchingReplies': return '获取回复时出错，请检查网络连接';
			case 'errors.canNotFindCommentController': return '无法找到评论控制器';
			case 'errors.errorWhileLoadingGallery': return '在加载图库时出现了错误';
			case 'errors.howCouldThereBeNoDataItCantBePossible': return '啊？怎么会没有数据呢？出错了吧 :<';
			case 'errors.unsupportedImageFormat': return ({required Object str}) => '不支持的图片格式: ${str}';
			case 'errors.invalidGalleryId': return '无效的图库ID';
			case 'friends.clickToRestoreFriend': return '点击恢复好友';
			case 'friends.friendsList': return '好友列表';
			case 'friends.friendRequests': return '好友请求';
			case 'friends.friendRequestsList': return '好友请求列表';
			case 'authorProfile.noMoreDatas': return '没有更多数据了';
			case 'authorProfile.userProfile': return '用户资料';
			case 'favorites.clickToRestoreFavorite': return '点击恢复最爱';
			case 'favorites.myFavorites': return '我的最爱';
			case 'galleryDetail.copyLink': return '复制链接地址';
			case 'galleryDetail.copyImage': return '复制图片';
			case 'galleryDetail.saveAs': return '另存为';
			case 'galleryDetail.saveToAlbum': return '保存到相册';
			case 'galleryDetail.publishedAt': return '发布时间';
			case 'galleryDetail.viewsCount': return '观看次数';
			case 'galleryDetail.imageLibraryFunctionIntroduction': return '图库功能介绍';
			case 'galleryDetail.rightClickToSaveSingleImage': return '右键保存单张图片';
			case 'galleryDetail.batchSave': return '批量保存';
			case 'galleryDetail.keyboardLeftAndRightToSwitch': return '键盘的左右控制切换';
			case 'galleryDetail.keyboardUpAndDownToZoom': return '键盘的上下控制缩放';
			case 'galleryDetail.mouseWheelToSwitch': return '鼠标的滚轮滑动控制切换';
			case 'galleryDetail.ctrlAndMouseWheelToZoom': return 'CTRL + 鼠标滚轮控制缩放';
			case 'galleryDetail.moreFeaturesToBeDiscovered': return '更多功能待发现...';
			case 'galleryDetail.authorOtherGalleries': return '作者的其他图库';
			case 'galleryDetail.relatedGalleries': return '相关图库';
			case 'playList.myPlayList': return '我的播放列表';
			case 'playList.friendlyTips': return '友情提示';
			case 'playList.dearUser': return '亲爱的用户';
			case 'playList.iwaraPlayListSystemIsNotPerfectYet': return 'iwara的播放列表系统目前还不太完善';
			case 'playList.notSupportSetCover': return '不支持设置封面';
			case 'playList.notSupportDeleteList': return '不能删除列表';
			case 'playList.notSupportSetPrivate': return '无法设为私密';
			case 'playList.yesCreateListWillAlwaysExistAndVisibleToEveryone': return '没错...创建的列表会一直存在且对所有人可见';
			case 'playList.smallSuggestion': return '小建议';
			case 'playList.useLikeToCollectContent': return '如果您比较注重隐私，建议使用"点赞"功能来收藏内容';
			case 'playList.welcomeToDiscussOnGitHub': return '如果你有其他的建议或想法，欢迎来 GitHub 讨论!';
			case 'playList.iUnderstand': return '明白了';
			default: return null;
		}
	}
}

