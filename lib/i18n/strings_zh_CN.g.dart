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
	@override late final _TranslationsSearchZhCn search = _TranslationsSearchZhCn._(_root);
	@override late final _TranslationsMediaListZhCn mediaList = _TranslationsMediaListZhCn._(_root);
	@override late final _TranslationsSettingsZhCn settings = _TranslationsSettingsZhCn._(_root);
	@override late final _TranslationsSignInZhCn signIn = _TranslationsSignInZhCn._(_root);
	@override late final _TranslationsSubscriptionsZhCn subscriptions = _TranslationsSubscriptionsZhCn._(_root);
	@override late final _TranslationsVideoDetailZhCn videoDetail = _TranslationsVideoDetailZhCn._(_root);
	@override late final _TranslationsShareZhCn share = _TranslationsShareZhCn._(_root);
	@override late final _TranslationsMarkdownZhCn markdown = _TranslationsMarkdownZhCn._(_root);
	@override late final _TranslationsForumZhCn forum = _TranslationsForumZhCn._(_root);
	@override late final _TranslationsNotificationsZhCn notifications = _TranslationsNotificationsZhCn._(_root);
	@override late final _TranslationsConversationZhCn conversation = _TranslationsConversationZhCn._(_root);
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
	@override String get expand => '展开';
	@override String get collapse => '收起';
	@override String get cancelFriendRequest => '取消申请';
	@override String get cancelSpecialFollow => '取消特别关注';
	@override String get addFriend => '添加朋友';
	@override String get removeFriend => '解除朋友';
	@override String get followed => '已关注';
	@override String get follow => '关注';
	@override String get unfollow => '取消关注';
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
	@override String get writeYourCommentHere => '在此输入评论...';
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
	@override String editedAt({required Object num}) => '${num}编辑';
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
	@override String get checkNetworkSettings => '检查网络设置';
	@override String get general => '大众的';
	@override String get r18 => 'R18';
	@override String get sensitive => '敏感';
	@override String get year => '年份';
	@override String get tag => '标签';
	@override String get private => '私密';
	@override String get noTitle => '无标题';
	@override String get search => '搜索';
	@override String get noContent => '没有内容哦';
	@override String get recording => '记录中';
	@override String get paused => '已暂停';
	@override String get clear => '清除';
	@override String get user => '用户';
	@override String get post => '投稿';
	@override String get seconds => '秒';
	@override String get comingSoon => '敬请期待';
	@override String get confirm => '确认';
	@override String get hour => '时';
	@override String get minute => '分';
	@override String get clickToRefresh => '点击刷新';
	@override String get history => '历史记录';
	@override String get favorites => '最爱';
	@override String get friends => '好友';
	@override String get playList => '播放列表';
	@override String get checkLicense => '查看许可';
	@override String get logout => '退出登录';
	@override String get fensi => '粉丝';
	@override String get accept => '接受';
	@override String get reject => '拒绝';
	@override String get clearAllHistory => '清空所有历史记录';
	@override String get clearAllHistoryConfirm => '确定要清空所有历史记录吗？';
	@override String get followingList => '关注列表';
	@override String get followersList => '粉丝列表';
	@override String get followers => '粉丝';
	@override String get follows => '关注';
	@override String get fans => '粉丝';
	@override String get followsAndFans => '关注与粉丝';
	@override String get numViews => '观看次数';
	@override String get updatedAt => '更新时间';
	@override String get publishedAt => '发布时间';
	@override String get externalVideo => '站外视频';
	@override String get originalText => '原文';
	@override String get showOriginalText => '显示原始文本';
	@override String get showProcessedText => '显示处理后文本';
	@override String get preview => '预览';
	@override String get markdownSyntax => 'Markdown 语法';
	@override String get rules => '规则';
	@override String get agree => '同意';
	@override String get disagree => '不同意';
	@override String get agreeToRules => '同意规则';
	@override String get createPost => '创建投稿';
	@override String get title => '标题';
	@override String get enterTitle => '请输入标题';
	@override String get content => '内容';
	@override String get enterContent => '请输入内容';
	@override String get writeYourContentHere => '请输入内容...';
	@override String get tagBlacklist => '黑名单标签';
	@override String get noData => '没有数据';
	@override String get tagLimit => '标签上限';
	@override String get enableFloatingButtons => '启用浮动按钮';
	@override String get disableFloatingButtons => '禁用浮动按钮';
	@override String get enabledFloatingButtons => '已启用浮动按钮';
	@override String get disabledFloatingButtons => '已禁用浮动按钮';
	@override String get pendingCommentCount => '待审核评论';
}

// Path: auth
class _TranslationsAuthZhCn implements TranslationsAuthEn {
	_TranslationsAuthZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get tagLimit => '标签上限';
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
	@override String get notLoggedIn => '未登录';
	@override String get clickToLogin => '点击此处登录';
	@override String get logoutConfirmation => '你确定要退出登录吗？';
	@override String get logoutSuccess => '退出登录成功';
	@override String get logoutFailed => '退出登录失败';
	@override String get usernameOrEmail => '用户名或邮箱';
	@override String get pleaseEnterUsernameOrEmail => '请输入用户名或邮箱';
	@override String get username => '用户名或邮箱';
	@override String get pleaseEnterUsername => '请输入用户名或邮箱';
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
	@override String get translationFailedPleaseTryAgainLater => '翻译失败，请稍后重试';
	@override String get errorOccurred => '出错了，请稍后再试';
	@override String get errorOccurredWhileProcessingRequest => '处理请求时出错';
	@override String get errorWhileFetchingDatas => '获取数据时出错，请稍后再试';
	@override String get serviceNotInitialized => '服务未初始化';
	@override String get unknownType => '未知类型';
	@override String errorWhileOpeningLink({required Object link}) => '无法打开链接: ${link}';
	@override String get invalidUrl => '无效的URL';
	@override String get failedToOperate => '操作失败';
	@override String get permissionDenied => '权限不足';
	@override String get youDoNotHavePermissionToAccessThisResource => '您没有权限访问此资源';
	@override String get loginFailed => '登录失败';
	@override String get unknownError => '未知错误';
	@override String get sessionExpired => '会话已过期';
	@override String get failedToFetchCaptcha => '获取验证码失败';
	@override String get emailAlreadyExists => '邮箱已存在';
	@override String get invalidCaptcha => '无效的验证码';
	@override String get registerFailed => '注册失败';
	@override String get failedToFetchComments => '获取评论失败';
	@override String get failedToFetchImageDetail => '获取图库详情失败';
	@override String get failedToFetchImageList => '获取图库列表失败';
	@override String get failedToFetchData => '获取数据失败';
	@override String get invalidParameter => '无效的参数';
	@override String get pleaseLoginFirst => '请先登录';
	@override String get errorWhileLoadingPost => '载入投稿内容时出错';
	@override String get errorWhileLoadingPostDetail => '载入投稿详情时出错';
	@override String get invalidPostId => '无效的投稿ID';
	@override String get forceUpdateNotPermittedToGoBack => '目前处于强制更新状态，无法返回';
	@override String get pleaseLoginAgain => '请重新登录';
	@override String get invalidLogin => '登录失败，请检查邮箱和密码';
	@override String get tooManyRequests => '请求过多，请稍后再试';
	@override String exceedsMaxLength({required Object max}) => '超出最大长度: ${max} 个字符';
	@override String get contentCanNotBeEmpty => '内容不能为空';
	@override String get titleCanNotBeEmpty => '标题不能为空';
	@override String get tooManyRequestsPleaseTryAgainLaterText => '请求过多，请稍后再试，剩余时间';
	@override String remainingHours({required Object num}) => '${num}小时';
	@override String remainingMinutes({required Object num}) => '${num}分钟';
	@override String remainingSeconds({required Object num}) => '${num}秒';
	@override String tagLimitExceeded({required Object limit}) => '标签上限超出，上限: ${limit}';
	@override String get failedToRefresh => '更新失败';
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
	@override String get clickLeftAndRightEdgeToSwitchImage => '点击左右边缘以切换图片';
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
	@override String get searchPlaylists => '搜索播放列表...';
	@override String get newPlaylistName => '新播放列表名称';
	@override String get createNewPlaylist => '创建新播放列表';
	@override String get videos => '视频';
}

