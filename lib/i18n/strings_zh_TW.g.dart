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
class TranslationsZhTw implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhTw({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhTw _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonZhTw common = _TranslationsCommonZhTw._(_root);
	@override late final _TranslationsAuthZhTw auth = _TranslationsAuthZhTw._(_root);
	@override late final _TranslationsErrorsZhTw errors = _TranslationsErrorsZhTw._(_root);
	@override late final _TranslationsFriendsZhTw friends = _TranslationsFriendsZhTw._(_root);
	@override late final _TranslationsAuthorProfileZhTw authorProfile = _TranslationsAuthorProfileZhTw._(_root);
	@override late final _TranslationsFavoritesZhTw favorites = _TranslationsFavoritesZhTw._(_root);
	@override late final _TranslationsGalleryDetailZhTw galleryDetail = _TranslationsGalleryDetailZhTw._(_root);
	@override late final _TranslationsPlayListZhTw playList = _TranslationsPlayListZhTw._(_root);
	@override late final _TranslationsSearchZhTw search = _TranslationsSearchZhTw._(_root);
	@override late final _TranslationsMediaListZhTw mediaList = _TranslationsMediaListZhTw._(_root);
	@override late final _TranslationsSettingsZhTw settings = _TranslationsSettingsZhTw._(_root);
	@override late final _TranslationsSignInZhTw signIn = _TranslationsSignInZhTw._(_root);
	@override late final _TranslationsSubscriptionsZhTw subscriptions = _TranslationsSubscriptionsZhTw._(_root);
	@override late final _TranslationsVideoDetailZhTw videoDetail = _TranslationsVideoDetailZhTw._(_root);
	@override late final _TranslationsShareZhTw share = _TranslationsShareZhTw._(_root);
	@override late final _TranslationsMarkdownZhTw markdown = _TranslationsMarkdownZhTw._(_root);
	@override late final _TranslationsForumZhTw forum = _TranslationsForumZhTw._(_root);
	@override late final _TranslationsNotificationsZhTw notifications = _TranslationsNotificationsZhTw._(_root);
	@override late final _TranslationsConversationZhTw conversation = _TranslationsConversationZhTw._(_root);
}

// Path: common
class _TranslationsCommonZhTw implements TranslationsCommonEn {
	_TranslationsCommonZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Love Iwara';
	@override String get ok => '確定';
	@override String get cancel => '取消';
	@override String get save => '儲存';
	@override String get delete => '刪除';
	@override String get loading => '載入中...';
	@override String get privacyHint => '隱私內容，不與展示';
	@override String get latest => '最新';
	@override String get likesCount => '按讚數';
	@override String get viewsCount => '觀看次數';
	@override String get popular => '受歡迎的';
	@override String get trending => '趨勢';
	@override String get commentList => '評論列表';
	@override String get sendComment => '發表評論';
	@override String get send => '發表';
	@override String get retry => '重試';
	@override String get premium => '高級會員';
	@override String get follower => '粉絲';
	@override String get friend => '朋友';
	@override String get video => '影片';
	@override String get following => '追蹤中';
	@override String get expand => '展開';
	@override String get collapse => '收起';
	@override String get cancelFriendRequest => '取消申請';
	@override String get cancelSpecialFollow => '取消特別關注';
	@override String get addFriend => '加為朋友';
	@override String get removeFriend => '解除朋友';
	@override String get followed => '已追蹤';
	@override String get follow => '追蹤';
	@override String get unfollow => '取消追蹤';
	@override String get specialFollow => '特別關注';
	@override String get specialFollowed => '已特別關注';
	@override String get gallery => '圖庫';
	@override String get playlist => '播放清單';
	@override String get commentPostedSuccessfully => '評論發表成功';
	@override String get commentPostedFailed => '評論發表失敗';
	@override String get success => '成功';
	@override String get commentDeletedSuccessfully => '評論已刪除';
	@override String get commentUpdatedSuccessfully => '評論已更新';
	@override String totalComments({required Object count}) => '評論 ${count} 則';
	@override String get writeYourCommentHere => '請寫下你的評論...';
	@override String get tmpNoReplies => '暫無回覆';
	@override String get loadMore => '載入更多';
	@override String get noMoreDatas => '沒有更多資料了';
	@override String get selectTranslationLanguage => '選擇翻譯語言';
	@override String get translate => '翻譯';
	@override String get translateFailedPleaseTryAgainLater => '翻譯失敗，請稍後再試';
	@override String get translationResult => '翻譯結果';
	@override String get justNow => '剛剛';
	@override String minutesAgo({required Object num}) => '${num} 分鐘前';
	@override String hoursAgo({required Object num}) => '${num} 小時前';
	@override String daysAgo({required Object num}) => '${num} 天前';
	@override String editedAt({required Object num}) => '${num} 編輯';
	@override String get editComment => '編輯評論';
	@override String get commentUpdated => '評論已更新';
	@override String get replyComment => '回覆評論';
	@override String get reply => '回覆';
	@override String get edit => '編輯';
	@override String get unknownUser => '未知使用者';
	@override String get me => '我';
	@override String get author => '作者';
	@override String get admin => '管理員';
	@override String viewReplies({required Object num}) => '查看回覆 (${num})';
	@override String get hideReplies => '隱藏回覆';
	@override String get confirmDelete => '確認刪除';
	@override String get areYouSureYouWantToDeleteThisItem => '確定要刪除這筆資料嗎？';
	@override String get tmpNoComments => '暫無評論';
	@override String get refresh => '更新';
	@override String get back => '返回';
	@override String get tips => '提示';
	@override String get linkIsEmpty => '連結地址為空';
	@override String get linkCopiedToClipboard => '連結地址已複製到剪貼簿';
	@override String get imageCopiedToClipboard => '圖片已複製到剪貼簿';
	@override String get copyImageFailed => '複製圖片失敗';
	@override String get mobileSaveImageIsUnderDevelopment => '移動端的儲存圖片功能尚在開發中';
	@override String get imageSavedTo => '圖片已儲存至';
	@override String get saveImageFailed => '儲存圖片失敗';
	@override String get close => '關閉';
	@override String get more => '更多';
	@override String get moreFeaturesToBeDeveloped => '更多功能待開發';
	@override String get all => '全部';
	@override String selectedRecords({required Object num}) => '已選擇 ${num} 筆資料';
	@override String get cancelSelectAll => '取消全選';
	@override String get selectAll => '全選';
	@override String get exitEditMode => '退出編輯模式';
	@override String areYouSureYouWantToDeleteSelectedItems({required Object num}) => '確定要刪除選中的 ${num} 筆資料嗎？';
	@override String get searchHistoryRecords => '搜尋歷史紀錄...';
	@override String get settings => '設定';
	@override String get subscriptions => '訂閱';
	@override String videoCount({required Object num}) => '${num} 支影片';
	@override String get share => '分享';
	@override String get areYouSureYouWantToShareThisPlaylist => '要分享這個播放清單嗎？';
	@override String get editTitle => '編輯標題';
	@override String get editMode => '編輯模式';
	@override String get pleaseEnterNewTitle => '請輸入新標題';
	@override String get createPlayList => '創建播放清單';
	@override String get create => '創建';
	@override String get checkNetworkSettings => '檢查網路設定';
	@override String get general => '大眾';
	@override String get r18 => 'R18';
	@override String get sensitive => '敏感';
	@override String get year => '年份';
	@override String get tag => '標籤';
	@override String get private => '私密';
	@override String get noTitle => '無標題';
	@override String get search => '搜尋';
	@override String get noContent => '沒有內容哦';
	@override String get recording => '記錄中';
	@override String get paused => '已暫停';
	@override String get clear => '清除';
	@override String get user => '使用者';
	@override String get post => '投稿';
	@override String get seconds => '秒';
	@override String get comingSoon => '敬請期待';
	@override String get confirm => '確認';
	@override String get hour => '小時';
	@override String get minute => '分鐘';
	@override String get clickToRefresh => '點擊更新';
	@override String get history => '歷史紀錄';
	@override String get favorites => '最愛';
	@override String get friends => '朋友';
	@override String get playList => '播放清單';
	@override String get checkLicense => '查看授權';
	@override String get logout => '登出';
	@override String get fensi => '粉絲';
	@override String get accept => '接受';
	@override String get reject => '拒絕';
	@override String get clearAllHistory => '清空所有歷史紀錄';
	@override String get clearAllHistoryConfirm => '確定要清空所有歷史紀錄嗎？';
	@override String get followingList => '追蹤中列表';
	@override String get followersList => '粉絲列表';
	@override String get follows => '追蹤';
	@override String get fans => '粉絲';
	@override String get followsAndFans => '追蹤與粉絲';
	@override String get numViews => '觀看次數';
	@override String get updatedAt => '更新時間';
	@override String get publishedAt => '發布時間';
	@override String get externalVideo => '站外影片';
	@override String get originalText => '原文';
	@override String get showOriginalText => '顯示原始文本';
	@override String get showProcessedText => '顯示處理後文本';
	@override String get preview => '預覽';
	@override String get rules => '規則';
	@override String get agree => '同意';
	@override String get disagree => '不同意';
	@override String get agreeToRules => '同意規則';
	@override String get createPost => '創建投稿';
	@override String get title => '標題';
	@override String get enterTitle => '請輸入標題';
	@override String get content => '內容';
	@override String get enterContent => '請輸入內容';
	@override String get writeYourContentHere => '請輸入內容...';
	@override String get tagBlacklist => '黑名單標籤';
	@override String get noData => '沒有資料';
	@override String get tagLimit => '標籤上限';
	@override String get enableFloatingButtons => '啟用浮動按鈕';
	@override String get disableFloatingButtons => '禁用浮動按鈕';
	@override String get enabledFloatingButtons => '已啟用浮動按鈕';
	@override String get disabledFloatingButtons => '已禁用浮動按鈕';
	@override String get pendingCommentCount => '待審核評論';
}

// Path: auth
class _TranslationsAuthZhTw implements TranslationsAuthEn {
	_TranslationsAuthZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get login => '登入';
	@override String get logout => '登出';
	@override String get email => '電子郵件';
	@override String get password => '密碼';
	@override String get loginOrRegister => '登入 / 註冊';
	@override String get register => '註冊';
	@override String get pleaseEnterEmail => '請輸入電子郵件';
	@override String get pleaseEnterPassword => '請輸入密碼';
	@override String get passwordMustBeAtLeast6Characters => '密碼至少需要 6 位';
	@override String get pleaseEnterCaptcha => '請輸入驗證碼';
	@override String get captcha => '驗證碼';
	@override String get refreshCaptcha => '更新驗證碼';
	@override String get captchaNotLoaded => '無法載入驗證碼';
	@override String get loginSuccess => '登入成功';
	@override String get emailVerificationSent => '已發送郵件驗證指令';
	@override String get notLoggedIn => '尚未登入';
	@override String get clickToLogin => '點擊此處登入';
	@override String get logoutConfirmation => '你確定要登出嗎？';
	@override String get logoutSuccess => '登出成功';
	@override String get logoutFailed => '登出失敗';
	@override String get usernameOrEmail => '用戶名或電子郵件';
	@override String get pleaseEnterUsernameOrEmail => '請輸入用戶名或電子郵件';
}

// Path: errors
class _TranslationsErrorsZhTw implements TranslationsErrorsEn {
	_TranslationsErrorsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get error => '錯誤';
	@override String get required => '此項為必填';
	@override String get invalidEmail => '電子郵件格式錯誤';
	@override String get networkError => '網路錯誤，請重試';
	@override String get errorWhileFetching => '取得資料失敗';
	@override String get commentCanNotBeEmpty => '評論內容不能為空';
	@override String get errorWhileFetchingReplies => '取得回覆時出錯，請檢查網路連線';
	@override String get canNotFindCommentController => '無法找到評論控制器';
	@override String get errorWhileLoadingGallery => '載入圖庫時出錯';
	@override String get howCouldThereBeNoDataItCantBePossible => '啊？怎麼會沒有資料呢？出錯了吧 :<';
	@override String unsupportedImageFormat({required Object str}) => '不支援的圖片格式: ${str}';
	@override String get invalidGalleryId => '無效的圖庫ID';
	@override String get translationFailedPleaseTryAgainLater => '翻譯失敗，請稍後再試';
	@override String get errorOccurred => '發生錯誤，請稍後再試';
	@override String get errorOccurredWhileProcessingRequest => '處理請求時出錯';
	@override String get errorWhileFetchingDatas => '取得資料時出錯，請稍後再試';
	@override String get serviceNotInitialized => '服務未初始化';
	@override String get unknownType => '未知類型';
	@override String errorWhileOpeningLink({required Object link}) => '無法開啟連結: ${link}';
	@override String get invalidUrl => '無效的URL';
	@override String get failedToOperate => '操作失敗';
	@override String get permissionDenied => '權限不足';
	@override String get youDoNotHavePermissionToAccessThisResource => '您沒有權限訪問此資源';
	@override String get loginFailed => '登入失敗';
	@override String get unknownError => '未知錯誤';
	@override String get sessionExpired => '會話已過期';
	@override String get failedToFetchCaptcha => '獲取驗證碼失敗';
	@override String get emailAlreadyExists => '電子郵件已存在';
	@override String get invalidCaptcha => '無效的驗證碼';
	@override String get registerFailed => '註冊失敗';
	@override String get failedToFetchComments => '獲取評論失敗';
	@override String get failedToFetchImageDetail => '獲取圖庫詳情失敗';
	@override String get failedToFetchImageList => '獲取圖庫列表失敗';
	@override String get failedToFetchData => '獲取資料失敗';
	@override String get invalidParameter => '無效的參數';
	@override String get pleaseLoginFirst => '請先登入';
	@override String get errorWhileLoadingPost => '載入投稿內容時出錯';
	@override String get errorWhileLoadingPostDetail => '載入投稿詳情時出錯';
	@override String get invalidPostId => '無效的投稿ID';
	@override String get forceUpdateNotPermittedToGoBack => '目前處於強制更新狀態，無法返回';
	@override String get pleaseLoginAgain => '請重新登入';
	@override String get invalidLogin => '登入失敗，請檢查電子郵件和密碼';
	@override String get tooManyRequests => '請求過多，請稍後再試';
	@override String exceedsMaxLength({required Object max}) => '超出最大長度: ${max}';
	@override String get contentCanNotBeEmpty => '內容不能為空';
	@override String get titleCanNotBeEmpty => '標題不能為空';
	@override String get tooManyRequestsPleaseTryAgainLaterText => '請求過多，請稍後再試，剩餘時間';
	@override String remainingHours({required Object num}) => '${num}小時';
	@override String remainingMinutes({required Object num}) => '${num}分';
	@override String remainingSeconds({required Object num}) => '${num}秒';
	@override String tagLimitExceeded({required Object limit}) => '標籤上限超出，上限: ${limit}';
	@override String get failedToRefresh => '更新失敗';
}

// Path: friends
class _TranslationsFriendsZhTw implements TranslationsFriendsEn {
	_TranslationsFriendsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFriend => '點擊恢復朋友';
	@override String get friendsList => '朋友列表';
	@override String get friendRequests => '朋友請求';
	@override String get friendRequestsList => '朋友請求列表';
}

// Path: authorProfile
class _TranslationsAuthorProfileZhTw implements TranslationsAuthorProfileEn {
	_TranslationsAuthorProfileZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get noMoreDatas => '沒有更多資料了';
	@override String get userProfile => '使用者資料';
}

// Path: favorites
class _TranslationsFavoritesZhTw implements TranslationsFavoritesEn {
	_TranslationsFavoritesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFavorite => '點擊恢復最愛';
	@override String get myFavorites => '我的最愛';
}

// Path: galleryDetail
class _TranslationsGalleryDetailZhTw implements TranslationsGalleryDetailEn {
	_TranslationsGalleryDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get copyLink => '複製連結地址';
	@override String get copyImage => '複製圖片';
	@override String get saveAs => '另存為';
	@override String get saveToAlbum => '儲存到相簿';
	@override String get publishedAt => '發布時間';
	@override String get viewsCount => '觀看次數';
	@override String get imageLibraryFunctionIntroduction => '圖庫功能介紹';
	@override String get rightClickToSaveSingleImage => '右鍵儲存單張圖片';
	@override String get batchSave => '批次儲存';
	@override String get keyboardLeftAndRightToSwitch => '鍵盤左右控制切換';
	@override String get keyboardUpAndDownToZoom => '鍵盤上下控制縮放';
	@override String get mouseWheelToSwitch => '滑鼠滾輪控制切換';
	@override String get ctrlAndMouseWheelToZoom => 'CTRL + 滑鼠滾輪控制縮放';
	@override String get moreFeaturesToBeDiscovered => '更多功能待發掘...';
	@override String get authorOtherGalleries => '作者的其他圖庫';
	@override String get relatedGalleries => '相關圖庫';
	@override String get clickLeftAndRightEdgeToSwitchImage => '點擊左右邊緣以切換圖片';
}

// Path: playList
class _TranslationsPlayListZhTw implements TranslationsPlayListEn {
	_TranslationsPlayListZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get myPlayList => '我的播放清單';
	@override String get friendlyTips => '友情提示';
	@override String get dearUser => '親愛的使用者';
	@override String get iwaraPlayListSystemIsNotPerfectYet => 'iwara的播放清單系統目前還不太完善';
	@override String get notSupportSetCover => '不支援設定封面';
	@override String get notSupportDeleteList => '無法刪除播放清單';
	@override String get notSupportSetPrivate => '無法設為私密';
	@override String get yesCreateListWillAlwaysExistAndVisibleToEveryone => '沒錯...創建的播放清單會一直存在且對所有人可見';
	@override String get smallSuggestion => '小建議';
	@override String get useLikeToCollectContent => '如果您比較注重隱私，建議使用"按讚"功能來收藏內容';
	@override String get welcomeToDiscussOnGitHub => '如果你有其他建議或想法，歡迎來 GitHub 討論！';
	@override String get iUnderstand => '明白了';
	@override String get searchPlaylists => '搜尋播放清單...';
	@override String get newPlaylistName => '新播放清單名稱';
	@override String get createNewPlaylist => '創建新播放清單';
	@override String get videos => '影片';
}

// Path: search
class _TranslationsSearchZhTw implements TranslationsSearchEn {
	_TranslationsSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get searchTags => '搜尋標籤...';
	@override String get contentRating => '內容評級';
	@override String get removeTag => '移除標籤';
	@override String get pleaseEnterSearchContent => '請輸入搜尋內容';
	@override String get searchHistory => '搜尋歷史';
	@override String get searchSuggestion => '搜尋建議';
	@override String get usedTimes => '使用次數';
	@override String get lastUsed => '最後使用';
	@override String get noSearchHistoryRecords => '沒有搜尋歷史';
	@override String notSupportCurrentSearchType({required Object searchType}) => '目前尚未支援此搜尋類型 ${searchType}，敬請期待';
	@override String get searchResult => '搜尋結果';
	@override String unsupportedSearchType({required Object searchType}) => '不支援的搜尋類型: ${searchType}';
}

// Path: mediaList
class _TranslationsMediaListZhTw implements TranslationsMediaListEn {
	_TranslationsMediaListZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get personalIntroduction => '個人簡介';
}

// Path: settings
class _TranslationsSettingsZhTw implements TranslationsSettingsEn {
	_TranslationsSettingsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get searchConfig => '搜尋設定';
	@override String get thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain => '此設定將決定您之後播放影片時是否會沿用之前的設定。';
	@override String get playControl => '播放控制';
	@override String get fastForwardTime => '快進時間';
	@override String get fastForwardTimeMustBeAPositiveInteger => '快進時間必須是正整數。';
	@override String get rewindTime => '快退時間';
	@override String get rewindTimeMustBeAPositiveInteger => '快退時間必須是正整數。';
	@override String get longPressPlaybackSpeed => '長按播放倍速';
	@override String get longPressPlaybackSpeedMustBeAPositiveNumber => '長按播放倍速必須是正數。';
	@override String get repeat => '循環播放';
	@override String get renderVerticalVideoInVerticalScreen => '全螢幕播放時以直向模式呈現直向影片';
	@override String get thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen => '此設定將決定當您在全螢幕播放時，是否以直向模式呈現直向影片。';
	@override String get rememberVolume => '記住音量';
	@override String get thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain => '此設定將決定當您之後播放影片時，是否會保留先前的音量設定。';
	@override String get rememberBrightness => '記住亮度';
	@override String get thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain => '此設定將決定當您之後播放影片時，是否會保留先前的亮度設定。';
	@override String get playControlArea => '播放控制區域';
	@override String get leftAndRightControlAreaWidth => '左右控制區域寬度';
	@override String get thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer => '此設定將決定播放器左右兩側控制區域的寬度。';
	@override String get proxyAddressCannotBeEmpty => '代理伺服器地址不能為空。';
	@override String get invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort => '無效的代理伺服器地址格式，請使用 IP:端口 或 域名:端口 格式。';
	@override String get proxyNormalWork => '代理伺服器正常工作。';
	@override String testProxyFailedWithStatusCode({required Object code}) => '代理請求失敗，狀態碼: ${code}';
	@override String testProxyFailedWithException({required Object exception}) => '代理請求出錯: ${exception}';
	@override String get proxyConfig => '代理設定';
	@override String get thisIsHttpProxyAddress => '此為 HTTP 代理伺服器地址';
	@override String get checkProxy => '檢查代理';
	@override String get proxyAddress => '代理地址';
	@override String get pleaseEnterTheUrlOfTheProxyServerForExample1270018080 => '請輸入代理伺服器的 URL，例如 127.0.0.1:8080';
	@override String get enableProxy => '啟用代理';
	@override String get left => '左側';
	@override String get middle => '中間';
	@override String get right => '右側';
	@override String get playerSettings => '播放器設定';
	@override String get networkSettings => '網路設定';
	@override String get customizeYourPlaybackExperience => '自訂您的播放體驗';
	@override String get chooseYourFavoriteAppAppearance => '選擇您喜愛的應用程式外觀';
	@override String get configureYourProxyServer => '配置您的代理伺服器';
	@override String get settings => '設定';
	@override String get themeSettings => '主題設定';
	@override String get followSystem => '跟隨系統';
	@override String get lightMode => '淺色模式';
	@override String get darkMode => '深色模式';
	@override String get presetTheme => '預設主題';
	@override String get basicTheme => '基礎主題';
	@override String get needRestartToApply => '需要重啟應用以應用設定';
	@override String get themeNeedRestartDescription => '主題設定需要重啟應用以應用設定';
	@override String get about => '關於';
	@override String get currentVersion => '當前版本';
	@override String get latestVersion => '最新版本';
	@override String get checkForUpdates => '檢查更新';
	@override String get update => '更新';
	@override String get newVersionAvailable => '發現新版本';
	@override String get projectHome => '開源地址';
	@override String get release => '版本發布';
	@override String get issueReport => '問題回報';
	@override String get openSourceLicense => '開源許可';
	@override String get checkForUpdatesFailed => '檢查更新失敗，請稍後重試';
	@override String get autoCheckUpdate => '自動檢查更新';
	@override String get updateContent => '更新內容';
	@override String get releaseDate => '發布日期';
	@override String get ignoreThisVersion => '忽略此版本';
	@override String get minVersionUpdateRequired => '當前版本過低，請盡快更新';
	@override String get forceUpdateTip => '此版本為強制更新，請盡快更新到最新版本';
	@override String get viewChangelog => '查看更新日誌';
	@override String get alreadyLatestVersion => '已是最新版本';
	@override String get appSettings => '應用設定';
	@override String get configureYourAppSettings => '配置您的應用程式設定';
	@override String get history => '歷史記錄';
	@override String get autoRecordHistory => '自動記錄歷史記錄';
	@override String get autoRecordHistoryDesc => '自動記錄您觀看過的影片和圖庫等信息';
	@override String get showUnprocessedMarkdownText => '顯示未處理文本';
	@override String get showUnprocessedMarkdownTextDesc => '顯示Markdown的原始文本';
	@override String get markdown => 'Markdown';
	@override String get activeBackgroundPrivacyMode => '激活後台隱私模式';
	@override String get activeBackgroundPrivacyModeDesc => '激活後台隱私模式';
	@override String get privacy => '隱私';
	@override String get forum => '論壇';
	@override String get disableForumReplyQuote => '禁用論壇回覆引用';
	@override String get disableForumReplyQuoteDesc => '禁用論壇回覆時攜帶被回覆樓層資訊';
}

// Path: signIn
class _TranslationsSignInZhTw implements TranslationsSignInEn {
	_TranslationsSignInZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirst => '請先登入後再簽到';
	@override String get alreadySignedInToday => '您今天已經簽到過了！';
	@override String get youDidNotStickToTheSignIn => '您未能持續簽到。';
	@override String get signInSuccess => '簽到成功！';
	@override String get signInFailed => '簽到失敗，請稍後再試';
	@override String get consecutiveSignIns => '連續簽到天數';
	@override String get failureReason => '未能持續簽到的原因';
	@override String get selectDateRange => '選擇日期範圍';
	@override String get startDate => '開始日期';
	@override String get endDate => '結束日期';
	@override String get invalidDate => '日期格式錯誤';
	@override String get invalidDateRange => '日期範圍無效';
	@override String get errorFormatText => '日期格式錯誤';
	@override String get errorInvalidText => '日期範圍無效';
	@override String get errorInvalidRangeText => '日期範圍無效';
	@override String get dateRangeCantBeMoreThanOneYear => '日期範圍不能超過1年';
	@override String get signIn => '簽到';
	@override String get signInRecord => '簽到紀錄';
	@override String get totalSignIns => '總簽到次數';
	@override String get pleaseSelectSignInStatus => '請選擇簽到狀態';
}

// Path: subscriptions
class _TranslationsSubscriptionsZhTw implements TranslationsSubscriptionsEn {
	_TranslationsSubscriptionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirstToViewYourSubscriptions => '請登入以查看您的訂閱內容。';
}

// Path: videoDetail
class _TranslationsVideoDetailZhTw implements TranslationsVideoDetailEn {
	_TranslationsVideoDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get videoIdIsEmpty => '影片ID為空';
	@override String get videoInfoIsEmpty => '影片資訊為空';
	@override String get thisIsAPrivateVideo => '這是私密影片';
	@override String get getVideoInfoFailed => '取得影片資訊失敗，請稍後再試';
	@override String get noVideoSourceFound => '未找到對應的影片來源';
	@override String tagCopiedToClipboard({required Object tagId}) => '標籤 "${tagId}" 已複製到剪貼簿';
	@override String get errorLoadingVideo => '載入影片時出錯';
	@override String get play => '播放';
	@override String get pause => '暫停';
	@override String get exitAppFullscreen => '退出應用全螢幕';
	@override String get enterAppFullscreen => '應用全螢幕';
	@override String get exitSystemFullscreen => '退出系統全螢幕';
	@override String get enterSystemFullscreen => '系統全螢幕';
	@override String get seekTo => '跳轉到指定時間';
	@override String get switchResolution => '切換解析度';
	@override String get switchPlaybackSpeed => '切換播放倍速';
	@override String rewindSeconds({required Object num}) => '快退 ${num} 秒';
	@override String fastForwardSeconds({required Object num}) => '快進 ${num} 秒';
	@override String playbackSpeedIng({required Object rate}) => '正在以 ${rate} 倍速播放';
	@override String get brightness => '亮度';
	@override String get brightnessLowest => '亮度已最低';
	@override String get volume => '音量';
	@override String get volumeMuted => '音量已靜音';
	@override String get home => '主頁';
	@override String get videoPlayer => '影片播放器';
	@override String get videoPlayerInfo => '播放器資訊';
	@override String get moreSettings => '更多設定';
	@override String get videoPlayerFeatureInfo => '播放器功能介紹';
	@override String get autoRewind => '自動重播';
	@override String get rewindAndFastForward => '左右雙擊快進或快退';
	@override String get volumeAndBrightness => '左右滑動調整音量、亮度';
	@override String get centerAreaDoubleTapPauseOrPlay => '中央區域雙擊暫停或播放';
	@override String get showVerticalVideoInFullScreen => '在全螢幕時顯示直向影片';
	@override String get keepLastVolumeAndBrightness => '保持最後調整的音量、亮度';
	@override String get setProxy => '設定代理';
	@override String get moreFeaturesToBeDiscovered => '更多功能待發掘...';
	@override String get videoPlayerSettings => '播放器設定';
	@override String commentCount({required Object num}) => '評論 ${num} 則';
	@override String get writeYourCommentHere => '請寫下您的評論...';
	@override String get authorOtherVideos => '作者的其他影片';
	@override String get relatedVideos => '相關影片';
	@override String get privateVideo => '這是一個私密影片';
	@override String get externalVideo => '這是一個站外影片';
	@override String get openInBrowser => '在瀏覽器中打開';
	@override String get resourceDeleted => '這個影片貌似被刪除了 :/';
}

// Path: share
class _TranslationsShareZhTw implements TranslationsShareEn {
	_TranslationsShareZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get sharePlayList => '分享播放列表';
	@override String get wowDidYouSeeThis => '哇哦，你看过这个吗？';
	@override String get nameIs => '名字叫做';
	@override String get clickLinkToView => '點擊連結查看';
	@override String get iReallyLikeThis => '我真的是太喜歡這個了，你也來看看吧！';
	@override String get shareFailed => '分享失敗，請稍後再試';
	@override String get share => '分享';
}

// Path: markdown
class _TranslationsMarkdownZhTw implements TranslationsMarkdownEn {
	_TranslationsMarkdownZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get markdownSyntax => 'Markdown 語法';
	@override String get iwaraSpecialMarkdownSyntax => 'Iwara 專用語法';
	@override String get internalLink => '站內鏈接';
	@override String get supportAutoConvertLinkBelow => '支持自動轉換以下類型的鏈接：';
	@override String get convertLinkExample => '🎬 影片鏈接\n🖼️ 圖片鏈接\n👤 用戶鏈接\n📌 論壇鏈接\n🎵 播放列表鏈接\n💬 帖子鏈接';
	@override String get mentionUser => '提及用戶';
	@override String get mentionUserDescription => '輸入@後跟用戶名，將自動轉換為用戶鏈接';
	@override String get markdownBasicSyntax => 'Markdown 基本語法';
	@override String get paragraphAndLineBreak => '段落與換行';
	@override String get paragraphAndLineBreakDescription => '段落之間空一行，行末加兩個空格實現換行';
	@override String get paragraphAndLineBreakSyntax => '這是第一段文字\n\n這是第二段文字\n這一行後面加兩個空格  \n就能換行了';
	@override String get textStyle => '文本樣式';
	@override String get textStyleDescription => '使用特殊符號包圍文本来改變樣式';
	@override String get textStyleSyntax => '**粗體文本**\n*斜體文本*\n~~刪除線文本~~\n`代碼文本`';
	@override String get quote => '引用';
	@override String get quoteDescription => '使用 > 符號創建引用，多個 > 創建多級引用';
	@override String get quoteSyntax => '> 這是一級引用\n>> 這是二級引用';
	@override String get list => '列表';
	@override String get listDescription => '使用數字+點號創建有序列表，使用 - 創建無序列表';
	@override String get listSyntax => '1. 第一項\n2. 第二項\n\n- 無序項\n  - 子項\n  - 另一個子項';
	@override String get linkAndImage => '鏈接與圖片';
	@override String get linkAndImageDescription => '鏈接格式：[文字](URL)\n圖片格式：![描述](URL)';
	@override String linkAndImageSyntax({required Object link, required Object imgUrl}) => '[鏈接文字](${link})\n![圖片描述](${imgUrl})';
	@override String get title => '標題';
	@override String get titleDescription => '使用 # 號創建標題，數量表示級別';
	@override String get titleSyntax => '# 一級標題\n## 二級標題\n### 三級標題';
	@override String get separator => '分隔線';
	@override String get separatorDescription => '使用三個或更多 - 號創建分隔線';
	@override String get separatorSyntax => '---';
	@override String get syntax => '語法';
}

// Path: forum
class _TranslationsForumZhTw implements TranslationsForumEn {
	_TranslationsForumZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsForumErrorsZhTw errors = _TranslationsForumErrorsZhTw._(_root);
	@override String get createPost => '創建帖子';
	@override String get title => '標題';
	@override String get enterTitle => '輸入標題';
	@override String get content => '內容';
	@override String get enterContent => '輸入內容';
	@override String get writeYourContentHere => '在此輸入內容...';
	@override String get posts => '帖子';
	@override String get threads => '主題';
	@override String get forum => '論壇';
	@override String get createThread => '創建主題';
	@override String get selectCategory => '選擇分類';
	@override String cooldownRemaining({required Object minutes, required Object seconds}) => '冷卻剩餘時間 ${minutes} 分 ${seconds} 秒';
	@override late final _TranslationsForumGroupsZhTw groups = _TranslationsForumGroupsZhTw._(_root);
	@override late final _TranslationsForumLeafNamesZhTw leafNames = _TranslationsForumLeafNamesZhTw._(_root);
	@override late final _TranslationsForumLeafDescriptionsZhTw leafDescriptions = _TranslationsForumLeafDescriptionsZhTw._(_root);
	@override String get reply => '回覆';
	@override String get pendingReview => '審核中';
	@override String get editedAt => '編輯時間';
	@override String get copySuccess => '已複製到剪貼簿';
	@override String copySuccessForMessage({required Object str}) => '已複製到剪貼簿: ${str}';
	@override String get editReply => '編輯回覆';
	@override String get editTitle => '編輯標題';
	@override String get submit => '提交';
}

// Path: notifications
class _TranslationsNotificationsZhTw implements TranslationsNotificationsEn {
	_TranslationsNotificationsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsNotificationsErrorsZhTw errors = _TranslationsNotificationsErrorsZhTw._(_root);
	@override String get notifications => '通知';
	@override String get profile => '個人主頁';
	@override String get postedNewComment => '發表了評論';
	@override String get notifiedOn => '在您的個人主頁上發表了評論';
	@override String get inYour => '在您的';
	@override String get video => '影片';
	@override String get repliedYourVideoComment => '回覆了您的影片評論';
	@override String get copyInfoToClipboard => '複製通知信息到剪貼簿';
	@override String get copySuccess => '已複製到剪貼簿';
	@override String copySuccessForMessage({required Object str}) => '已複製到剪貼簿: ${str}';
	@override String get markAllAsRead => '全部標記已讀';
	@override String get markAllAsReadSuccess => '所有通知已標記為已讀';
	@override String get markAllAsReadFailed => '全部標記已讀失敗';
	@override String markAllAsReadFailedWithException({required Object exception}) => '全部標記已讀失敗: ${exception}';
	@override String get markSelectedAsRead => '標記已讀';
	@override String get markSelectedAsReadSuccess => '已標記為已讀';
	@override String get markSelectedAsReadFailed => '標記已讀失敗';
	@override String markSelectedAsReadFailedWithException({required Object exception}) => '標記已讀失敗: ${exception}';
	@override String get markAsRead => '標記已讀';
	@override String get markAsReadSuccess => '已標記為已讀';
	@override String get markAsReadFailed => '標記已讀失敗';
	@override String get notificationTypeHelp => '通知類型幫助';
	@override String get dueToLackOfNotificationTypeDetails => '通知類型的詳細信息不足，目前支持的類型可能沒有覆蓋到您當前收到的消息';
	@override String get helpUsImproveNotificationTypeSupport => '如果您願意幫助我們完善通知類型的支持：';
	@override String get helpUsImproveNotificationTypeSupportLongText => '1. 📋 複製通知信息\n2. 🐞 前往項目倉庫提交 issue\n\n⚠️ 注意：通知信息可能包含個人隱私，如果你不想公開，也可以通過郵件發送給項目作者。';
	@override String get goToRepository => '前往項目倉庫';
	@override String get copy => '複製';
	@override String get commentApproved => '評論已通過';
	@override String get repliedYourProfileComment => '回覆了您的個人主頁評論';
	@override String get kReplied => '回覆了您在';
	@override String get kCommented => '評論了您的';
	@override String get kVideo => '影片';
	@override String get kGallery => '圖庫';
	@override String get kProfile => '主頁';
	@override String get kThread => '主題';
	@override String get kPost => '投稿';
	@override String get kCommentSection => '下的評論';
	@override String get kApprovedComment => '評論已通過';
	@override String get kApprovedVideo => '影片已通過';
	@override String get kApprovedGallery => '圖庫已通過';
	@override String get kApprovedThread => '主題已審核';
	@override String get kApprovedPost => '投稿已審核';
	@override String get kUnknownType => '未知通知類型';
}

// Path: conversation
class _TranslationsConversationZhTw implements TranslationsConversationEn {
	_TranslationsConversationZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConversationErrorsZhTw errors = _TranslationsConversationErrorsZhTw._(_root);
	@override String get conversation => '會話';
	@override String get startConversation => '發起會話';
	@override String get noConversation => '暫無會話';
	@override String get selectFromLeftListAndStartConversation => '從左側列表選擇一個會話開始聊天';
	@override String get title => '標題';
	@override String get body => '內容';
	@override String get selectAUser => '選擇用戶';
	@override String get searchUsers => '搜索用戶...';
	@override String get tmpNoConversions => '暫無會話';
	@override String get deleteThisMessage => '刪除此消息';
	@override String get deleteThisMessageSubtitle => '此操作不可撤銷';
	@override String get writeMessageHere => '在此處輸入消息';
	@override String get sendMessage => '發送消息';
}

// Path: forum.errors
class _TranslationsForumErrorsZhTw implements TranslationsForumErrorsEn {
	_TranslationsForumErrorsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get pleaseSelectCategory => '請選擇分類';
	@override String get threadLocked => '該主題已鎖定，無法回覆';
}

// Path: forum.groups
class _TranslationsForumGroupsZhTw implements TranslationsForumGroupsEn {
	_TranslationsForumGroupsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get administration => '管理';
	@override String get global => '全球';
	@override String get chinese => '中文';
	@override String get japanese => '日語';
	@override String get korean => '韓語';
	@override String get other => '其他';
}

// Path: forum.leafNames
class _TranslationsForumLeafNamesZhTw implements TranslationsForumLeafNamesEn {
	_TranslationsForumLeafNamesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get announcements => '公告';
	@override String get feedback => '反饋';
	@override String get support => '幫助';
	@override String get general => '一般';
	@override String get guides => '指南';
	@override String get questions => '問題';
	@override String get requests => '請求';
	@override String get sharing => '分享';
	@override String get general_zh => '一般';
	@override String get questions_zh => '問題';
	@override String get requests_zh => '請求';
	@override String get support_zh => '幫助';
	@override String get general_ja => '一般';
	@override String get questions_ja => '問題';
	@override String get requests_ja => '請求';
	@override String get support_ja => '幫助';
	@override String get korean => '韓語';
	@override String get other => '其他';
}

// Path: forum.leafDescriptions
class _TranslationsForumLeafDescriptionsZhTw implements TranslationsForumLeafDescriptionsEn {
	_TranslationsForumLeafDescriptionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get announcements => '官方重要通知和公告';
	@override String get feedback => '對網站功能和服務的反饋';
	@override String get support => '幫助解決網站相關問題';
	@override String get general => '討論任何話題';
	@override String get guides => '分享你的經驗和教程';
	@override String get questions => '提出你的疑問';
	@override String get requests => '發布你的請求';
	@override String get sharing => '分享有趣的內容';
	@override String get general_zh => '討論任何話題';
	@override String get questions_zh => '提出你的疑問';
	@override String get requests_zh => '發布你的請求';
	@override String get support_zh => '幫助解決網站相關問題';
	@override String get general_ja => '討論任何話題';
	@override String get questions_ja => '提出你的疑問';
	@override String get requests_ja => '發布你的請求';
	@override String get support_ja => '幫助解決網站相關問題';
	@override String get korean => '韓語相關討論';
	@override String get other => '其他未分類的內容';
}

// Path: notifications.errors
class _TranslationsNotificationsErrorsZhTw implements TranslationsNotificationsErrorsEn {
	_TranslationsNotificationsErrorsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get unsupportedNotificationType => '暫不支持的通知類型';
	@override String get unknownUser => '未知用戶';
	@override String unsupportedNotificationTypeWithType({required Object type}) => '暫不支持的通知類型: ${type}';
	@override String get unknownNotificationType => '未知通知類型';
}

// Path: conversation.errors
class _TranslationsConversationErrorsZhTw implements TranslationsConversationErrorsEn {
	_TranslationsConversationErrorsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get pleaseSelectAUser => '請選擇一個用戶';
	@override String get pleaseEnterATitle => '請輸入標題';
	@override String get clickToSelectAUser => '點擊選擇用戶';
	@override String get loadFailedClickToRetry => '加載失敗,點擊重試';
	@override String get loadFailed => '加載失敗';
	@override String get clickToRetry => '點擊重試';
	@override String get noMoreConversations => '沒有更多消息了';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.appName': return 'Love Iwara';
			case 'common.ok': return '確定';
			case 'common.cancel': return '取消';
			case 'common.save': return '儲存';
			case 'common.delete': return '刪除';
			case 'common.loading': return '載入中...';
			case 'common.privacyHint': return '隱私內容，不與展示';
			case 'common.latest': return '最新';
			case 'common.likesCount': return '按讚數';
			case 'common.viewsCount': return '觀看次數';
			case 'common.popular': return '受歡迎的';
			case 'common.trending': return '趨勢';
			case 'common.commentList': return '評論列表';
			case 'common.sendComment': return '發表評論';
			case 'common.send': return '發表';
			case 'common.retry': return '重試';
			case 'common.premium': return '高級會員';
			case 'common.follower': return '粉絲';
			case 'common.friend': return '朋友';
			case 'common.video': return '影片';
			case 'common.following': return '追蹤中';
			case 'common.expand': return '展開';
			case 'common.collapse': return '收起';
			case 'common.cancelFriendRequest': return '取消申請';
			case 'common.cancelSpecialFollow': return '取消特別關注';
			case 'common.addFriend': return '加為朋友';
			case 'common.removeFriend': return '解除朋友';
			case 'common.followed': return '已追蹤';
			case 'common.follow': return '追蹤';
			case 'common.unfollow': return '取消追蹤';
			case 'common.specialFollow': return '特別關注';
			case 'common.specialFollowed': return '已特別關注';
			case 'common.gallery': return '圖庫';
			case 'common.playlist': return '播放清單';
			case 'common.commentPostedSuccessfully': return '評論發表成功';
			case 'common.commentPostedFailed': return '評論發表失敗';
			case 'common.success': return '成功';
			case 'common.commentDeletedSuccessfully': return '評論已刪除';
			case 'common.commentUpdatedSuccessfully': return '評論已更新';
			case 'common.totalComments': return ({required Object count}) => '評論 ${count} 則';
			case 'common.writeYourCommentHere': return '請寫下你的評論...';
			case 'common.tmpNoReplies': return '暫無回覆';
			case 'common.loadMore': return '載入更多';
			case 'common.noMoreDatas': return '沒有更多資料了';
			case 'common.selectTranslationLanguage': return '選擇翻譯語言';
			case 'common.translate': return '翻譯';
			case 'common.translateFailedPleaseTryAgainLater': return '翻譯失敗，請稍後再試';
			case 'common.translationResult': return '翻譯結果';
			case 'common.justNow': return '剛剛';
			case 'common.minutesAgo': return ({required Object num}) => '${num} 分鐘前';
			case 'common.hoursAgo': return ({required Object num}) => '${num} 小時前';
			case 'common.daysAgo': return ({required Object num}) => '${num} 天前';
			case 'common.editedAt': return ({required Object num}) => '${num} 編輯';
			case 'common.editComment': return '編輯評論';
			case 'common.commentUpdated': return '評論已更新';
			case 'common.replyComment': return '回覆評論';
			case 'common.reply': return '回覆';
			case 'common.edit': return '編輯';
			case 'common.unknownUser': return '未知使用者';
			case 'common.me': return '我';
			case 'common.author': return '作者';
			case 'common.admin': return '管理員';
			case 'common.viewReplies': return ({required Object num}) => '查看回覆 (${num})';
			case 'common.hideReplies': return '隱藏回覆';
			case 'common.confirmDelete': return '確認刪除';
			case 'common.areYouSureYouWantToDeleteThisItem': return '確定要刪除這筆資料嗎？';
			case 'common.tmpNoComments': return '暫無評論';
			case 'common.refresh': return '更新';
			case 'common.back': return '返回';
			case 'common.tips': return '提示';
			case 'common.linkIsEmpty': return '連結地址為空';
			case 'common.linkCopiedToClipboard': return '連結地址已複製到剪貼簿';
			case 'common.imageCopiedToClipboard': return '圖片已複製到剪貼簿';
			case 'common.copyImageFailed': return '複製圖片失敗';
			case 'common.mobileSaveImageIsUnderDevelopment': return '移動端的儲存圖片功能尚在開發中';
			case 'common.imageSavedTo': return '圖片已儲存至';
			case 'common.saveImageFailed': return '儲存圖片失敗';
			case 'common.close': return '關閉';
			case 'common.more': return '更多';
			case 'common.moreFeaturesToBeDeveloped': return '更多功能待開發';
			case 'common.all': return '全部';
			case 'common.selectedRecords': return ({required Object num}) => '已選擇 ${num} 筆資料';
			case 'common.cancelSelectAll': return '取消全選';
			case 'common.selectAll': return '全選';
			case 'common.exitEditMode': return '退出編輯模式';
			case 'common.areYouSureYouWantToDeleteSelectedItems': return ({required Object num}) => '確定要刪除選中的 ${num} 筆資料嗎？';
			case 'common.searchHistoryRecords': return '搜尋歷史紀錄...';
			case 'common.settings': return '設定';
			case 'common.subscriptions': return '訂閱';
			case 'common.videoCount': return ({required Object num}) => '${num} 支影片';
			case 'common.share': return '分享';
			case 'common.areYouSureYouWantToShareThisPlaylist': return '要分享這個播放清單嗎？';
			case 'common.editTitle': return '編輯標題';
			case 'common.editMode': return '編輯模式';
			case 'common.pleaseEnterNewTitle': return '請輸入新標題';
			case 'common.createPlayList': return '創建播放清單';
			case 'common.create': return '創建';
			case 'common.checkNetworkSettings': return '檢查網路設定';
			case 'common.general': return '大眾';
			case 'common.r18': return 'R18';
			case 'common.sensitive': return '敏感';
			case 'common.year': return '年份';
			case 'common.tag': return '標籤';
			case 'common.private': return '私密';
			case 'common.noTitle': return '無標題';
			case 'common.search': return '搜尋';
			case 'common.noContent': return '沒有內容哦';
			case 'common.recording': return '記錄中';
			case 'common.paused': return '已暫停';
			case 'common.clear': return '清除';
			case 'common.user': return '使用者';
			case 'common.post': return '投稿';
			case 'common.seconds': return '秒';
			case 'common.comingSoon': return '敬請期待';
			case 'common.confirm': return '確認';
			case 'common.hour': return '小時';
			case 'common.minute': return '分鐘';
			case 'common.clickToRefresh': return '點擊更新';
			case 'common.history': return '歷史紀錄';
			case 'common.favorites': return '最愛';
			case 'common.friends': return '朋友';
			case 'common.playList': return '播放清單';
			case 'common.checkLicense': return '查看授權';
			case 'common.logout': return '登出';
			case 'common.fensi': return '粉絲';
			case 'common.accept': return '接受';
			case 'common.reject': return '拒絕';
			case 'common.clearAllHistory': return '清空所有歷史紀錄';
			case 'common.clearAllHistoryConfirm': return '確定要清空所有歷史紀錄嗎？';
			case 'common.followingList': return '追蹤中列表';
			case 'common.followersList': return '粉絲列表';
			case 'common.follows': return '追蹤';
			case 'common.fans': return '粉絲';
			case 'common.followsAndFans': return '追蹤與粉絲';
			case 'common.numViews': return '觀看次數';
			case 'common.updatedAt': return '更新時間';
			case 'common.publishedAt': return '發布時間';
			case 'common.externalVideo': return '站外影片';
			case 'common.originalText': return '原文';
			case 'common.showOriginalText': return '顯示原始文本';
			case 'common.showProcessedText': return '顯示處理後文本';
			case 'common.preview': return '預覽';
			case 'common.rules': return '規則';
			case 'common.agree': return '同意';
			case 'common.disagree': return '不同意';
			case 'common.agreeToRules': return '同意規則';
			case 'common.createPost': return '創建投稿';
			case 'common.title': return '標題';
			case 'common.enterTitle': return '請輸入標題';
			case 'common.content': return '內容';
			case 'common.enterContent': return '請輸入內容';
			case 'common.writeYourContentHere': return '請輸入內容...';
			case 'common.tagBlacklist': return '黑名單標籤';
			case 'common.noData': return '沒有資料';
			case 'common.tagLimit': return '標籤上限';
			case 'common.enableFloatingButtons': return '啟用浮動按鈕';
			case 'common.disableFloatingButtons': return '禁用浮動按鈕';
			case 'common.enabledFloatingButtons': return '已啟用浮動按鈕';
			case 'common.disabledFloatingButtons': return '已禁用浮動按鈕';
			case 'common.pendingCommentCount': return '待審核評論';
			case 'auth.login': return '登入';
			case 'auth.logout': return '登出';
			case 'auth.email': return '電子郵件';
			case 'auth.password': return '密碼';
			case 'auth.loginOrRegister': return '登入 / 註冊';
			case 'auth.register': return '註冊';
			case 'auth.pleaseEnterEmail': return '請輸入電子郵件';
			case 'auth.pleaseEnterPassword': return '請輸入密碼';
			case 'auth.passwordMustBeAtLeast6Characters': return '密碼至少需要 6 位';
			case 'auth.pleaseEnterCaptcha': return '請輸入驗證碼';
			case 'auth.captcha': return '驗證碼';
			case 'auth.refreshCaptcha': return '更新驗證碼';
			case 'auth.captchaNotLoaded': return '無法載入驗證碼';
			case 'auth.loginSuccess': return '登入成功';
			case 'auth.emailVerificationSent': return '已發送郵件驗證指令';
			case 'auth.notLoggedIn': return '尚未登入';
			case 'auth.clickToLogin': return '點擊此處登入';
			case 'auth.logoutConfirmation': return '你確定要登出嗎？';
			case 'auth.logoutSuccess': return '登出成功';
			case 'auth.logoutFailed': return '登出失敗';
			case 'auth.usernameOrEmail': return '用戶名或電子郵件';
			case 'auth.pleaseEnterUsernameOrEmail': return '請輸入用戶名或電子郵件';
			case 'errors.error': return '錯誤';
			case 'errors.required': return '此項為必填';
			case 'errors.invalidEmail': return '電子郵件格式錯誤';
			case 'errors.networkError': return '網路錯誤，請重試';
			case 'errors.errorWhileFetching': return '取得資料失敗';
			case 'errors.commentCanNotBeEmpty': return '評論內容不能為空';
			case 'errors.errorWhileFetchingReplies': return '取得回覆時出錯，請檢查網路連線';
			case 'errors.canNotFindCommentController': return '無法找到評論控制器';
			case 'errors.errorWhileLoadingGallery': return '載入圖庫時出錯';
			case 'errors.howCouldThereBeNoDataItCantBePossible': return '啊？怎麼會沒有資料呢？出錯了吧 :<';
			case 'errors.unsupportedImageFormat': return ({required Object str}) => '不支援的圖片格式: ${str}';
			case 'errors.invalidGalleryId': return '無效的圖庫ID';
			case 'errors.translationFailedPleaseTryAgainLater': return '翻譯失敗，請稍後再試';
			case 'errors.errorOccurred': return '發生錯誤，請稍後再試';
			case 'errors.errorOccurredWhileProcessingRequest': return '處理請求時出錯';
			case 'errors.errorWhileFetchingDatas': return '取得資料時出錯，請稍後再試';
			case 'errors.serviceNotInitialized': return '服務未初始化';
			case 'errors.unknownType': return '未知類型';
			case 'errors.errorWhileOpeningLink': return ({required Object link}) => '無法開啟連結: ${link}';
			case 'errors.invalidUrl': return '無效的URL';
			case 'errors.failedToOperate': return '操作失敗';
			case 'errors.permissionDenied': return '權限不足';
			case 'errors.youDoNotHavePermissionToAccessThisResource': return '您沒有權限訪問此資源';
			case 'errors.loginFailed': return '登入失敗';
			case 'errors.unknownError': return '未知錯誤';
			case 'errors.sessionExpired': return '會話已過期';
			case 'errors.failedToFetchCaptcha': return '獲取驗證碼失敗';
			case 'errors.emailAlreadyExists': return '電子郵件已存在';
			case 'errors.invalidCaptcha': return '無效的驗證碼';
			case 'errors.registerFailed': return '註冊失敗';
			case 'errors.failedToFetchComments': return '獲取評論失敗';
			case 'errors.failedToFetchImageDetail': return '獲取圖庫詳情失敗';
			case 'errors.failedToFetchImageList': return '獲取圖庫列表失敗';
			case 'errors.failedToFetchData': return '獲取資料失敗';
			case 'errors.invalidParameter': return '無效的參數';
			case 'errors.pleaseLoginFirst': return '請先登入';
			case 'errors.errorWhileLoadingPost': return '載入投稿內容時出錯';
			case 'errors.errorWhileLoadingPostDetail': return '載入投稿詳情時出錯';
			case 'errors.invalidPostId': return '無效的投稿ID';
			case 'errors.forceUpdateNotPermittedToGoBack': return '目前處於強制更新狀態，無法返回';
			case 'errors.pleaseLoginAgain': return '請重新登入';
			case 'errors.invalidLogin': return '登入失敗，請檢查電子郵件和密碼';
			case 'errors.tooManyRequests': return '請求過多，請稍後再試';
			case 'errors.exceedsMaxLength': return ({required Object max}) => '超出最大長度: ${max}';
			case 'errors.contentCanNotBeEmpty': return '內容不能為空';
			case 'errors.titleCanNotBeEmpty': return '標題不能為空';
			case 'errors.tooManyRequestsPleaseTryAgainLaterText': return '請求過多，請稍後再試，剩餘時間';
			case 'errors.remainingHours': return ({required Object num}) => '${num}小時';
			case 'errors.remainingMinutes': return ({required Object num}) => '${num}分';
			case 'errors.remainingSeconds': return ({required Object num}) => '${num}秒';
			case 'errors.tagLimitExceeded': return ({required Object limit}) => '標籤上限超出，上限: ${limit}';
			case 'errors.failedToRefresh': return '更新失敗';
			case 'friends.clickToRestoreFriend': return '點擊恢復朋友';
			case 'friends.friendsList': return '朋友列表';
			case 'friends.friendRequests': return '朋友請求';
			case 'friends.friendRequestsList': return '朋友請求列表';
			case 'authorProfile.noMoreDatas': return '沒有更多資料了';
			case 'authorProfile.userProfile': return '使用者資料';
			case 'favorites.clickToRestoreFavorite': return '點擊恢復最愛';
			case 'favorites.myFavorites': return '我的最愛';
			case 'galleryDetail.copyLink': return '複製連結地址';
			case 'galleryDetail.copyImage': return '複製圖片';
			case 'galleryDetail.saveAs': return '另存為';
			case 'galleryDetail.saveToAlbum': return '儲存到相簿';
			case 'galleryDetail.publishedAt': return '發布時間';
			case 'galleryDetail.viewsCount': return '觀看次數';
			case 'galleryDetail.imageLibraryFunctionIntroduction': return '圖庫功能介紹';
			case 'galleryDetail.rightClickToSaveSingleImage': return '右鍵儲存單張圖片';
			case 'galleryDetail.batchSave': return '批次儲存';
			case 'galleryDetail.keyboardLeftAndRightToSwitch': return '鍵盤左右控制切換';
			case 'galleryDetail.keyboardUpAndDownToZoom': return '鍵盤上下控制縮放';
			case 'galleryDetail.mouseWheelToSwitch': return '滑鼠滾輪控制切換';
			case 'galleryDetail.ctrlAndMouseWheelToZoom': return 'CTRL + 滑鼠滾輪控制縮放';
			case 'galleryDetail.moreFeaturesToBeDiscovered': return '更多功能待發掘...';
			case 'galleryDetail.authorOtherGalleries': return '作者的其他圖庫';
			case 'galleryDetail.relatedGalleries': return '相關圖庫';
			case 'galleryDetail.clickLeftAndRightEdgeToSwitchImage': return '點擊左右邊緣以切換圖片';
			case 'playList.myPlayList': return '我的播放清單';
			case 'playList.friendlyTips': return '友情提示';
			case 'playList.dearUser': return '親愛的使用者';
			case 'playList.iwaraPlayListSystemIsNotPerfectYet': return 'iwara的播放清單系統目前還不太完善';
			case 'playList.notSupportSetCover': return '不支援設定封面';
			case 'playList.notSupportDeleteList': return '無法刪除播放清單';
			case 'playList.notSupportSetPrivate': return '無法設為私密';
			case 'playList.yesCreateListWillAlwaysExistAndVisibleToEveryone': return '沒錯...創建的播放清單會一直存在且對所有人可見';
			case 'playList.smallSuggestion': return '小建議';
			case 'playList.useLikeToCollectContent': return '如果您比較注重隱私，建議使用"按讚"功能來收藏內容';
			case 'playList.welcomeToDiscussOnGitHub': return '如果你有其他建議或想法，歡迎來 GitHub 討論！';
			case 'playList.iUnderstand': return '明白了';
			case 'playList.searchPlaylists': return '搜尋播放清單...';
			case 'playList.newPlaylistName': return '新播放清單名稱';
			case 'playList.createNewPlaylist': return '創建新播放清單';
			case 'playList.videos': return '影片';
			case 'search.searchTags': return '搜尋標籤...';
			case 'search.contentRating': return '內容評級';
			case 'search.removeTag': return '移除標籤';
			case 'search.pleaseEnterSearchContent': return '請輸入搜尋內容';
			case 'search.searchHistory': return '搜尋歷史';
			case 'search.searchSuggestion': return '搜尋建議';
			case 'search.usedTimes': return '使用次數';
			case 'search.lastUsed': return '最後使用';
			case 'search.noSearchHistoryRecords': return '沒有搜尋歷史';
			case 'search.notSupportCurrentSearchType': return ({required Object searchType}) => '目前尚未支援此搜尋類型 ${searchType}，敬請期待';
			case 'search.searchResult': return '搜尋結果';
			case 'search.unsupportedSearchType': return ({required Object searchType}) => '不支援的搜尋類型: ${searchType}';
			case 'mediaList.personalIntroduction': return '個人簡介';
			case 'settings.searchConfig': return '搜尋設定';
			case 'settings.thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain': return '此設定將決定您之後播放影片時是否會沿用之前的設定。';
			case 'settings.playControl': return '播放控制';
			case 'settings.fastForwardTime': return '快進時間';
			case 'settings.fastForwardTimeMustBeAPositiveInteger': return '快進時間必須是正整數。';
			case 'settings.rewindTime': return '快退時間';
			case 'settings.rewindTimeMustBeAPositiveInteger': return '快退時間必須是正整數。';
			case 'settings.longPressPlaybackSpeed': return '長按播放倍速';
			case 'settings.longPressPlaybackSpeedMustBeAPositiveNumber': return '長按播放倍速必須是正數。';
			case 'settings.repeat': return '循環播放';
			case 'settings.renderVerticalVideoInVerticalScreen': return '全螢幕播放時以直向模式呈現直向影片';
			case 'settings.thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen': return '此設定將決定當您在全螢幕播放時，是否以直向模式呈現直向影片。';
			case 'settings.rememberVolume': return '記住音量';
			case 'settings.thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain': return '此設定將決定當您之後播放影片時，是否會保留先前的音量設定。';
			case 'settings.rememberBrightness': return '記住亮度';
			case 'settings.thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain': return '此設定將決定當您之後播放影片時，是否會保留先前的亮度設定。';
			case 'settings.playControlArea': return '播放控制區域';
			case 'settings.leftAndRightControlAreaWidth': return '左右控制區域寬度';
			case 'settings.thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer': return '此設定將決定播放器左右兩側控制區域的寬度。';
			case 'settings.proxyAddressCannotBeEmpty': return '代理伺服器地址不能為空。';
			case 'settings.invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort': return '無效的代理伺服器地址格式，請使用 IP:端口 或 域名:端口 格式。';
			case 'settings.proxyNormalWork': return '代理伺服器正常工作。';
			case 'settings.testProxyFailedWithStatusCode': return ({required Object code}) => '代理請求失敗，狀態碼: ${code}';
			case 'settings.testProxyFailedWithException': return ({required Object exception}) => '代理請求出錯: ${exception}';
			case 'settings.proxyConfig': return '代理設定';
			case 'settings.thisIsHttpProxyAddress': return '此為 HTTP 代理伺服器地址';
			case 'settings.checkProxy': return '檢查代理';
			case 'settings.proxyAddress': return '代理地址';
			case 'settings.pleaseEnterTheUrlOfTheProxyServerForExample1270018080': return '請輸入代理伺服器的 URL，例如 127.0.0.1:8080';
			case 'settings.enableProxy': return '啟用代理';
			case 'settings.left': return '左側';
			case 'settings.middle': return '中間';
			case 'settings.right': return '右側';
			case 'settings.playerSettings': return '播放器設定';
			case 'settings.networkSettings': return '網路設定';
			case 'settings.customizeYourPlaybackExperience': return '自訂您的播放體驗';
			case 'settings.chooseYourFavoriteAppAppearance': return '選擇您喜愛的應用程式外觀';
			case 'settings.configureYourProxyServer': return '配置您的代理伺服器';
			case 'settings.settings': return '設定';
			case 'settings.themeSettings': return '主題設定';
			case 'settings.followSystem': return '跟隨系統';
			case 'settings.lightMode': return '淺色模式';
			case 'settings.darkMode': return '深色模式';
			case 'settings.presetTheme': return '預設主題';
			case 'settings.basicTheme': return '基礎主題';
			case 'settings.needRestartToApply': return '需要重啟應用以應用設定';
			case 'settings.themeNeedRestartDescription': return '主題設定需要重啟應用以應用設定';
			case 'settings.about': return '關於';
			case 'settings.currentVersion': return '當前版本';
			case 'settings.latestVersion': return '最新版本';
			case 'settings.checkForUpdates': return '檢查更新';
			case 'settings.update': return '更新';
			case 'settings.newVersionAvailable': return '發現新版本';
			case 'settings.projectHome': return '開源地址';
			case 'settings.release': return '版本發布';
			case 'settings.issueReport': return '問題回報';
			case 'settings.openSourceLicense': return '開源許可';
			case 'settings.checkForUpdatesFailed': return '檢查更新失敗，請稍後重試';
			case 'settings.autoCheckUpdate': return '自動檢查更新';
			case 'settings.updateContent': return '更新內容';
			case 'settings.releaseDate': return '發布日期';
			case 'settings.ignoreThisVersion': return '忽略此版本';
			case 'settings.minVersionUpdateRequired': return '當前版本過低，請盡快更新';
			case 'settings.forceUpdateTip': return '此版本為強制更新，請盡快更新到最新版本';
			case 'settings.viewChangelog': return '查看更新日誌';
			case 'settings.alreadyLatestVersion': return '已是最新版本';
			case 'settings.appSettings': return '應用設定';
			case 'settings.configureYourAppSettings': return '配置您的應用程式設定';
			case 'settings.history': return '歷史記錄';
			case 'settings.autoRecordHistory': return '自動記錄歷史記錄';
			case 'settings.autoRecordHistoryDesc': return '自動記錄您觀看過的影片和圖庫等信息';
			case 'settings.showUnprocessedMarkdownText': return '顯示未處理文本';
			case 'settings.showUnprocessedMarkdownTextDesc': return '顯示Markdown的原始文本';
			case 'settings.markdown': return 'Markdown';
			case 'settings.activeBackgroundPrivacyMode': return '激活後台隱私模式';
			case 'settings.activeBackgroundPrivacyModeDesc': return '激活後台隱私模式';
			case 'settings.privacy': return '隱私';
			case 'settings.forum': return '論壇';
			case 'settings.disableForumReplyQuote': return '禁用論壇回覆引用';
			case 'settings.disableForumReplyQuoteDesc': return '禁用論壇回覆時攜帶被回覆樓層資訊';
			case 'signIn.pleaseLoginFirst': return '請先登入後再簽到';
			case 'signIn.alreadySignedInToday': return '您今天已經簽到過了！';
			case 'signIn.youDidNotStickToTheSignIn': return '您未能持續簽到。';
			case 'signIn.signInSuccess': return '簽到成功！';
			case 'signIn.signInFailed': return '簽到失敗，請稍後再試';
			case 'signIn.consecutiveSignIns': return '連續簽到天數';
			case 'signIn.failureReason': return '未能持續簽到的原因';
			case 'signIn.selectDateRange': return '選擇日期範圍';
			case 'signIn.startDate': return '開始日期';
			case 'signIn.endDate': return '結束日期';
			case 'signIn.invalidDate': return '日期格式錯誤';
			case 'signIn.invalidDateRange': return '日期範圍無效';
			case 'signIn.errorFormatText': return '日期格式錯誤';
			case 'signIn.errorInvalidText': return '日期範圍無效';
			case 'signIn.errorInvalidRangeText': return '日期範圍無效';
			case 'signIn.dateRangeCantBeMoreThanOneYear': return '日期範圍不能超過1年';
			case 'signIn.signIn': return '簽到';
			case 'signIn.signInRecord': return '簽到紀錄';
			case 'signIn.totalSignIns': return '總簽到次數';
			case 'signIn.pleaseSelectSignInStatus': return '請選擇簽到狀態';
			case 'subscriptions.pleaseLoginFirstToViewYourSubscriptions': return '請登入以查看您的訂閱內容。';
			case 'videoDetail.videoIdIsEmpty': return '影片ID為空';
			case 'videoDetail.videoInfoIsEmpty': return '影片資訊為空';
			case 'videoDetail.thisIsAPrivateVideo': return '這是私密影片';
			case 'videoDetail.getVideoInfoFailed': return '取得影片資訊失敗，請稍後再試';
			case 'videoDetail.noVideoSourceFound': return '未找到對應的影片來源';
			case 'videoDetail.tagCopiedToClipboard': return ({required Object tagId}) => '標籤 "${tagId}" 已複製到剪貼簿';
			case 'videoDetail.errorLoadingVideo': return '載入影片時出錯';
			case 'videoDetail.play': return '播放';
			case 'videoDetail.pause': return '暫停';
			case 'videoDetail.exitAppFullscreen': return '退出應用全螢幕';
			case 'videoDetail.enterAppFullscreen': return '應用全螢幕';
			case 'videoDetail.exitSystemFullscreen': return '退出系統全螢幕';
			case 'videoDetail.enterSystemFullscreen': return '系統全螢幕';
			case 'videoDetail.seekTo': return '跳轉到指定時間';
			case 'videoDetail.switchResolution': return '切換解析度';
			case 'videoDetail.switchPlaybackSpeed': return '切換播放倍速';
			case 'videoDetail.rewindSeconds': return ({required Object num}) => '快退 ${num} 秒';
			case 'videoDetail.fastForwardSeconds': return ({required Object num}) => '快進 ${num} 秒';
			case 'videoDetail.playbackSpeedIng': return ({required Object rate}) => '正在以 ${rate} 倍速播放';
			case 'videoDetail.brightness': return '亮度';
			case 'videoDetail.brightnessLowest': return '亮度已最低';
			case 'videoDetail.volume': return '音量';
			case 'videoDetail.volumeMuted': return '音量已靜音';
			case 'videoDetail.home': return '主頁';
			case 'videoDetail.videoPlayer': return '影片播放器';
			case 'videoDetail.videoPlayerInfo': return '播放器資訊';
			case 'videoDetail.moreSettings': return '更多設定';
			case 'videoDetail.videoPlayerFeatureInfo': return '播放器功能介紹';
			case 'videoDetail.autoRewind': return '自動重播';
			case 'videoDetail.rewindAndFastForward': return '左右雙擊快進或快退';
			case 'videoDetail.volumeAndBrightness': return '左右滑動調整音量、亮度';
			case 'videoDetail.centerAreaDoubleTapPauseOrPlay': return '中央區域雙擊暫停或播放';
			case 'videoDetail.showVerticalVideoInFullScreen': return '在全螢幕時顯示直向影片';
			case 'videoDetail.keepLastVolumeAndBrightness': return '保持最後調整的音量、亮度';
			case 'videoDetail.setProxy': return '設定代理';
			case 'videoDetail.moreFeaturesToBeDiscovered': return '更多功能待發掘...';
			case 'videoDetail.videoPlayerSettings': return '播放器設定';
			case 'videoDetail.commentCount': return ({required Object num}) => '評論 ${num} 則';
			case 'videoDetail.writeYourCommentHere': return '請寫下您的評論...';
			case 'videoDetail.authorOtherVideos': return '作者的其他影片';
			case 'videoDetail.relatedVideos': return '相關影片';
			case 'videoDetail.privateVideo': return '這是一個私密影片';
			case 'videoDetail.externalVideo': return '這是一個站外影片';
			case 'videoDetail.openInBrowser': return '在瀏覽器中打開';
			case 'videoDetail.resourceDeleted': return '這個影片貌似被刪除了 :/';
			case 'share.sharePlayList': return '分享播放列表';
			case 'share.wowDidYouSeeThis': return '哇哦，你看过这个吗？';
			case 'share.nameIs': return '名字叫做';
			case 'share.clickLinkToView': return '點擊連結查看';
			case 'share.iReallyLikeThis': return '我真的是太喜歡這個了，你也來看看吧！';
			case 'share.shareFailed': return '分享失敗，請稍後再試';
			case 'share.share': return '分享';
			case 'markdown.markdownSyntax': return 'Markdown 語法';
			case 'markdown.iwaraSpecialMarkdownSyntax': return 'Iwara 專用語法';
			case 'markdown.internalLink': return '站內鏈接';
			case 'markdown.supportAutoConvertLinkBelow': return '支持自動轉換以下類型的鏈接：';
			case 'markdown.convertLinkExample': return '🎬 影片鏈接\n🖼️ 圖片鏈接\n👤 用戶鏈接\n📌 論壇鏈接\n🎵 播放列表鏈接\n💬 帖子鏈接';
			case 'markdown.mentionUser': return '提及用戶';
			case 'markdown.mentionUserDescription': return '輸入@後跟用戶名，將自動轉換為用戶鏈接';
			case 'markdown.markdownBasicSyntax': return 'Markdown 基本語法';
			case 'markdown.paragraphAndLineBreak': return '段落與換行';
			case 'markdown.paragraphAndLineBreakDescription': return '段落之間空一行，行末加兩個空格實現換行';
			case 'markdown.paragraphAndLineBreakSyntax': return '這是第一段文字\n\n這是第二段文字\n這一行後面加兩個空格  \n就能換行了';
			case 'markdown.textStyle': return '文本樣式';
			case 'markdown.textStyleDescription': return '使用特殊符號包圍文本来改變樣式';
			case 'markdown.textStyleSyntax': return '**粗體文本**\n*斜體文本*\n~~刪除線文本~~\n`代碼文本`';
			case 'markdown.quote': return '引用';
			case 'markdown.quoteDescription': return '使用 > 符號創建引用，多個 > 創建多級引用';
			case 'markdown.quoteSyntax': return '> 這是一級引用\n>> 這是二級引用';
			case 'markdown.list': return '列表';
			case 'markdown.listDescription': return '使用數字+點號創建有序列表，使用 - 創建無序列表';
			case 'markdown.listSyntax': return '1. 第一項\n2. 第二項\n\n- 無序項\n  - 子項\n  - 另一個子項';
			case 'markdown.linkAndImage': return '鏈接與圖片';
			case 'markdown.linkAndImageDescription': return '鏈接格式：[文字](URL)\n圖片格式：![描述](URL)';
			case 'markdown.linkAndImageSyntax': return ({required Object link, required Object imgUrl}) => '[鏈接文字](${link})\n![圖片描述](${imgUrl})';
			case 'markdown.title': return '標題';
			case 'markdown.titleDescription': return '使用 # 號創建標題，數量表示級別';
			case 'markdown.titleSyntax': return '# 一級標題\n## 二級標題\n### 三級標題';
			case 'markdown.separator': return '分隔線';
			case 'markdown.separatorDescription': return '使用三個或更多 - 號創建分隔線';
			case 'markdown.separatorSyntax': return '---';
			case 'markdown.syntax': return '語法';
			case 'forum.errors.pleaseSelectCategory': return '請選擇分類';
			case 'forum.errors.threadLocked': return '該主題已鎖定，無法回覆';
			case 'forum.createPost': return '創建帖子';
			case 'forum.title': return '標題';
			case 'forum.enterTitle': return '輸入標題';
			case 'forum.content': return '內容';
			case 'forum.enterContent': return '輸入內容';
			case 'forum.writeYourContentHere': return '在此輸入內容...';
			case 'forum.posts': return '帖子';
			case 'forum.threads': return '主題';
			case 'forum.forum': return '論壇';
			case 'forum.createThread': return '創建主題';
			case 'forum.selectCategory': return '選擇分類';
			case 'forum.cooldownRemaining': return ({required Object minutes, required Object seconds}) => '冷卻剩餘時間 ${minutes} 分 ${seconds} 秒';
			case 'forum.groups.administration': return '管理';
			case 'forum.groups.global': return '全球';
			case 'forum.groups.chinese': return '中文';
			case 'forum.groups.japanese': return '日語';
			case 'forum.groups.korean': return '韓語';
			case 'forum.groups.other': return '其他';
			case 'forum.leafNames.announcements': return '公告';
			case 'forum.leafNames.feedback': return '反饋';
			case 'forum.leafNames.support': return '幫助';
			case 'forum.leafNames.general': return '一般';
			case 'forum.leafNames.guides': return '指南';
			case 'forum.leafNames.questions': return '問題';
			case 'forum.leafNames.requests': return '請求';
			case 'forum.leafNames.sharing': return '分享';
			case 'forum.leafNames.general_zh': return '一般';
			case 'forum.leafNames.questions_zh': return '問題';
			case 'forum.leafNames.requests_zh': return '請求';
			case 'forum.leafNames.support_zh': return '幫助';
			case 'forum.leafNames.general_ja': return '一般';
			case 'forum.leafNames.questions_ja': return '問題';
			case 'forum.leafNames.requests_ja': return '請求';
			case 'forum.leafNames.support_ja': return '幫助';
			case 'forum.leafNames.korean': return '韓語';
			case 'forum.leafNames.other': return '其他';
			case 'forum.leafDescriptions.announcements': return '官方重要通知和公告';
			case 'forum.leafDescriptions.feedback': return '對網站功能和服務的反饋';
			case 'forum.leafDescriptions.support': return '幫助解決網站相關問題';
			case 'forum.leafDescriptions.general': return '討論任何話題';
			case 'forum.leafDescriptions.guides': return '分享你的經驗和教程';
			case 'forum.leafDescriptions.questions': return '提出你的疑問';
			case 'forum.leafDescriptions.requests': return '發布你的請求';
			case 'forum.leafDescriptions.sharing': return '分享有趣的內容';
			case 'forum.leafDescriptions.general_zh': return '討論任何話題';
			case 'forum.leafDescriptions.questions_zh': return '提出你的疑問';
			case 'forum.leafDescriptions.requests_zh': return '發布你的請求';
			case 'forum.leafDescriptions.support_zh': return '幫助解決網站相關問題';
			case 'forum.leafDescriptions.general_ja': return '討論任何話題';
			case 'forum.leafDescriptions.questions_ja': return '提出你的疑問';
			case 'forum.leafDescriptions.requests_ja': return '發布你的請求';
			case 'forum.leafDescriptions.support_ja': return '幫助解決網站相關問題';
			case 'forum.leafDescriptions.korean': return '韓語相關討論';
			case 'forum.leafDescriptions.other': return '其他未分類的內容';
			case 'forum.reply': return '回覆';
			case 'forum.pendingReview': return '審核中';
			case 'forum.editedAt': return '編輯時間';
			case 'forum.copySuccess': return '已複製到剪貼簿';
			case 'forum.copySuccessForMessage': return ({required Object str}) => '已複製到剪貼簿: ${str}';
			case 'forum.editReply': return '編輯回覆';
			case 'forum.editTitle': return '編輯標題';
			case 'forum.submit': return '提交';
			case 'notifications.errors.unsupportedNotificationType': return '暫不支持的通知類型';
			case 'notifications.errors.unknownUser': return '未知用戶';
			case 'notifications.errors.unsupportedNotificationTypeWithType': return ({required Object type}) => '暫不支持的通知類型: ${type}';
			case 'notifications.errors.unknownNotificationType': return '未知通知類型';
			case 'notifications.notifications': return '通知';
			case 'notifications.profile': return '個人主頁';
			case 'notifications.postedNewComment': return '發表了評論';
			case 'notifications.notifiedOn': return '在您的個人主頁上發表了評論';
			case 'notifications.inYour': return '在您的';
			case 'notifications.video': return '影片';
			case 'notifications.repliedYourVideoComment': return '回覆了您的影片評論';
			case 'notifications.copyInfoToClipboard': return '複製通知信息到剪貼簿';
			case 'notifications.copySuccess': return '已複製到剪貼簿';
			case 'notifications.copySuccessForMessage': return ({required Object str}) => '已複製到剪貼簿: ${str}';
			case 'notifications.markAllAsRead': return '全部標記已讀';
			case 'notifications.markAllAsReadSuccess': return '所有通知已標記為已讀';
			case 'notifications.markAllAsReadFailed': return '全部標記已讀失敗';
			case 'notifications.markAllAsReadFailedWithException': return ({required Object exception}) => '全部標記已讀失敗: ${exception}';
			case 'notifications.markSelectedAsRead': return '標記已讀';
			case 'notifications.markSelectedAsReadSuccess': return '已標記為已讀';
			case 'notifications.markSelectedAsReadFailed': return '標記已讀失敗';
			case 'notifications.markSelectedAsReadFailedWithException': return ({required Object exception}) => '標記已讀失敗: ${exception}';
			case 'notifications.markAsRead': return '標記已讀';
			case 'notifications.markAsReadSuccess': return '已標記為已讀';
			case 'notifications.markAsReadFailed': return '標記已讀失敗';
			case 'notifications.notificationTypeHelp': return '通知類型幫助';
			case 'notifications.dueToLackOfNotificationTypeDetails': return '通知類型的詳細信息不足，目前支持的類型可能沒有覆蓋到您當前收到的消息';
			case 'notifications.helpUsImproveNotificationTypeSupport': return '如果您願意幫助我們完善通知類型的支持：';
			case 'notifications.helpUsImproveNotificationTypeSupportLongText': return '1. 📋 複製通知信息\n2. 🐞 前往項目倉庫提交 issue\n\n⚠️ 注意：通知信息可能包含個人隱私，如果你不想公開，也可以通過郵件發送給項目作者。';
			case 'notifications.goToRepository': return '前往項目倉庫';
			case 'notifications.copy': return '複製';
			case 'notifications.commentApproved': return '評論已通過';
			case 'notifications.repliedYourProfileComment': return '回覆了您的個人主頁評論';
			case 'notifications.kReplied': return '回覆了您在';
			case 'notifications.kCommented': return '評論了您的';
			case 'notifications.kVideo': return '影片';
			case 'notifications.kGallery': return '圖庫';
			case 'notifications.kProfile': return '主頁';
			case 'notifications.kThread': return '主題';
			case 'notifications.kPost': return '投稿';
			case 'notifications.kCommentSection': return '下的評論';
			case 'notifications.kApprovedComment': return '評論已通過';
			case 'notifications.kApprovedVideo': return '影片已通過';
			case 'notifications.kApprovedGallery': return '圖庫已通過';
			case 'notifications.kApprovedThread': return '主題已審核';
			case 'notifications.kApprovedPost': return '投稿已審核';
			case 'notifications.kUnknownType': return '未知通知類型';
			case 'conversation.errors.pleaseSelectAUser': return '請選擇一個用戶';
			case 'conversation.errors.pleaseEnterATitle': return '請輸入標題';
			case 'conversation.errors.clickToSelectAUser': return '點擊選擇用戶';
			case 'conversation.errors.loadFailedClickToRetry': return '加載失敗,點擊重試';
			case 'conversation.errors.loadFailed': return '加載失敗';
			case 'conversation.errors.clickToRetry': return '點擊重試';
			case 'conversation.errors.noMoreConversations': return '沒有更多消息了';
			case 'conversation.conversation': return '會話';
			case 'conversation.startConversation': return '發起會話';
			case 'conversation.noConversation': return '暫無會話';
			case 'conversation.selectFromLeftListAndStartConversation': return '從左側列表選擇一個會話開始聊天';
			case 'conversation.title': return '標題';
			case 'conversation.body': return '內容';
			case 'conversation.selectAUser': return '選擇用戶';
			case 'conversation.searchUsers': return '搜索用戶...';
			case 'conversation.tmpNoConversions': return '暫無會話';
			case 'conversation.deleteThisMessage': return '刪除此消息';
			case 'conversation.deleteThisMessageSubtitle': return '此操作不可撤銷';
			case 'conversation.writeMessageHere': return '在此處輸入消息';
			case 'conversation.sendMessage': return '發送消息';
			default: return null;
		}
	}
}