// Path: search
class _TranslationsSearchZhCn implements TranslationsSearchEn {
	_TranslationsSearchZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get searchTags => '搜索标签...';
	@override String get contentRating => '内容评级';
	@override String get removeTag => '移除标签';
	@override String get pleaseEnterSearchContent => '请输入搜索内容';
	@override String get searchHistory => '搜索历史';
	@override String get searchSuggestion => '搜索建议';
	@override String get usedTimes => '使用次数';
	@override String get lastUsed => '最后使用';
	@override String get noSearchHistoryRecords => '没有搜索历史';
	@override String notSupportCurrentSearchType({required Object searchType}) => '暂未实现当前搜索类型 ${searchType}，敬请期待';
	@override String get searchResult => '搜索结果';
	@override String unsupportedSearchType({required Object searchType}) => '不支持的搜索类型: ${searchType}';
}

// Path: mediaList
class _TranslationsMediaListZhCn implements TranslationsMediaListEn {
	_TranslationsMediaListZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get personalIntroduction => '个人简介';
}

// Path: settings
class _TranslationsSettingsZhCn implements TranslationsSettingsEn {
	_TranslationsSettingsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get searchConfig => '搜索配置';
	@override String get thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain => '此配置决定当你之后播放视频时是否会沿用之前的配置。';
	@override String get playControl => '播放控制';
	@override String get fastForwardTime => '快进时间';
	@override String get fastForwardTimeMustBeAPositiveInteger => '快进时间必须是一个正整数。';
	@override String get rewindTime => '后退时间';
	@override String get rewindTimeMustBeAPositiveInteger => '后退时间必须是一个正整数。';
	@override String get longPressPlaybackSpeed => '长按播放倍速';
	@override String get longPressPlaybackSpeedMustBeAPositiveNumber => '长按播放倍速必须是一个正数。';
	@override String get repeat => '循环播放';
	@override String get renderVerticalVideoInVerticalScreen => '全屏播放时以竖屏模式渲染竖屏视频';
	@override String get thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen => '此配置决定当你在全屏播放时是否以竖屏模式渲染竖屏视频。';
	@override String get rememberVolume => '记住音量';
	@override String get thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain => '此配置决定当你之后播放视频时是否会沿用之前的音量设置。';
	@override String get rememberBrightness => '记住亮度';
	@override String get thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain => '此配置决定当你之后播放视频时是否会沿用之前的亮度设置。';
	@override String get playControlArea => '播放控制区域';
	@override String get leftAndRightControlAreaWidth => '左右控制区域宽度';
	@override String get thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer => '此配置决定播放器左右两侧的控制区域宽度。';
	@override String get proxyAddressCannotBeEmpty => '代理地址不能为空。';
	@override String get invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort => '无效的代理地址格式。请使用 IP:端口 或 域名:端口 格式。';
	@override String get proxyNormalWork => '代理正常工作。';
	@override String testProxyFailedWithStatusCode({required Object code}) => '代理请求失败，状态码: ${code}';
	@override String testProxyFailedWithException({required Object exception}) => '代理请求出错: ${exception}';
	@override String get proxyConfig => '代理配置';
	@override String get thisIsHttpProxyAddress => '此处为http代理地址';
	@override String get checkProxy => '检查代理';
	@override String get proxyAddress => '代理地址';
	@override String get pleaseEnterTheUrlOfTheProxyServerForExample1270018080 => '请输入代理服务器的URL，例如 127.0.0.1:8080';
	@override String get enableProxy => '启用代理';
	@override String get left => '左侧';
	@override String get middle => '中间';
	@override String get right => '右侧';
	@override String get playerSettings => '播放器设置';
	@override String get networkSettings => '网络设置';
	@override String get customizeYourPlaybackExperience => '自定义您的播放体验';
	@override String get chooseYourFavoriteAppAppearance => '选择您喜欢的应用外观';
	@override String get configureYourProxyServer => '配置您的代理服务器';
	@override String get settings => '设置';
	@override String get themeSettings => '主题设置';
	@override String get followSystem => '跟随系统';
	@override String get lightMode => '浅色模式';
	@override String get darkMode => '深色模式';
	@override String get presetTheme => '预设主题';
	@override String get basicTheme => '基础主题';
	@override String get needRestartToApply => '需要重启应用以应用设置';
	@override String get themeNeedRestartDescription => '主题设置需要重启应用以应用设置';
	@override String get about => '关于';
	@override String get currentVersion => '当前版本';
	@override String get latestVersion => '最新版本';
	@override String get checkForUpdates => '检查更新';
	@override String get update => '更新';
	@override String get newVersionAvailable => '发现新版本';
	@override String get projectHome => '开源地址';
	@override String get release => '版本发布';
	@override String get issueReport => '问题反馈';
	@override String get openSourceLicense => '开源许可';
	@override String get checkForUpdatesFailed => '检查更新失败，请稍后重试';
	@override String get autoCheckUpdate => '自动检查更新';
	@override String get updateContent => '更新内容：';
	@override String get releaseDate => '发布日期';
	@override String get ignoreThisVersion => '忽略此版本';
	@override String get minVersionUpdateRequired => '当前版本过低，请尽快更新';
	@override String get forceUpdateTip => '此版本为强制更新，请尽快更新到最新版本';
	@override String get viewChangelog => '查看更新日志';
	@override String get alreadyLatestVersion => '已是最新版本';
	@override String get appSettings => '应用设置';
	@override String get configureYourAppSettings => '配置您的应用程序设置';
	@override String get history => '历史记录';
	@override String get autoRecordHistory => '自动记录历史记录';
	@override String get autoRecordHistoryDesc => '自动记录您观看过的视频和图库等信息';
	@override String get showUnprocessedMarkdownText => '显示未处理文本';
	@override String get showUnprocessedMarkdownTextDesc => '显示Markdown的原始文本';
	@override String get markdown => 'Markdown';
	@override String get activeBackgroundPrivacyMode => '激活后台隐私模式';
	@override String get activeBackgroundPrivacyModeDesc => '激活后台隐私模式';
	@override String get privacy => '隐私';
	@override String get forum => '论坛';
	@override String get disableForumReplyQuote => '禁用论坛回复引用';
	@override String get disableForumReplyQuoteDesc => '禁用论坛回复时携带被回复楼层信息';
}

// Path: signIn
class _TranslationsSignInZhCn implements TranslationsSignInEn {
	_TranslationsSignInZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirst => '请先登录后再签到';
	@override String get alreadySignedInToday => '您今天已经签到过了！';
	@override String get youDidNotStickToTheSignIn => '您未能坚持签到。';
	@override String get signInSuccess => '签到成功！';
	@override String get signInFailed => '签到失败，请稍后再试';
	@override String get consecutiveSignIns => '连续签到天数';
	@override String get failureReason => '未能坚持签到的原因';
	@override String get selectDateRange => '选择日期范围';
	@override String get startDate => '开始日期';
	@override String get endDate => '结束日期';
	@override String get invalidDate => '日期格式错误';
	@override String get invalidDateRange => '日期范围无效';
	@override String get errorFormatText => '日期格式错误';
	@override String get errorInvalidText => '日期范围无效';
	@override String get errorInvalidRangeText => '日期范围无效';
	@override String get dateRangeCantBeMoreThanOneYear => '日期范围不能超过1年';
	@override String get signIn => '签到';
	@override String get signInRecord => '签到记录';
	@override String get totalSignIns => '总成功签到';
	@override String get pleaseSelectSignInStatus => '请选择签到状态';
}

// Path: subscriptions
class _TranslationsSubscriptionsZhCn implements TranslationsSubscriptionsEn {
	_TranslationsSubscriptionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirstToViewYourSubscriptions => '请登录以查看您的订阅内容。';
}

// Path: videoDetail
class _TranslationsVideoDetailZhCn implements TranslationsVideoDetailEn {
	_TranslationsVideoDetailZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get videoIdIsEmpty => '视频ID为空';
	@override String get videoInfoIsEmpty => '视频信息为空';
	@override String get thisIsAPrivateVideo => '这是一个私密视频';
	@override String get getVideoInfoFailed => '获取视频信息失败，请稍后再试';
	@override String get noVideoSourceFound => '未找到对应的视频源';
	@override String tagCopiedToClipboard({required Object tagId}) => '标签 "${tagId}" 已复制到剪贴板';
	@override String get errorLoadingVideo => '在加载视频时出现了错误';
	@override String get play => '播放';
	@override String get pause => '暂停';
	@override String get exitAppFullscreen => '退出应用全屏';
	@override String get enterAppFullscreen => '应用全屏';
	@override String get exitSystemFullscreen => '退出系统全屏';
	@override String get enterSystemFullscreen => '系统全屏';
	@override String get seekTo => '跳转到指定时间';
	@override String get switchResolution => '切换分辨率';
	@override String get switchPlaybackSpeed => '切换播放倍速';
	@override String rewindSeconds({required Object num}) => '后退${num}秒';
	@override String fastForwardSeconds({required Object num}) => '快进${num}秒';
	@override String playbackSpeedIng({required Object rate}) => '正在以${rate}倍速播放';
	@override String get brightness => '亮度';
	@override String get brightnessLowest => '亮度已最低';
	@override String get volume => '音量';
	@override String get volumeMuted => '音量已静音';
	@override String get home => '主页';
	@override String get videoPlayer => '视频播放器';
	@override String get videoPlayerInfo => '播放器信息';
	@override String get moreSettings => '更多设置';
	@override String get videoPlayerFeatureInfo => '播放器功能介绍';
	@override String get autoRewind => '自动重播';
	@override String get rewindAndFastForward => '左右两侧双击快进或后退';
	@override String get volumeAndBrightness => '左右两侧垂直滑动调整音量、亮度';
	@override String get centerAreaDoubleTapPauseOrPlay => '中心区域双击暂停或播放';
	@override String get showVerticalVideoInFullScreen => '在全屏时可以以竖屏方式显示竖屏视频';
	@override String get keepLastVolumeAndBrightness => '保持上次调整的音量、亮度';
	@override String get setProxy => '设置代理';
	@override String get moreFeaturesToBeDiscovered => '更多功能待发现...';
	@override String get videoPlayerSettings => '播放器设置';
	@override String commentCount({required Object num}) => '评论 ${num} 条';
	@override String get writeYourCommentHere => '写下你的评论...';
	@override String get authorOtherVideos => '作者的其他视频';
	@override String get relatedVideos => '相关视频';
	@override String get privateVideo => '这是一个私密视频';
	@override String get externalVideo => '这是一个站外视频';
	@override String get openInBrowser => '在浏览器中打开';
	@override String get resourceDeleted => '这个视频貌似被删除了 :/';
}

// Path: share
class _TranslationsShareZhCn implements TranslationsShareEn {
	_TranslationsShareZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get sharePlayList => '分享播放列表';
	@override String get wowDidYouSeeThis => '哇哦，你看过这个吗？';
	@override String get nameIs => '名字叫做';
	@override String get clickLinkToView => '点击链接查看';
	@override String get iReallyLikeThis => '我真的是太喜欢这个了，你也来看看吧！';
	@override String get shareFailed => '分享失败，请稍后再试';
	@override String get share => '分享';
}

// Path: markdown
class _TranslationsMarkdownZhCn implements TranslationsMarkdownEn {
	_TranslationsMarkdownZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get markdownSyntax => 'Markdown 语法';
	@override String get iwaraSpecialMarkdownSyntax => 'Iwara 专用语法';
	@override String get internalLink => '站内链接';
	@override String get supportAutoConvertLinkBelow => '支持自动转换以下类型的链接：';
	@override String get convertLinkExample => '🎬 视频链接\n🖼️ 图片链接\n👤 用户链接\n📌 论坛链接\n🎵 播放列表链接\n💬 投稿链接';
	@override String get mentionUser => '提及用户';
	@override String get mentionUserDescription => '输入@后跟用户名，将自动转换为用户链接';
	@override String get markdownBasicSyntax => 'Markdown 基本语法';
	@override String get paragraphAndLineBreak => '段落与换行';
	@override String get paragraphAndLineBreakDescription => '段落之间空一行，行末加两个空格实现换行';
	@override String get paragraphAndLineBreakSyntax => '这是第一段文字\n\n这是第二段文字\n这一行后面加两个空格  \n就能换行了';
	@override String get textStyle => '文本样式';
	@override String get textStyleDescription => '使用特殊符号包围文本来改变样式';
	@override String get textStyleSyntax => '**粗体文本**\n*斜体文本*\n~~删除线文本~~\n`代码文本`';
	@override String get quote => '引用';
	@override String get quoteDescription => '使用 > 符号创建引用，多个 > 创建多级引用';
	@override String get quoteSyntax => '> 这是一级引用\n>> 这是二级引用';
	@override String get list => '列表';
	@override String get listDescription => '使用数字+点号创建有序列表，使用 - 创建无序列表';
	@override String get listSyntax => '1. 第一项\n2. 第二项\n\n- 无序项\n  - 子项\n  - 另一个子项';
	@override String get linkAndImage => '链接与图片';
	@override String get linkAndImageDescription => '链接格式：[文字](URL)\n图片格式：![描述](URL)';
	@override String linkAndImageSyntax({required Object link, required Object imgUrl}) => '[链接文字](${link})\n![图片描述](${imgUrl})';
	@override String get title => '标题';
	@override String get titleDescription => '使用 # 号创建标题，数量表示级别';
	@override String get titleSyntax => '# 一级标题\n## 二级标题\n### 三级标题';
	@override String get separator => '分隔线';
	@override String get separatorDescription => '使用三个或更多 - 号创建分隔线';
	@override String get separatorSyntax => '---';
	@override String get syntax => '语法';
}

// Path: forum
class _TranslationsForumZhCn implements TranslationsForumEn {
	_TranslationsForumZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsForumErrorsZhCn errors = _TranslationsForumErrorsZhCn._(_root);
	@override String get createPost => '创建帖子';
	@override String get title => '标题';
	@override String get enterTitle => '输入标题';
	@override String get content => '内容';
	@override String get enterContent => '输入内容';
	@override String get writeYourContentHere => '在此输入内容...';
	@override String get posts => '帖子';
	@override String get threads => '主题';
	@override String get forum => '论坛';
	@override String get createThread => '创建主题';
	@override String get selectCategory => '选择分类';
	@override String cooldownRemaining({required Object minutes, required Object seconds}) => '冷却剩余时间 ${minutes} 分 ${seconds} 秒';
	@override late final _TranslationsForumGroupsZhCn groups = _TranslationsForumGroupsZhCn._(_root);
	@override late final _TranslationsForumLeafNamesZhCn leafNames = _TranslationsForumLeafNamesZhCn._(_root);
	@override late final _TranslationsForumLeafDescriptionsZhCn leafDescriptions = _TranslationsForumLeafDescriptionsZhCn._(_root);
	@override String get reply => '回覆';
	@override String get pendingReview => '审核中';
	@override String get editedAt => '编辑时间';
	@override String get copySuccess => '已复制到剪贴板';
	@override String copySuccessForMessage({required Object str}) => '已复制到剪贴板: ${str}';
	@override String get editReply => '编辑回覆';
	@override String get editTitle => '编辑标题';
	@override String get submit => '提交';
}

// Path: notifications
class _TranslationsNotificationsZhCn implements TranslationsNotificationsEn {
	_TranslationsNotificationsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsNotificationsErrorsZhCn errors = _TranslationsNotificationsErrorsZhCn._(_root);
	@override String get notifications => '通知';
	@override String get video => '视频';
	@override String get profile => '个人主页';
	@override String get postedNewComment => '发表了评论';
	@override String get inYour => '在您的';
	@override String get copyInfoToClipboard => '复制通知信息到剪贴簿';
	@override String get copySuccess => '已复制到剪贴板';
	@override String copySuccessForMessage({required Object str}) => '已复制到剪贴板: ${str}';
	@override String get markAllAsRead => '全部标记已读';
	@override String get markAllAsReadSuccess => '所有通知已标记为已读';
	@override String get markAllAsReadFailed => '全部标记已读失败';
	@override String get markSelectedAsRead => '标记选中项为已读';
	@override String get markSelectedAsReadSuccess => '选中的通知已标记为已读';
	@override String get markSelectedAsReadFailed => '标记选中项为已读失败';
	@override String get markAsRead => '标记已读';
	@override String get markAsReadSuccess => '已标记为已读';
	@override String get markAsReadFailed => '标记已读失败';
	@override String get notificationTypeHelp => '通知类型帮助';
	@override String get dueToLackOfNotificationTypeDetails => '通知类型的详细信息不足，目前支持的类型可能没有覆盖到您当前收到的消息';
	@override String get helpUsImproveNotificationTypeSupport => '如果您愿意帮助我们完善通知类型的支持';
	@override String get helpUsImproveNotificationTypeSupportLongText => '1. 📋 复制通知信息\n2. 🐞 前往项目仓库提交 issue\n\n⚠️ 注意：通知信息可能包含个人隐私，如果你不想公开，也可以通过邮件发送给项目作者。';
	@override String get goToRepository => '前往项目仓库';
	@override String get copy => '复制';
	@override String get commentApproved => '评论已通过审核';
	@override String get repliedYourProfileComment => '回复了您的个人主页评论';
	@override String get repliedYourVideoComment => '回复了您的视频评论';
	@override String get kReplied => '回复了您在';
	@override String get kCommented => '评论了您的';
	@override String get kVideo => '视频';
	@override String get kGallery => '图库';
	@override String get kProfile => '主页';
	@override String get kThread => '主题';
	@override String get kPost => '投稿';
	@override String get kCommentSection => '下的评论';
	@override String get kApprovedComment => '评论审核通过';
	@override String get kApprovedVideo => '视频审核通过';
	@override String get kApprovedGallery => '图库审核通过';
	@override String get kApprovedThread => '帖子审核通过';
	@override String get kApprovedPost => '投稿审核通过';
	@override String get kUnknownType => '未知通知类型';
}

// Path: conversation
class _TranslationsConversationZhCn implements TranslationsConversationEn {
	_TranslationsConversationZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConversationErrorsZhCn errors = _TranslationsConversationErrorsZhCn._(_root);
	@override String get conversation => '会话';
	@override String get startConversation => '发起会话';
	@override String get noConversation => '暂无会话';
	@override String get selectFromLeftListAndStartConversation => '从左侧的会话列表选择一个对话开始聊天';
	@override String get title => '标题';
	@override String get body => '内容';
	@override String get selectAUser => '选择用户';
	@override String get searchUsers => '搜索用户...';
	@override String get tmpNoConversions => '暂无会话';
	@override String get deleteThisMessage => '删除此消息';
	@override String get deleteThisMessageSubtitle => '此操作不可撤销';
	@override String get writeMessageHere => '在此处输入消息';
	@override String get sendMessage => '发送消息';
}

// Path: forum.errors
class _TranslationsForumErrorsZhCn implements TranslationsForumErrorsEn {
	_TranslationsForumErrorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get pleaseSelectCategory => '请选择分类';
	@override String get threadLocked => '该主题已锁定，无法回复';
}

// Path: forum.groups
class _TranslationsForumGroupsZhCn implements TranslationsForumGroupsEn {
	_TranslationsForumGroupsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get administration => '管理';
	@override String get global => '全球';
	@override String get chinese => '中文';
	@override String get japanese => '日语';
	@override String get korean => '韩语';
	@override String get other => '其他';
}

// Path: forum.leafNames
class _TranslationsForumLeafNamesZhCn implements TranslationsForumLeafNamesEn {
	_TranslationsForumLeafNamesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get announcements => '公告';
	@override String get feedback => '反馈';
	@override String get support => '帮助';
	@override String get general => '一般';
	@override String get guides => '指南';
	@override String get questions => '问题';
	@override String get requests => '请求';
	@override String get sharing => '分享';
	@override String get general_zh => '一般';
	@override String get questions_zh => '问题';
	@override String get requests_zh => '请求';
	@override String get support_zh => '帮助';
	@override String get general_ja => '一般';
	@override String get questions_ja => '问题';
	@override String get requests_ja => '请求';
	@override String get support_ja => '帮助';
	@override String get korean => '韩语';
	@override String get other => '其他';
}

// Path: forum.leafDescriptions
class _TranslationsForumLeafDescriptionsZhCn implements TranslationsForumLeafDescriptionsEn {
	_TranslationsForumLeafDescriptionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get announcements => '官方重要通知和公告';
	@override String get feedback => '对网站功能和服务的反馈';
	@override String get support => '帮助解决网站相关问题';
	@override String get general => '讨论任何话题';
	@override String get guides => '分享你的经验和教程';
	@override String get questions => '提出你的疑问';
	@override String get requests => '发布你的请求';
	@override String get sharing => '分享有趣的内容';
	@override String get general_zh => '讨论任何话题';
	@override String get questions_zh => '提出你的疑问';
	@override String get requests_zh => '发布你的请求';
	@override String get support_zh => '帮助解决网站相关问题';
	@override String get general_ja => '讨论任何话题';
	@override String get questions_ja => '提出你的疑问';
	@override String get requests_ja => '发布你的请求';
	@override String get support_ja => '帮助解决网站相关问题';
	@override String get korean => '韩语相关讨论';
	@override String get other => '其他未分类的内容';
}

// Path: notifications.errors
class _TranslationsNotificationsErrorsZhCn implements TranslationsNotificationsErrorsEn {
	_TranslationsNotificationsErrorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get unsupportedNotificationType => '暂不支持的通知类型';
	@override String get unknownUser => '未知用户';
	@override String unsupportedNotificationTypeWithType({required Object type}) => '暂不支持的通知类型: ${type}';
	@override String get unknownNotificationType => '未知通知类型';
}

// Path: conversation.errors
class _TranslationsConversationErrorsZhCn implements TranslationsConversationErrorsEn {
	_TranslationsConversationErrorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get pleaseSelectAUser => '请选择一个用户';
	@override String get pleaseEnterATitle => '请输入标题';
	@override String get clickToSelectAUser => '点击选择用户';
	@override String get loadFailedClickToRetry => '加载失败,点击重试';
	@override String get loadFailed => '加载失败';
	@override String get clickToRetry => '点击重试';
	@override String get noMoreConversations => '没有更多消息了';
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
			case 'common.expand': return '展开';
			case 'common.collapse': return '收起';
			case 'common.cancelFriendRequest': return '取消申请';
			case 'common.cancelSpecialFollow': return '取消特别关注';
			case 'common.addFriend': return '添加朋友';
			case 'common.removeFriend': return '解除朋友';
			case 'common.followed': return '已关注';
			case 'common.follow': return '关注';
			case 'common.unfollow': return '取消关注';
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
			case 'common.writeYourCommentHere': return '在此输入评论...';
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
			case 'common.editedAt': return ({required Object num}) => '${num}编辑';
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
			case 'common.checkNetworkSettings': return '检查网络设置';
			case 'common.general': return '大众的';
			case 'common.r18': return 'R18';
			case 'common.sensitive': return '敏感';
			case 'common.year': return '年份';
			case 'common.tag': return '标签';
			case 'common.private': return '私密';
			case 'common.noTitle': return '无标题';
			case 'common.search': return '搜索';
			case 'common.noContent': return '没有内容哦';
			case 'common.recording': return '记录中';
			case 'common.paused': return '已暂停';
			case 'common.clear': return '清除';
			case 'common.user': return '用户';
			case 'common.post': return '投稿';
			case 'common.seconds': return '秒';
			case 'common.comingSoon': return '敬请期待';
			case 'common.confirm': return '确认';
			case 'common.hour': return '时';
			case 'common.minute': return '分';
			case 'common.clickToRefresh': return '点击刷新';
			case 'common.history': return '历史记录';
			case 'common.favorites': return '最爱';
			case 'common.friends': return '好友';
			case 'common.playList': return '播放列表';
			case 'common.checkLicense': return '查看许可';
			case 'common.logout': return '退出登录';
			case 'common.fensi': return '粉丝';
			case 'common.accept': return '接受';
			case 'common.reject': return '拒绝';
			case 'common.clearAllHistory': return '清空所有历史记录';
			case 'common.clearAllHistoryConfirm': return '确定要清空所有历史记录吗？';
			case 'common.followingList': return '关注列表';
			case 'common.followersList': return '粉丝列表';
			case 'common.followers': return '粉丝';
			case 'common.follows': return '关注';
			case 'common.fans': return '粉丝';
			case 'common.followsAndFans': return '关注与粉丝';
			case 'common.numViews': return '观看次数';
			case 'common.updatedAt': return '更新时间';
			case 'common.publishedAt': return '发布时间';
			case 'common.externalVideo': return '站外视频';
			case 'common.originalText': return '原文';
			case 'common.showOriginalText': return '显示原始文本';
			case 'common.showProcessedText': return '显示处理后文本';
			case 'common.preview': return '预览';
			case 'common.markdownSyntax': return 'Markdown 语法';
			case 'common.rules': return '规则';
			case 'common.agree': return '同意';
			case 'common.disagree': return '不同意';
			case 'common.agreeToRules': return '同意规则';
			case 'common.createPost': return '创建投稿';
			case 'common.title': return '标题';
			case 'common.enterTitle': return '请输入标题';
			case 'common.content': return '内容';
			case 'common.enterContent': return '请输入内容';
			case 'common.writeYourContentHere': return '请输入内容...';
			case 'common.tagBlacklist': return '黑名单标签';
			case 'common.noData': return '没有数据';
			case 'common.tagLimit': return '标签上限';
			case 'common.enableFloatingButtons': return '启用浮动按钮';
			case 'common.disableFloatingButtons': return '禁用浮动按钮';
			case 'common.enabledFloatingButtons': return '已启用浮动按钮';
			case 'common.disabledFloatingButtons': return '已禁用浮动按钮';
			case 'common.pendingCommentCount': return '待审核评论';
			case 'auth.tagLimit': return '标签上限';
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
			case 'auth.notLoggedIn': return '未登录';
			case 'auth.clickToLogin': return '点击此处登录';
			case 'auth.logoutConfirmation': return '你确定要退出登录吗？';
			case 'auth.logoutSuccess': return '退出登录成功';
			case 'auth.logoutFailed': return '退出登录失败';
			case 'auth.usernameOrEmail': return '用户名或邮箱';
			case 'auth.pleaseEnterUsernameOrEmail': return '请输入用户名或邮箱';
			case 'auth.username': return '用户名或邮箱';
			case 'auth.pleaseEnterUsername': return '请输入用户名或邮箱';
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
			case 'errors.translationFailedPleaseTryAgainLater': return '翻译失败，请稍后重试';
			case 'errors.errorOccurred': return '出错了，请稍后再试';
			case 'errors.errorOccurredWhileProcessingRequest': return '处理请求时出错';
			case 'errors.errorWhileFetchingDatas': return '获取数据时出错，请稍后再试';
			case 'errors.serviceNotInitialized': return '服务未初始化';
			case 'errors.unknownType': return '未知类型';
			case 'errors.errorWhileOpeningLink': return ({required Object link}) => '无法打开链接: ${link}';
			case 'errors.invalidUrl': return '无效的URL';
			case 'errors.failedToOperate': return '操作失败';
			case 'errors.permissionDenied': return '权限不足';
			case 'errors.youDoNotHavePermissionToAccessThisResource': return '您没有权限访问此资源';
			case 'errors.loginFailed': return '登录失败';
			case 'errors.unknownError': return '未知错误';
			case 'errors.sessionExpired': return '会话已过期';
			case 'errors.failedToFetchCaptcha': return '获取验证码失败';
			case 'errors.emailAlreadyExists': return '邮箱已存在';
			case 'errors.invalidCaptcha': return '无效的验证码';
			case 'errors.registerFailed': return '注册失败';
			case 'errors.failedToFetchComments': return '获取评论失败';
			case 'errors.failedToFetchImageDetail': return '获取图库详情失败';
			case 'errors.failedToFetchImageList': return '获取图库列表失败';
			case 'errors.failedToFetchData': return '获取数据失败';
			case 'errors.invalidParameter': return '无效的参数';
			case 'errors.pleaseLoginFirst': return '请先登录';
			case 'errors.errorWhileLoadingPost': return '载入投稿内容时出错';
			case 'errors.errorWhileLoadingPostDetail': return '载入投稿详情时出错';
			case 'errors.invalidPostId': return '无效的投稿ID';
			case 'errors.forceUpdateNotPermittedToGoBack': return '目前处于强制更新状态，无法返回';
			case 'errors.pleaseLoginAgain': return '请重新登录';
			case 'errors.invalidLogin': return '登录失败，请检查邮箱和密码';
			case 'errors.tooManyRequests': return '请求过多，请稍后再试';
			case 'errors.exceedsMaxLength': return ({required Object max}) => '超出最大长度: ${max} 个字符';
			case 'errors.contentCanNotBeEmpty': return '内容不能为空';
			case 'errors.titleCanNotBeEmpty': return '标题不能为空';
			case 'errors.tooManyRequestsPleaseTryAgainLaterText': return '请求过多，请稍后再试，剩余时间';
			case 'errors.remainingHours': return ({required Object num}) => '${num}小时';
			case 'errors.remainingMinutes': return ({required Object num}) => '${num}分钟';
			case 'errors.remainingSeconds': return ({required Object num}) => '${num}秒';
			case 'errors.tagLimitExceeded': return ({required Object limit}) => '标签上限超出，上限: ${limit}';
			case 'errors.failedToRefresh': return '更新失败';
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
			case 'galleryDetail.clickLeftAndRightEdgeToSwitchImage': return '点击左右边缘以切换图片';
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
			case 'playList.searchPlaylists': return '搜索播放列表...';
			case 'playList.newPlaylistName': return '新播放列表名称';
			case 'playList.createNewPlaylist': return '创建新播放列表';
			case 'playList.videos': return '视频';
			case 'search.searchTags': return '搜索标签...';
			case 'search.contentRating': return '内容评级';
			case 'search.removeTag': return '移除标签';
			case 'search.pleaseEnterSearchContent': return '请输入搜索内容';
			case 'search.searchHistory': return '搜索历史';
			case 'search.searchSuggestion': return '搜索建议';
			case 'search.usedTimes': return '使用次数';
			case 'search.lastUsed': return '最后使用';
			case 'search.noSearchHistoryRecords': return '没有搜索历史';
			case 'search.notSupportCurrentSearchType': return ({required Object searchType}) => '暂未实现当前搜索类型 ${searchType}，敬请期待';
			case 'search.searchResult': return '搜索结果';
			case 'search.unsupportedSearchType': return ({required Object searchType}) => '不支持的搜索类型: ${searchType}';
			case 'mediaList.personalIntroduction': return '个人简介';
			case 'settings.searchConfig': return '搜索配置';
			case 'settings.thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain': return '此配置决定当你之后播放视频时是否会沿用之前的配置。';
			case 'settings.playControl': return '播放控制';
			case 'settings.fastForwardTime': return '快进时间';
			case 'settings.fastForwardTimeMustBeAPositiveInteger': return '快进时间必须是一个正整数。';
			case 'settings.rewindTime': return '后退时间';
			case 'settings.rewindTimeMustBeAPositiveInteger': return '后退时间必须是一个正整数。';
			case 'settings.longPressPlaybackSpeed': return '长按播放倍速';
			case 'settings.longPressPlaybackSpeedMustBeAPositiveNumber': return '长按播放倍速必须是一个正数。';
			case 'settings.repeat': return '循环播放';
			case 'settings.renderVerticalVideoInVerticalScreen': return '全屏播放时以竖屏模式渲染竖屏视频';
			case 'settings.thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen': return '此配置决定当你在全屏播放时是否以竖屏模式渲染竖屏视频。';
			case 'settings.rememberVolume': return '记住音量';
			case 'settings.thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain': return '此配置决定当你之后播放视频时是否会沿用之前的音量设置。';
			case 'settings.rememberBrightness': return '记住亮度';
			case 'settings.thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain': return '此配置决定当你之后播放视频时是否会沿用之前的亮度设置。';
			case 'settings.playControlArea': return '播放控制区域';
			case 'settings.leftAndRightControlAreaWidth': return '左右控制区域宽度';
			case 'settings.thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer': return '此配置决定播放器左右两侧的控制区域宽度。';
			case 'settings.proxyAddressCannotBeEmpty': return '代理地址不能为空。';
			case 'settings.invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort': return '无效的代理地址格式。请使用 IP:端口 或 域名:端口 格式。';
			case 'settings.proxyNormalWork': return '代理正常工作。';
			case 'settings.testProxyFailedWithStatusCode': return ({required Object code}) => '代理请求失败，状态码: ${code}';
			case 'settings.testProxyFailedWithException': return ({required Object exception}) => '代理请求出错: ${exception}';
			case 'settings.proxyConfig': return '代理配置';
			case 'settings.thisIsHttpProxyAddress': return '此处为http代理地址';
			case 'settings.checkProxy': return '检查代理';
			case 'settings.proxyAddress': return '代理地址';
			case 'settings.pleaseEnterTheUrlOfTheProxyServerForExample1270018080': return '请输入代理服务器的URL，例如 127.0.0.1:8080';
			case 'settings.enableProxy': return '启用代理';
			case 'settings.left': return '左侧';
			case 'settings.middle': return '中间';
			case 'settings.right': return '右侧';
			case 'settings.playerSettings': return '播放器设置';
			case 'settings.networkSettings': return '网络设置';
			case 'settings.customizeYourPlaybackExperience': return '自定义您的播放体验';
			case 'settings.chooseYourFavoriteAppAppearance': return '选择您喜欢的应用外观';
			case 'settings.configureYourProxyServer': return '配置您的代理服务器';
			case 'settings.settings': return '设置';
			case 'settings.themeSettings': return '主题设置';
			case 'settings.followSystem': return '跟随系统';
			case 'settings.lightMode': return '浅色模式';
			case 'settings.darkMode': return '深色模式';
			case 'settings.presetTheme': return '预设主题';
			case 'settings.basicTheme': return '基础主题';
			case 'settings.needRestartToApply': return '需要重启应用以应用设置';
			case 'settings.themeNeedRestartDescription': return '主题设置需要重启应用以应用设置';
			case 'settings.about': return '关于';
			case 'settings.currentVersion': return '当前版本';
			case 'settings.latestVersion': return '最新版本';
			case 'settings.checkForUpdates': return '检查更新';
			case 'settings.update': return '更新';
			case 'settings.newVersionAvailable': return '发现新版本';
			case 'settings.projectHome': return '开源地址';
			case 'settings.release': return '版本发布';
			case 'settings.issueReport': return '问题反馈';
			case 'settings.openSourceLicense': return '开源许可';
			case 'settings.checkForUpdatesFailed': return '检查更新失败，请稍后重试';
			case 'settings.autoCheckUpdate': return '自动检查更新';
			case 'settings.updateContent': return '更新内容：';
			case 'settings.releaseDate': return '发布日期';
			case 'settings.ignoreThisVersion': return '忽略此版本';
			case 'settings.minVersionUpdateRequired': return '当前版本过低，请尽快更新';
			case 'settings.forceUpdateTip': return '此版本为强制更新，请尽快更新到最新版本';
			case 'settings.viewChangelog': return '查看更新日志';
			case 'settings.alreadyLatestVersion': return '已是最新版本';
			case 'settings.appSettings': return '应用设置';
			case 'settings.configureYourAppSettings': return '配置您的应用程序设置';
			case 'settings.history': return '历史记录';
			case 'settings.autoRecordHistory': return '自动记录历史记录';
			case 'settings.autoRecordHistoryDesc': return '自动记录您观看过的视频和图库等信息';
			case 'settings.showUnprocessedMarkdownText': return '显示未处理文本';
			case 'settings.showUnprocessedMarkdownTextDesc': return '显示Markdown的原始文本';
			case 'settings.markdown': return 'Markdown';
			case 'settings.activeBackgroundPrivacyMode': return '激活后台隐私模式';
			case 'settings.activeBackgroundPrivacyModeDesc': return '激活后台隐私模式';
			case 'settings.privacy': return '隐私';
			case 'settings.forum': return '论坛';
			case 'settings.disableForumReplyQuote': return '禁用论坛回复引用';
			case 'settings.disableForumReplyQuoteDesc': return '禁用论坛回复时携带被回复楼层信息';
			case 'signIn.pleaseLoginFirst': return '请先登录后再签到';
			case 'signIn.alreadySignedInToday': return '您今天已经签到过了！';
			case 'signIn.youDidNotStickToTheSignIn': return '您未能坚持签到。';
			case 'signIn.signInSuccess': return '签到成功！';
			case 'signIn.signInFailed': return '签到失败，请稍后再试';
			case 'signIn.consecutiveSignIns': return '连续签到天数';
			case 'signIn.failureReason': return '未能坚持签到的原因';
			case 'signIn.selectDateRange': return '选择日期范围';
			case 'signIn.startDate': return '开始日期';
			case 'signIn.endDate': return '结束日期';
			case 'signIn.invalidDate': return '日期格式错误';
			case 'signIn.invalidDateRange': return '日期范围无效';
			case 'signIn.errorFormatText': return '日期格式错误';
			case 'signIn.errorInvalidText': return '日期范围无效';
			case 'signIn.errorInvalidRangeText': return '日期范围无效';
			case 'signIn.dateRangeCantBeMoreThanOneYear': return '日期范围不能超过1年';
			case 'signIn.signIn': return '签到';
			case 'signIn.signInRecord': return '签到记录';
			case 'signIn.totalSignIns': return '总成功签到';
			case 'signIn.pleaseSelectSignInStatus': return '请选择签到状态';
			case 'subscriptions.pleaseLoginFirstToViewYourSubscriptions': return '请登录以查看您的订阅内容。';
			case 'videoDetail.videoIdIsEmpty': return '视频ID为空';
			case 'videoDetail.videoInfoIsEmpty': return '视频信息为空';
			case 'videoDetail.thisIsAPrivateVideo': return '这是一个私密视频';
			case 'videoDetail.getVideoInfoFailed': return '获取视频信息失败，请稍后再试';
			case 'videoDetail.noVideoSourceFound': return '未找到对应的视频源';
			case 'videoDetail.tagCopiedToClipboard': return ({required Object tagId}) => '标签 "${tagId}" 已复制到剪贴板';
			case 'videoDetail.errorLoadingVideo': return '在加载视频时出现了错误';
			case 'videoDetail.play': return '播放';
			case 'videoDetail.pause': return '暂停';
			case 'videoDetail.exitAppFullscreen': return '退出应用全屏';
			case 'videoDetail.enterAppFullscreen': return '应用全屏';
			case 'videoDetail.exitSystemFullscreen': return '退出系统全屏';
			case 'videoDetail.enterSystemFullscreen': return '系统全屏';
			case 'videoDetail.seekTo': return '跳转到指定时间';
			case 'videoDetail.switchResolution': return '切换分辨率';
			case 'videoDetail.switchPlaybackSpeed': return '切换播放倍速';
			case 'videoDetail.rewindSeconds': return ({required Object num}) => '后退${num}秒';
			case 'videoDetail.fastForwardSeconds': return ({required Object num}) => '快进${num}秒';
			case 'videoDetail.playbackSpeedIng': return ({required Object rate}) => '正在以${rate}倍速播放';
			case 'videoDetail.brightness': return '亮度';
			case 'videoDetail.brightnessLowest': return '亮度已最低';
			case 'videoDetail.volume': return '音量';
			case 'videoDetail.volumeMuted': return '音量已静音';
			case 'videoDetail.home': return '主页';
			case 'videoDetail.videoPlayer': return '视频播放器';
			case 'videoDetail.videoPlayerInfo': return '播放器信息';
			case 'videoDetail.moreSettings': return '更多设置';
			case 'videoDetail.videoPlayerFeatureInfo': return '播放器功能介绍';
			case 'videoDetail.autoRewind': return '自动重播';
			case 'videoDetail.rewindAndFastForward': return '左右两侧双击快进或后退';
			case 'videoDetail.volumeAndBrightness': return '左右两侧垂直滑动调整音量、亮度';
			case 'videoDetail.centerAreaDoubleTapPauseOrPlay': return '中心区域双击暂停或播放';
			case 'videoDetail.showVerticalVideoInFullScreen': return '在全屏时可以以竖屏方式显示竖屏视频';
			case 'videoDetail.keepLastVolumeAndBrightness': return '保持上次调整的音量、亮度';
			case 'videoDetail.setProxy': return '设置代理';
			case 'videoDetail.moreFeaturesToBeDiscovered': return '更多功能待发现...';
			case 'videoDetail.videoPlayerSettings': return '播放器设置';
			case 'videoDetail.commentCount': return ({required Object num}) => '评论 ${num} 条';
			case 'videoDetail.writeYourCommentHere': return '写下你的评论...';
			case 'videoDetail.authorOtherVideos': return '作者的其他视频';
			case 'videoDetail.relatedVideos': return '相关视频';
			case 'videoDetail.privateVideo': return '这是一个私密视频';
			case 'videoDetail.externalVideo': return '这是一个站外视频';
			case 'videoDetail.openInBrowser': return '在浏览器中打开';
			case 'videoDetail.resourceDeleted': return '这个视频貌似被删除了 :/';
			case 'share.sharePlayList': return '分享播放列表';
			case 'share.wowDidYouSeeThis': return '哇哦，你看过这个吗？';
			case 'share.nameIs': return '名字叫做';
			case 'share.clickLinkToView': return '点击链接查看';
			case 'share.iReallyLikeThis': return '我真的是太喜欢这个了，你也来看看吧！';
			case 'share.shareFailed': return '分享失败，请稍后再试';
			case 'share.share': return '分享';
			case 'markdown.markdownSyntax': return 'Markdown 语法';
			case 'markdown.iwaraSpecialMarkdownSyntax': return 'Iwara 专用语法';
			case 'markdown.internalLink': return '站内链接';
			case 'markdown.supportAutoConvertLinkBelow': return '支持自动转换以下类型的链接：';
			case 'markdown.convertLinkExample': return '🎬 视频链接\n🖼️ 图片链接\n👤 用户链接\n📌 论坛链接\n🎵 播放列表链接\n💬 投稿链接';
			case 'markdown.mentionUser': return '提及用户';
			case 'markdown.mentionUserDescription': return '输入@后跟用户名，将自动转换为用户链接';
			case 'markdown.markdownBasicSyntax': return 'Markdown 基本语法';
			case 'markdown.paragraphAndLineBreak': return '段落与换行';
			case 'markdown.paragraphAndLineBreakDescription': return '段落之间空一行，行末加两个空格实现换行';
			case 'markdown.paragraphAndLineBreakSyntax': return '这是第一段文字\n\n这是第二段文字\n这一行后面加两个空格  \n就能换行了';
			case 'markdown.textStyle': return '文本样式';
			case 'markdown.textStyleDescription': return '使用特殊符号包围文本来改变样式';
			case 'markdown.textStyleSyntax': return '**粗体文本**\n*斜体文本*\n~~删除线文本~~\n`代码文本`';
			case 'markdown.quote': return '引用';
			case 'markdown.quoteDescription': return '使用 > 符号创建引用，多个 > 创建多级引用';
			case 'markdown.quoteSyntax': return '> 这是一级引用\n>> 这是二级引用';
			case 'markdown.list': return '列表';
			case 'markdown.listDescription': return '使用数字+点号创建有序列表，使用 - 创建无序列表';
			case 'markdown.listSyntax': return '1. 第一项\n2. 第二项\n\n- 无序项\n  - 子项\n  - 另一个子项';
			case 'markdown.linkAndImage': return '链接与图片';
			case 'markdown.linkAndImageDescription': return '链接格式：[文字](URL)\n图片格式：![描述](URL)';
			case 'markdown.linkAndImageSyntax': return ({required Object link, required Object imgUrl}) => '[链接文字](${link})\n![图片描述](${imgUrl})';
			case 'markdown.title': return '标题';
			case 'markdown.titleDescription': return '使用 # 号创建标题，数量表示级别';
			case 'markdown.titleSyntax': return '# 一级标题\n## 二级标题\n### 三级标题';
			case 'markdown.separator': return '分隔线';
			case 'markdown.separatorDescription': return '使用三个或更多 - 号创建分隔线';
			case 'markdown.separatorSyntax': return '---';
			case 'markdown.syntax': return '语法';
			case 'forum.errors.pleaseSelectCategory': return '请选择分类';
			case 'forum.errors.threadLocked': return '该主题已锁定，无法回复';
			case 'forum.createPost': return '创建帖子';
			case 'forum.title': return '标题';
			case 'forum.enterTitle': return '输入标题';
			case 'forum.content': return '内容';
			case 'forum.enterContent': return '输入内容';
			case 'forum.writeYourContentHere': return '在此输入内容...';
			case 'forum.posts': return '帖子';
			case 'forum.threads': return '主题';
			case 'forum.forum': return '论坛';
			case 'forum.createThread': return '创建主题';
			case 'forum.selectCategory': return '选择分类';
			case 'forum.cooldownRemaining': return ({required Object minutes, required Object seconds}) => '冷却剩余时间 ${minutes} 分 ${seconds} 秒';
			case 'forum.groups.administration': return '管理';
			case 'forum.groups.global': return '全球';
			case 'forum.groups.chinese': return '中文';
			case 'forum.groups.japanese': return '日语';
			case 'forum.groups.korean': return '韩语';
			case 'forum.groups.other': return '其他';
			case 'forum.leafNames.announcements': return '公告';
			case 'forum.leafNames.feedback': return '反馈';
			case 'forum.leafNames.support': return '帮助';
			case 'forum.leafNames.general': return '一般';
			case 'forum.leafNames.guides': return '指南';
			case 'forum.leafNames.questions': return '问题';
			case 'forum.leafNames.requests': return '请求';
			case 'forum.leafNames.sharing': return '分享';
			case 'forum.leafNames.general_zh': return '一般';
			case 'forum.leafNames.questions_zh': return '问题';
			case 'forum.leafNames.requests_zh': return '请求';
			case 'forum.leafNames.support_zh': return '帮助';
			case 'forum.leafNames.general_ja': return '一般';
			case 'forum.leafNames.questions_ja': return '问题';
			case 'forum.leafNames.requests_ja': return '请求';
			case 'forum.leafNames.support_ja': return '帮助';
			case 'forum.leafNames.korean': return '韩语';
			case 'forum.leafNames.other': return '其他';
			case 'forum.leafDescriptions.announcements': return '官方重要通知和公告';
			case 'forum.leafDescriptions.feedback': return '对网站功能和服务的反馈';
			case 'forum.leafDescriptions.support': return '帮助解决网站相关问题';
			case 'forum.leafDescriptions.general': return '讨论任何话题';
			case 'forum.leafDescriptions.guides': return '分享你的经验和教程';
			case 'forum.leafDescriptions.questions': return '提出你的疑问';
			case 'forum.leafDescriptions.requests': return '发布你的请求';
			case 'forum.leafDescriptions.sharing': return '分享有趣的内容';
			case 'forum.leafDescriptions.general_zh': return '讨论任何话题';
			case 'forum.leafDescriptions.questions_zh': return '提出你的疑问';
			case 'forum.leafDescriptions.requests_zh': return '发布你的请求';
			case 'forum.leafDescriptions.support_zh': return '帮助解决网站相关问题';
			case 'forum.leafDescriptions.general_ja': return '讨论任何话题';
			case 'forum.leafDescriptions.questions_ja': return '提出你的疑问';
			case 'forum.leafDescriptions.requests_ja': return '发布你的请求';
			case 'forum.leafDescriptions.support_ja': return '帮助解决网站相关问题';
			case 'forum.leafDescriptions.korean': return '韩语相关讨论';
			case 'forum.leafDescriptions.other': return '其他未分类的内容';
			case 'forum.reply': return '回覆';
			case 'forum.pendingReview': return '审核中';
			case 'forum.editedAt': return '编辑时间';
			case 'forum.copySuccess': return '已复制到剪贴板';
			case 'forum.copySuccessForMessage': return ({required Object str}) => '已复制到剪贴板: ${str}';
			case 'forum.editReply': return '编辑回覆';
			case 'forum.editTitle': return '编辑标题';
			case 'forum.submit': return '提交';
			case 'notifications.errors.unsupportedNotificationType': return '暂不支持的通知类型';
			case 'notifications.errors.unknownUser': return '未知用户';
			case 'notifications.errors.unsupportedNotificationTypeWithType': return ({required Object type}) => '暂不支持的通知类型: ${type}';
			case 'notifications.errors.unknownNotificationType': return '未知通知类型';
			case 'notifications.notifications': return '通知';
			case 'notifications.video': return '视频';
			case 'notifications.profile': return '个人主页';
			case 'notifications.postedNewComment': return '发表了评论';
			case 'notifications.inYour': return '在您的';
			case 'notifications.copyInfoToClipboard': return '复制通知信息到剪贴簿';
			case 'notifications.copySuccess': return '已复制到剪贴板';
			case 'notifications.copySuccessForMessage': return ({required Object str}) => '已复制到剪贴板: ${str}';
			case 'notifications.markAllAsRead': return '全部标记已读';
			case 'notifications.markAllAsReadSuccess': return '所有通知已标记为已读';
			case 'notifications.markAllAsReadFailed': return '全部标记已读失败';
			case 'notifications.markSelectedAsRead': return '标记选中项为已读';
			case 'notifications.markSelectedAsReadSuccess': return '选中的通知已标记为已读';
			case 'notifications.markSelectedAsReadFailed': return '标记选中项为已读失败';
			case 'notifications.markAsRead': return '标记已读';
			case 'notifications.markAsReadSuccess': return '已标记为已读';
			case 'notifications.markAsReadFailed': return '标记已读失败';
			case 'notifications.notificationTypeHelp': return '通知类型帮助';
			case 'notifications.dueToLackOfNotificationTypeDetails': return '通知类型的详细信息不足，目前支持的类型可能没有覆盖到您当前收到的消息';
			case 'notifications.helpUsImproveNotificationTypeSupport': return '如果您愿意帮助我们完善通知类型的支持';
			case 'notifications.helpUsImproveNotificationTypeSupportLongText': return '1. 📋 复制通知信息\n2. 🐞 前往项目仓库提交 issue\n\n⚠️ 注意：通知信息可能包含个人隐私，如果你不想公开，也可以通过邮件发送给项目作者。';
			case 'notifications.goToRepository': return '前往项目仓库';
			case 'notifications.copy': return '复制';
			case 'notifications.commentApproved': return '评论已通过审核';
			case 'notifications.repliedYourProfileComment': return '回复了您的个人主页评论';
			case 'notifications.repliedYourVideoComment': return '回复了您的视频评论';
			case 'notifications.kReplied': return '回复了您在';
			case 'notifications.kCommented': return '评论了您的';
			case 'notifications.kVideo': return '视频';
			case 'notifications.kGallery': return '图库';
			case 'notifications.kProfile': return '主页';
			case 'notifications.kThread': return '主题';
			case 'notifications.kPost': return '投稿';
			case 'notifications.kCommentSection': return '下的评论';
			case 'notifications.kApprovedComment': return '评论审核通过';
			case 'notifications.kApprovedVideo': return '视频审核通过';
			case 'notifications.kApprovedGallery': return '图库审核通过';
			case 'notifications.kApprovedThread': return '帖子审核通过';
			case 'notifications.kApprovedPost': return '投稿审核通过';
			case 'notifications.kUnknownType': return '未知通知类型';
			case 'conversation.errors.pleaseSelectAUser': return '请选择一个用户';
			case 'conversation.errors.pleaseEnterATitle': return '请输入标题';
			case 'conversation.errors.clickToSelectAUser': return '点击选择用户';
			case 'conversation.errors.loadFailedClickToRetry': return '加载失败,点击重试';
			case 'conversation.errors.loadFailed': return '加载失败';
			case 'conversation.errors.clickToRetry': return '点击重试';
			case 'conversation.errors.noMoreConversations': return '没有更多消息了';
			case 'conversation.conversation': return '会话';
			case 'conversation.startConversation': return '发起会话';
			case 'conversation.noConversation': return '暂无会话';
			case 'conversation.selectFromLeftListAndStartConversation': return '从左侧的会话列表选择一个对话开始聊天';
			case 'conversation.title': return '标题';
			case 'conversation.body': return '内容';
			case 'conversation.selectAUser': return '选择用户';
			case 'conversation.searchUsers': return '搜索用户...';
			case 'conversation.tmpNoConversions': return '暂无会话';
			case 'conversation.deleteThisMessage': return '删除此消息';
			case 'conversation.deleteThisMessageSubtitle': return '此操作不可撤销';
			case 'conversation.writeMessageHere': return '在此处输入消息';
			case 'conversation.sendMessage': return '发送消息';
			default: return null;
		}
	}
}

