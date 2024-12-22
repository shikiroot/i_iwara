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
class TranslationsJa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonJa common = _TranslationsCommonJa._(_root);
	@override late final _TranslationsAuthJa auth = _TranslationsAuthJa._(_root);
	@override late final _TranslationsErrorsJa errors = _TranslationsErrorsJa._(_root);
	@override late final _TranslationsFriendsJa friends = _TranslationsFriendsJa._(_root);
	@override late final _TranslationsAuthorProfileJa authorProfile = _TranslationsAuthorProfileJa._(_root);
	@override late final _TranslationsFavoritesJa favorites = _TranslationsFavoritesJa._(_root);
	@override late final _TranslationsGalleryDetailJa galleryDetail = _TranslationsGalleryDetailJa._(_root);
	@override late final _TranslationsPlayListJa playList = _TranslationsPlayListJa._(_root);
	@override late final _TranslationsSearchJa search = _TranslationsSearchJa._(_root);
	@override late final _TranslationsMediaListJa mediaList = _TranslationsMediaListJa._(_root);
	@override late final _TranslationsSettingsJa settings = _TranslationsSettingsJa._(_root);
	@override late final _TranslationsSignInJa signIn = _TranslationsSignInJa._(_root);
	@override late final _TranslationsSubscriptionsJa subscriptions = _TranslationsSubscriptionsJa._(_root);
	@override late final _TranslationsVideoDetailJa videoDetail = _TranslationsVideoDetailJa._(_root);
}

// Path: common
class _TranslationsCommonJa implements TranslationsCommonEn {
	_TranslationsCommonJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Love Iwara';
	@override String get ok => 'OK';
	@override String get cancel => 'キャンセル';
	@override String get save => '保存';
	@override String get delete => '削除';
	@override String get loading => '読み込み中...';
	@override String get privacyHint => 'プライバシー情報、表示されません';
	@override String get latest => '最新';
	@override String get likesCount => 'いいね';
	@override String get viewsCount => '閲覧数';
	@override String get popular => '人気';
	@override String get trending => 'トレンド';
	@override String get commentList => 'コメントリスト';
	@override String get sendComment => 'コメント投稿';
	@override String get send => '投稿';
	@override String get retry => '再試行';
	@override String get premium => 'プレミアム';
	@override String get follower => 'フォロワー';
	@override String get friend => 'フレンド';
	@override String get video => 'ビデオ';
	@override String get following => 'フォロー';
	@override String get cancelFriendRequest => '申請取消';
	@override String get cancelSpecialFollow => '特別フォロー取消';
	@override String get addFriend => 'フレンド追加';
	@override String get removeFriend => 'フレンド解除';
	@override String get followed => 'フォロー済み';
	@override String get follow => 'フォロー';
	@override String get unfollow => 'フォロー解除';
	@override String get specialFollow => '特別フォロー';
	@override String get specialFollowed => '特別フォロー済み';
	@override String get gallery => 'ギャラリー';
	@override String get playlist => 'プレイリスト';
	@override String get commentPostedSuccessfully => 'コメント投稿成功';
	@override String get commentPostedFailed => 'コメント投稿失敗';
	@override String get success => '成功';
	@override String get commentDeletedSuccessfully => 'コメント削除成功';
	@override String get commentUpdatedSuccessfully => 'コメント更新成功';
	@override String totalComments({required Object count}) => '${count} コメント';
	@override String get writeYourCommentHere => 'コメントを書いてください...';
	@override String get tmpNoReplies => 'まだ返信はありません';
	@override String get loadMore => 'もっと読み込む';
	@override String get noMoreDatas => 'データがありません';
	@override String get selectTranslationLanguage => '翻訳言語を選択';
	@override String get translate => '翻訳';
	@override String get translateFailedPleaseTryAgainLater => '翻訳失敗、再試行してください';
	@override String get translationResult => '翻訳結果';
	@override String get justNow => 'たった今';
	@override String minutesAgo({required Object num}) => '${num}分前';
	@override String hoursAgo({required Object num}) => '${num}時間前';
	@override String daysAgo({required Object num}) => '${num}日前';
	@override String editedAt({required Object num}) => '編集した${num}前';
	@override String get editComment => 'コメント編集';
	@override String get commentUpdated => 'コメント更新';
	@override String get replyComment => 'コメント返信';
	@override String get reply => '返信';
	@override String get edit => '編集';
	@override String get unknownUser => '不明なユーザー';
	@override String get me => '私';
	@override String get author => '作者';
	@override String get admin => '管理者';
	@override String viewReplies({required Object num}) => '返信 (${num})';
	@override String get hideReplies => '返信を隠す';
	@override String get confirmDelete => '削除確認';
	@override String get areYouSureYouWantToDeleteThisItem => '削除しますか？';
	@override String get tmpNoComments => 'コメントはありません';
	@override String get refresh => '更新';
	@override String get back => '戻る';
	@override String get tips => 'ヒント';
	@override String get linkIsEmpty => 'リンクアドレスが空です';
	@override String get linkCopiedToClipboard => 'リンクアドレスをクリップボードにコピーしました';
	@override String get imageCopiedToClipboard => '画像をクリップボードにコピーしました';
	@override String get copyImageFailed => '画像のコピーに失敗しました';
	@override String get mobileSaveImageIsUnderDevelopment => 'モバイル端末の画像保存機能は開発中です';
	@override String get imageSavedTo => '画像を保存しました';
	@override String get saveImageFailed => '画像の保存に失敗しました';
	@override String get close => '閉じる';
	@override String get more => 'もっと';
	@override String get moreFeaturesToBeDeveloped => 'もっと機能を開発中です';
	@override String get all => '全部';
	@override String selectedRecords({required Object num}) => '${num} 件選択済み';
	@override String get cancelSelectAll => '全選択を取消';
	@override String get selectAll => '全選択';
	@override String get exitEditMode => '編集モードを終了';
	@override String areYouSureYouWantToDeleteSelectedItems({required Object num}) => '選択した ${num} 件を削除しますか？';
	@override String get searchHistoryRecords => '検索履歴...';
	@override String get settings => '設定';
	@override String get subscriptions => '購読';
	@override String videoCount({required Object num}) => '${num} 個ビデオ';
	@override String get share => '共有';
	@override String get areYouSureYouWantToShareThisPlaylist => 'このプレイリストを共有しますか？';
	@override String get editTitle => 'タイトルを編集';
	@override String get editMode => '編集モード';
	@override String get pleaseEnterNewTitle => '新しいタイトルを入力してください';
	@override String get createPlayList => 'プレイリストを作成';
	@override String get create => '作成';
	@override String get general => '大衆的';
	@override String get r18 => 'R18';
	@override String get sensitive => '敏感';
	@override String get year => '年';
	@override String get tag => 'タグ';
	@override String get private => 'プライベート';
	@override String get noTitle => '無タイトル';
	@override String get search => '検索';
	@override String get noContent => 'コンテンツがありません';
	@override String get recording => '記録中';
	@override String get paused => '一時停止';
	@override String get clear => 'クリア';
	@override String get user => 'ユーザー';
	@override String get post => '投稿';
	@override String get seconds => '秒';
	@override String get comingSoon => '敬請期待';
	@override String get confirm => '確認';
	@override String get hour => '時';
	@override String get minute => '分';
	@override String get clickToRefresh => 'クリックして更新';
	@override String get history => '履歴';
	@override String get favorites => 'お気に入り';
	@override String get friends => 'フレンド';
	@override String get playList => 'プレイリスト';
	@override String get checkLicense => 'ライセンスを確認';
	@override String get logout => 'ログアウト';
	@override String get checkNetworkSettings => 'ネットワーク設定を確認';
	@override String get accept => '受け入れる';
	@override String get fensi => 'ファン';
	@override String get reject => '拒否する';
}

// Path: auth
class _TranslationsAuthJa implements TranslationsAuthEn {
	_TranslationsAuthJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get checkNetworkSettings => 'ネットワーク設定を確認';
	@override String get login => 'ログイン';
	@override String get logout => 'ログアウト';
	@override String get email => 'メールアドレス';
	@override String get password => 'パスワード';
	@override String get loginOrRegister => 'ログイン / 登録';
	@override String get register => '登録';
	@override String get pleaseEnterEmail => 'メールアドレスを入力してください';
	@override String get pleaseEnterPassword => 'パスワードを入力してください';
	@override String get passwordMustBeAtLeast6Characters => 'パスワードは6文字以上必要です';
	@override String get pleaseEnterCaptcha => '検証コードを入力してください';
	@override String get captcha => '検証コード';
	@override String get refreshCaptcha => '検証コードを更新';
	@override String get captchaNotLoaded => '検証コードが読み込めません';
	@override String get loginSuccess => 'ログイン成功';
	@override String get emailVerificationSent => 'メール検証コードが送信されました';
	@override String get notLoggedIn => 'ログインしていません';
	@override String get clickToLogin => 'ここをクリックしてログイン';
	@override String get logoutConfirmation => 'ログアウトしますか？';
	@override String get logoutSuccess => 'ログアウト成功';
	@override String get logoutFailed => 'ログアウト失敗';
	@override String get fensi => 'ファン';
	@override String get accept => '受け入れる';
	@override String get reject => '拒否する';
}

// Path: errors
class _TranslationsErrorsJa implements TranslationsErrorsEn {
	_TranslationsErrorsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get error => 'エラー';
	@override String get required => 'この項目は必須です';
	@override String get invalidEmail => '無効なメールアドレス';
	@override String get networkError => 'ネットワークエラー、再試行してください';
	@override String get errorWhileFetching => '情報取得エラー';
	@override String get commentCanNotBeEmpty => 'コメント内容は空にできません';
	@override String get errorWhileFetchingReplies => '返信取得エラー、ネットワーク接続を確認してください';
	@override String get canNotFindCommentController => 'コメントコントローラーが見つかりません';
	@override String get errorWhileLoadingGallery => 'ギャラリー読み込みエラー';
	@override String get howCouldThereBeNoDataItCantBePossible => 'ギャラリーにデータがありません。エラーです :<';
	@override String unsupportedImageFormat({required Object str}) => 'サポートされていない画像形式: ${str}';
	@override String get invalidGalleryId => '無効なギャラリーID';
	@override String get translationFailedPleaseTryAgainLater => '翻訳失敗、再試行してください';
	@override String get errorOccurred => 'エラーが発生しました、再試行してください';
	@override String get errorWhileFetchingDatas => 'データ取得エラー、再試行してください';
	@override String get errorOccurredWhileProcessingRequest => 'リクエスト処理中にエラーが発生しました';
	@override String get serviceNotInitialized => 'サービスが初期化されていません';
	@override String get unknownType => '不明なタイプ';
	@override String errorWhileOpeningLink({required Object link}) => 'リンクを開くエラー: ${link}';
	@override String get invalidUrl => '無効なURL';
	@override String get failedToOperate => '操作失敗';
}

// Path: friends
class _TranslationsFriendsJa implements TranslationsFriendsEn {
	_TranslationsFriendsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFriend => 'クリックしてフレンドに戻す';
	@override String get friendsList => 'フレンドリスト';
	@override String get friendRequests => 'フレンドリクエスト';
	@override String get friendRequestsList => 'フレンドリクエストリスト';
}

// Path: authorProfile
class _TranslationsAuthorProfileJa implements TranslationsAuthorProfileEn {
	_TranslationsAuthorProfileJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get noMoreDatas => 'データがありません';
	@override String get userProfile => 'ユーザー情報';
}

// Path: favorites
class _TranslationsFavoritesJa implements TranslationsFavoritesEn {
	_TranslationsFavoritesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get clickToRestoreFavorite => 'クリックしてお気に入りに戻す';
	@override String get myFavorites => 'お気に入り';
}

// Path: galleryDetail
class _TranslationsGalleryDetailJa implements TranslationsGalleryDetailEn {
	_TranslationsGalleryDetailJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get copyLink => 'リンクをコピー';
	@override String get copyImage => '画像をコピー';
	@override String get saveAs => '名前を付けて保存';
	@override String get saveToAlbum => 'アルバムに保存';
	@override String get publishedAt => '投稿日時';
	@override String get viewsCount => '閲覧数';
	@override String get imageLibraryFunctionIntroduction => '画像ライブラリー機能紹介';
	@override String get rightClickToSaveSingleImage => '右クリックで単一画像保存';
	@override String get batchSave => 'バッチ保存';
	@override String get keyboardLeftAndRightToSwitch => 'キーボードの左右で切り替え';
	@override String get keyboardUpAndDownToZoom => 'キーボードの上下で拡大縮小';
	@override String get mouseWheelToSwitch => 'マウスのホイールで切り替え';
	@override String get ctrlAndMouseWheelToZoom => 'CTRL + マウスのホイールで拡大縮小';
	@override String get moreFeaturesToBeDiscovered => 'もっと機能を発見...';
	@override String get authorOtherGalleries => '作者の他のギャラリー';
	@override String get relatedGalleries => '関連ギャラリー';
}

// Path: playList
class _TranslationsPlayListJa implements TranslationsPlayListEn {
	_TranslationsPlayListJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get myPlayList => 'マイプレイリスト';
	@override String get friendlyTips => '友情提示';
	@override String get dearUser => 'お客様';
	@override String get iwaraPlayListSystemIsNotPerfectYet => 'iwaraのプレイリストシステムはまだ不完全です';
	@override String get notSupportSetCover => 'カバーを設定できません';
	@override String get notSupportDeleteList => 'リストを削除できません';
	@override String get notSupportSetPrivate => 'プライベートに設定できません';
	@override String get yesCreateListWillAlwaysExistAndVisibleToEveryone => '作成したリストは常に存在し、すべての人に見えます';
	@override String get smallSuggestion => '小建议';
	@override String get useLikeToCollectContent => 'もしプライバシーを重視する場合、「いいね」機能を使用してコンテンツを収集することをお勧めします';
	@override String get welcomeToDiscussOnGitHub => '他の提案やアイデアがあれば、GitHubで議論してください！';
	@override String get iUnderstand => '理解しました';
}

// Path: search
class _TranslationsSearchJa implements TranslationsSearchEn {
	_TranslationsSearchJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get searchTags => '検索タグ...';
	@override String get contentRating => 'コンテンツ評価';
	@override String get pleaseEnterSearchContent => '検索内容を入力してください';
	@override String get searchHistory => '検索履歴';
	@override String get searchSuggestion => '検索提案';
	@override String get usedTimes => '使用回数';
	@override String get lastUsed => '最終使用';
	@override String get noSearchHistoryRecords => '検索履歴がありません';
	@override String notSupportCurrentSearchType({required Object searchType}) => '現在の検索タイプ ${searchType} はサポートされていません。更新をお待ちください';
	@override String get searchResult => '検索結果';
	@override String get removeTag => 'タグを削除';
}

// Path: mediaList
class _TranslationsMediaListJa implements TranslationsMediaListEn {
	_TranslationsMediaListJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get personalIntroduction => '個人紹介';
}

// Path: settings
class _TranslationsSettingsJa implements TranslationsSettingsEn {
	_TranslationsSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get searchConfig => '検索設定';
	@override String get thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain => 'この設定は、ビデオを再生する際に前回の設定が使用されるかどうかを決定します。';
	@override String get playControl => '再生制御';
	@override String get fastForwardTime => '早送り時間';
	@override String get fastForwardTimeMustBeAPositiveInteger => '早送り時間は正の整数でなければなりません。';
	@override String get rewindTime => '巻き戻し時間';
	@override String get rewindTimeMustBeAPositiveInteger => '巻き戻し時間は正の整数でなければなりません。';
	@override String get longPressPlaybackSpeed => '長押し再生倍速';
	@override String get longPressPlaybackSpeedMustBeAPositiveNumber => '長押し再生倍速は正の数でなければなりません。';
	@override String get repeat => 'ループ再生';
	@override String get renderVerticalVideoInVerticalScreen => '全屏再生時に縦画面で縦画面ビデオをレンダリング';
	@override String get thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen => 'この設定は、ビデオを全画面再生時に縦画面で縦画面ビデオをレンダリングするかどうかを決定します。';
	@override String get rememberVolume => '音量を記憶';
	@override String get thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain => 'この設定は、ビデオを再生する際に前回の音量設定が使用されるかどうかを決定します。';
	@override String get rememberBrightness => '明るさを記憶';
	@override String get thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain => 'この設定は、ビデオを再生する際に前回の明るさ設定が使用されるかどうかを決定します。';
	@override String get playControlArea => '再生制御領域';
	@override String get leftAndRightControlAreaWidth => '左右制御領域幅';
	@override String get thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer => 'この設定は、再生器の左右の制御領域の幅を決定します。';
	@override String get proxyAddressCannotBeEmpty => 'プロキシアドレスを入力してください。';
	@override String get invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort => '無効なプロキシアドレス形式です。IP:ポート または ドメイン名:ポート の形式を使用してください。';
	@override String get proxyNormalWork => 'プロキシが正常に動作しています。';
	@override String testProxyFailedWithStatusCode({required Object code}) => 'プロキシテスト失敗、ステータスコード: ${code}';
	@override String testProxyFailedWithException({required Object exception}) => 'プロキシテスト失敗、例外: ${exception}';
	@override String get proxyConfig => 'プロキシ設定';
	@override String get thisIsHttpProxyAddress => 'ここはhttpプロキシアドレスです';
	@override String get checkProxy => 'プロキシチェック';
	@override String get proxyAddress => 'プロキシアドレス';
	@override String get pleaseEnterTheUrlOfTheProxyServerForExample1270018080 => 'プロキシサーバーのURLを入力してください、例えば 127.0.0.1:8080';
	@override String get enableProxy => 'プロキシを有効にする';
	@override String get left => '左';
	@override String get middle => '中';
	@override String get right => '右';
	@override String get playerSettings => 'プレイヤー設定';
	@override String get networkSettings => 'ネットワーク設定';
	@override String get customizeYourPlaybackExperience => '再生体験をカスタマイズ';
	@override String get chooseYourFavoriteAppAppearance => 'お好きなアプリの外観を選択';
	@override String get configureYourProxyServer => 'プロキシサーバーを設定';
	@override String get settings => '設定';
	@override String get themeSettings => 'テーマ設定';
}

// Path: signIn
class _TranslationsSignInJa implements TranslationsSignInEn {
	_TranslationsSignInJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirst => 'ログインしてからサインインしてください';
	@override String get alreadySignedInToday => '今日はすでにサインインしました！';
	@override String get youDidNotStickToTheSignIn => 'サインインを継続できませんでした。';
	@override String get signInSuccess => 'サインイン成功！';
	@override String get signInFailed => 'サインイン失敗、再試行してください';
	@override String get consecutiveSignIns => '連続サインイン日数';
	@override String get failureReason => 'サインインを継続できなかった理由';
	@override String get selectDateRange => '日付範囲を選択';
	@override String get startDate => '開始日';
	@override String get endDate => '終了日';
	@override String get invalidDate => '無効な日付';
	@override String get invalidDateRange => '無効な日付範囲';
	@override String get errorFormatText => '日付形式エラー';
	@override String get errorInvalidText => '無効な日付範囲';
	@override String get errorInvalidRangeText => '無効な日付範囲';
	@override String get dateRangeCantBeMoreThanOneYear => '日付範囲は1年を超えてはいけません';
	@override String get signIn => 'チェックイン';
	@override String get signInRecord => '着信記録';
	@override String get totalSignIns => '総成功署名';
	@override String get pleaseSelectSignInStatus => 'チェックインステータスを選択してください';
}

// Path: subscriptions
class _TranslationsSubscriptionsJa implements TranslationsSubscriptionsEn {
	_TranslationsSubscriptionsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get pleaseLoginFirstToViewYourSubscriptions => 'ログインしてからサブスクリプションを表示してください。';
}

// Path: videoDetail
class _TranslationsVideoDetailJa implements TranslationsVideoDetailEn {
	_TranslationsVideoDetailJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get videoIdIsEmpty => 'ビデオIDが空です';
	@override String get videoInfoIsEmpty => 'ビデオ情報が空です';
	@override String get thisIsAPrivateVideo => 'これはプライベートビデオです';
	@override String get getVideoInfoFailed => 'ビデオ情報取得失敗、再試行してください';
	@override String get noVideoSourceFound => 'ビデオソースが見つかりません';
	@override String tagCopiedToClipboard({required Object tagId}) => 'タグ "${tagId}" をクリップボードにコピーしました';
	@override String get errorLoadingVideo => 'ビデオの読み込み中にエラーが発生しました';
	@override String get play => '再生';
	@override String get pause => '一時停止';
	@override String get exitAppFullscreen => 'アプリの全画面を終了';
	@override String get enterAppFullscreen => 'アプリの全画面を開始';
	@override String get exitSystemFullscreen => 'システムの全画面を終了';
	@override String get enterSystemFullscreen => 'システムの全画面を開始';
	@override String get seekTo => '指定時間にジャンプ';
	@override String get switchResolution => '解像度を切り替え';
	@override String get switchPlaybackSpeed => '再生倍速を切り替え';
	@override String rewindSeconds({required Object num}) => '巻き戻し${num}秒';
	@override String fastForwardSeconds({required Object num}) => '早送り${num}秒';
	@override String playbackSpeedIng({required Object rate}) => '再生倍速${rate}倍';
	@override String get brightness => '明るさ';
	@override String get brightnessLowest => '明るさは最低';
	@override String get volume => '音量';
	@override String get volumeMuted => '音量は静音';
	@override String get home => 'ホーム';
	@override String get videoPlayer => 'ビデオプレイヤー';
	@override String get videoPlayerInfo => 'ビデオプレイヤー情報';
	@override String get moreSettings => 'もっと設定';
	@override String get videoPlayerFeatureInfo => 'ビデオプレイヤー機能紹介';
	@override String get autoRewind => '自動巻き戻し';
	@override String get rewindAndFastForward => '左右两侧双击快进或后退';
	@override String get volumeAndBrightness => '左右两侧垂直滑动调整音量、亮度';
	@override String get centerAreaDoubleTapPauseOrPlay => '中心区域双击暂停或播放';
	@override String get showVerticalVideoInFullScreen => '全画面再生時に縦画面で縦画面ビデオを表示';
	@override String get keepLastVolumeAndBrightness => '最後に調整した音量、明るさを保持';
	@override String get setProxy => 'プロキシを設定';
	@override String get moreFeaturesToBeDiscovered => 'もっと機能を発見...';
	@override String get videoPlayerSettings => 'ビデオプレイヤー設定';
	@override String commentCount({required Object num}) => '${num} コメント';
	@override String get writeYourCommentHere => 'コメントを書いてください...';
	@override String get authorOtherVideos => '作者の他のビデオ';
	@override String get relatedVideos => '関連ビデオ';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.appName': return 'Love Iwara';
			case 'common.ok': return 'OK';
			case 'common.cancel': return 'キャンセル';
			case 'common.save': return '保存';
			case 'common.delete': return '削除';
			case 'common.loading': return '読み込み中...';
			case 'common.privacyHint': return 'プライバシー情報、表示されません';
			case 'common.latest': return '最新';
			case 'common.likesCount': return 'いいね';
			case 'common.viewsCount': return '閲覧数';
			case 'common.popular': return '人気';
			case 'common.trending': return 'トレンド';
			case 'common.commentList': return 'コメントリスト';
			case 'common.sendComment': return 'コメント投稿';
			case 'common.send': return '投稿';
			case 'common.retry': return '再試行';
			case 'common.premium': return 'プレミアム';
			case 'common.follower': return 'フォロワー';
			case 'common.friend': return 'フレンド';
			case 'common.video': return 'ビデオ';
			case 'common.following': return 'フォロー';
			case 'common.cancelFriendRequest': return '申請取消';
			case 'common.cancelSpecialFollow': return '特別フォロー取消';
			case 'common.addFriend': return 'フレンド追加';
			case 'common.removeFriend': return 'フレンド解除';
			case 'common.followed': return 'フォロー済み';
			case 'common.follow': return 'フォロー';
			case 'common.unfollow': return 'フォロー解除';
			case 'common.specialFollow': return '特別フォロー';
			case 'common.specialFollowed': return '特別フォロー済み';
			case 'common.gallery': return 'ギャラリー';
			case 'common.playlist': return 'プレイリスト';
			case 'common.commentPostedSuccessfully': return 'コメント投稿成功';
			case 'common.commentPostedFailed': return 'コメント投稿失敗';
			case 'common.success': return '成功';
			case 'common.commentDeletedSuccessfully': return 'コメント削除成功';
			case 'common.commentUpdatedSuccessfully': return 'コメント更新成功';
			case 'common.totalComments': return ({required Object count}) => '${count} コメント';
			case 'common.writeYourCommentHere': return 'コメントを書いてください...';
			case 'common.tmpNoReplies': return 'まだ返信はありません';
			case 'common.loadMore': return 'もっと読み込む';
			case 'common.noMoreDatas': return 'データがありません';
			case 'common.selectTranslationLanguage': return '翻訳言語を選択';
			case 'common.translate': return '翻訳';
			case 'common.translateFailedPleaseTryAgainLater': return '翻訳失敗、再試行してください';
			case 'common.translationResult': return '翻訳結果';
			case 'common.justNow': return 'たった今';
			case 'common.minutesAgo': return ({required Object num}) => '${num}分前';
			case 'common.hoursAgo': return ({required Object num}) => '${num}時間前';
			case 'common.daysAgo': return ({required Object num}) => '${num}日前';
			case 'common.editedAt': return ({required Object num}) => '編集した${num}前';
			case 'common.editComment': return 'コメント編集';
			case 'common.commentUpdated': return 'コメント更新';
			case 'common.replyComment': return 'コメント返信';
			case 'common.reply': return '返信';
			case 'common.edit': return '編集';
			case 'common.unknownUser': return '不明なユーザー';
			case 'common.me': return '私';
			case 'common.author': return '作者';
			case 'common.admin': return '管理者';
			case 'common.viewReplies': return ({required Object num}) => '返信 (${num})';
			case 'common.hideReplies': return '返信を隠す';
			case 'common.confirmDelete': return '削除確認';
			case 'common.areYouSureYouWantToDeleteThisItem': return '削除しますか？';
			case 'common.tmpNoComments': return 'コメントはありません';
			case 'common.refresh': return '更新';
			case 'common.back': return '戻る';
			case 'common.tips': return 'ヒント';
			case 'common.linkIsEmpty': return 'リンクアドレスが空です';
			case 'common.linkCopiedToClipboard': return 'リンクアドレスをクリップボードにコピーしました';
			case 'common.imageCopiedToClipboard': return '画像をクリップボードにコピーしました';
			case 'common.copyImageFailed': return '画像のコピーに失敗しました';
			case 'common.mobileSaveImageIsUnderDevelopment': return 'モバイル端末の画像保存機能は開発中です';
			case 'common.imageSavedTo': return '画像を保存しました';
			case 'common.saveImageFailed': return '画像の保存に失敗しました';
			case 'common.close': return '閉じる';
			case 'common.more': return 'もっと';
			case 'common.moreFeaturesToBeDeveloped': return 'もっと機能を開発中です';
			case 'common.all': return '全部';
			case 'common.selectedRecords': return ({required Object num}) => '${num} 件選択済み';
			case 'common.cancelSelectAll': return '全選択を取消';
			case 'common.selectAll': return '全選択';
			case 'common.exitEditMode': return '編集モードを終了';
			case 'common.areYouSureYouWantToDeleteSelectedItems': return ({required Object num}) => '選択した ${num} 件を削除しますか？';
			case 'common.searchHistoryRecords': return '検索履歴...';
			case 'common.settings': return '設定';
			case 'common.subscriptions': return '購読';
			case 'common.videoCount': return ({required Object num}) => '${num} 個ビデオ';
			case 'common.share': return '共有';
			case 'common.areYouSureYouWantToShareThisPlaylist': return 'このプレイリストを共有しますか？';
			case 'common.editTitle': return 'タイトルを編集';
			case 'common.editMode': return '編集モード';
			case 'common.pleaseEnterNewTitle': return '新しいタイトルを入力してください';
			case 'common.createPlayList': return 'プレイリストを作成';
			case 'common.create': return '作成';
			case 'common.general': return '大衆的';
			case 'common.r18': return 'R18';
			case 'common.sensitive': return '敏感';
			case 'common.year': return '年';
			case 'common.tag': return 'タグ';
			case 'common.private': return 'プライベート';
			case 'common.noTitle': return '無タイトル';
			case 'common.search': return '検索';
			case 'common.noContent': return 'コンテンツがありません';
			case 'common.recording': return '記録中';
			case 'common.paused': return '一時停止';
			case 'common.clear': return 'クリア';
			case 'common.user': return 'ユーザー';
			case 'common.post': return '投稿';
			case 'common.seconds': return '秒';
			case 'common.comingSoon': return '敬請期待';
			case 'common.confirm': return '確認';
			case 'common.hour': return '時';
			case 'common.minute': return '分';
			case 'common.clickToRefresh': return 'クリックして更新';
			case 'common.history': return '履歴';
			case 'common.favorites': return 'お気に入り';
			case 'common.friends': return 'フレンド';
			case 'common.playList': return 'プレイリスト';
			case 'common.checkLicense': return 'ライセンスを確認';
			case 'common.logout': return 'ログアウト';
			case 'common.checkNetworkSettings': return 'ネットワーク設定を確認';
			case 'common.accept': return '受け入れる';
			case 'common.fensi': return 'ファン';
			case 'common.reject': return '拒否する';
			case 'auth.checkNetworkSettings': return 'ネットワーク設定を確認';
			case 'auth.login': return 'ログイン';
			case 'auth.logout': return 'ログアウト';
			case 'auth.email': return 'メールアドレス';
			case 'auth.password': return 'パスワード';
			case 'auth.loginOrRegister': return 'ログイン / 登録';
			case 'auth.register': return '登録';
			case 'auth.pleaseEnterEmail': return 'メールアドレスを入力してください';
			case 'auth.pleaseEnterPassword': return 'パスワードを入力してください';
			case 'auth.passwordMustBeAtLeast6Characters': return 'パスワードは6文字以上必要です';
			case 'auth.pleaseEnterCaptcha': return '検証コードを入力してください';
			case 'auth.captcha': return '検証コード';
			case 'auth.refreshCaptcha': return '検証コードを更新';
			case 'auth.captchaNotLoaded': return '検証コードが読み込めません';
			case 'auth.loginSuccess': return 'ログイン成功';
			case 'auth.emailVerificationSent': return 'メール検証コードが送信されました';
			case 'auth.notLoggedIn': return 'ログインしていません';
			case 'auth.clickToLogin': return 'ここをクリックしてログイン';
			case 'auth.logoutConfirmation': return 'ログアウトしますか？';
			case 'auth.logoutSuccess': return 'ログアウト成功';
			case 'auth.logoutFailed': return 'ログアウト失敗';
			case 'auth.fensi': return 'ファン';
			case 'auth.accept': return '受け入れる';
			case 'auth.reject': return '拒否する';
			case 'errors.error': return 'エラー';
			case 'errors.required': return 'この項目は必須です';
			case 'errors.invalidEmail': return '無効なメールアドレス';
			case 'errors.networkError': return 'ネットワークエラー、再試行してください';
			case 'errors.errorWhileFetching': return '情報取得エラー';
			case 'errors.commentCanNotBeEmpty': return 'コメント内容は空にできません';
			case 'errors.errorWhileFetchingReplies': return '返信取得エラー、ネットワーク接続を確認してください';
			case 'errors.canNotFindCommentController': return 'コメントコントローラーが見つかりません';
			case 'errors.errorWhileLoadingGallery': return 'ギャラリー読み込みエラー';
			case 'errors.howCouldThereBeNoDataItCantBePossible': return 'ギャラリーにデータがありません。エラーです :<';
			case 'errors.unsupportedImageFormat': return ({required Object str}) => 'サポートされていない画像形式: ${str}';
			case 'errors.invalidGalleryId': return '無効なギャラリーID';
			case 'errors.translationFailedPleaseTryAgainLater': return '翻訳失敗、再試行してください';
			case 'errors.errorOccurred': return 'エラーが発生しました、再試行してください';
			case 'errors.errorWhileFetchingDatas': return 'データ取得エラー、再試行してください';
			case 'errors.errorOccurredWhileProcessingRequest': return 'リクエスト処理中にエラーが発生しました';
			case 'errors.serviceNotInitialized': return 'サービスが初期化されていません';
			case 'errors.unknownType': return '不明なタイプ';
			case 'errors.errorWhileOpeningLink': return ({required Object link}) => 'リンクを開くエラー: ${link}';
			case 'errors.invalidUrl': return '無効なURL';
			case 'errors.failedToOperate': return '操作失敗';
			case 'friends.clickToRestoreFriend': return 'クリックしてフレンドに戻す';
			case 'friends.friendsList': return 'フレンドリスト';
			case 'friends.friendRequests': return 'フレンドリクエスト';
			case 'friends.friendRequestsList': return 'フレンドリクエストリスト';
			case 'authorProfile.noMoreDatas': return 'データがありません';
			case 'authorProfile.userProfile': return 'ユーザー情報';
			case 'favorites.clickToRestoreFavorite': return 'クリックしてお気に入りに戻す';
			case 'favorites.myFavorites': return 'お気に入り';
			case 'galleryDetail.copyLink': return 'リンクをコピー';
			case 'galleryDetail.copyImage': return '画像をコピー';
			case 'galleryDetail.saveAs': return '名前を付けて保存';
			case 'galleryDetail.saveToAlbum': return 'アルバムに保存';
			case 'galleryDetail.publishedAt': return '投稿日時';
			case 'galleryDetail.viewsCount': return '閲覧数';
			case 'galleryDetail.imageLibraryFunctionIntroduction': return '画像ライブラリー機能紹介';
			case 'galleryDetail.rightClickToSaveSingleImage': return '右クリックで単一画像保存';
			case 'galleryDetail.batchSave': return 'バッチ保存';
			case 'galleryDetail.keyboardLeftAndRightToSwitch': return 'キーボードの左右で切り替え';
			case 'galleryDetail.keyboardUpAndDownToZoom': return 'キーボードの上下で拡大縮小';
			case 'galleryDetail.mouseWheelToSwitch': return 'マウスのホイールで切り替え';
			case 'galleryDetail.ctrlAndMouseWheelToZoom': return 'CTRL + マウスのホイールで拡大縮小';
			case 'galleryDetail.moreFeaturesToBeDiscovered': return 'もっと機能を発見...';
			case 'galleryDetail.authorOtherGalleries': return '作者の他のギャラリー';
			case 'galleryDetail.relatedGalleries': return '関連ギャラリー';
			case 'playList.myPlayList': return 'マイプレイリスト';
			case 'playList.friendlyTips': return '友情提示';
			case 'playList.dearUser': return 'お客様';
			case 'playList.iwaraPlayListSystemIsNotPerfectYet': return 'iwaraのプレイリストシステムはまだ不完全です';
			case 'playList.notSupportSetCover': return 'カバーを設定できません';
			case 'playList.notSupportDeleteList': return 'リストを削除できません';
			case 'playList.notSupportSetPrivate': return 'プライベートに設定できません';
			case 'playList.yesCreateListWillAlwaysExistAndVisibleToEveryone': return '作成したリストは常に存在し、すべての人に見えます';
			case 'playList.smallSuggestion': return '小建议';
			case 'playList.useLikeToCollectContent': return 'もしプライバシーを重視する場合、「いいね」機能を使用してコンテンツを収集することをお勧めします';
			case 'playList.welcomeToDiscussOnGitHub': return '他の提案やアイデアがあれば、GitHubで議論してください！';
			case 'playList.iUnderstand': return '理解しました';
			case 'search.searchTags': return '検索タグ...';
			case 'search.contentRating': return 'コンテンツ評価';
			case 'search.pleaseEnterSearchContent': return '検索内容を入力してください';
			case 'search.searchHistory': return '検索履歴';
			case 'search.searchSuggestion': return '検索提案';
			case 'search.usedTimes': return '使用回数';
			case 'search.lastUsed': return '最終使用';
			case 'search.noSearchHistoryRecords': return '検索履歴がありません';
			case 'search.notSupportCurrentSearchType': return ({required Object searchType}) => '現在の検索タイプ ${searchType} はサポートされていません。更新をお待ちください';
			case 'search.searchResult': return '検索結果';
			case 'search.removeTag': return 'タグを削除';
			case 'mediaList.personalIntroduction': return '個人紹介';
			case 'settings.searchConfig': return '検索設定';
			case 'settings.thisConfigurationDeterminesWhetherThePreviousConfigurationWillBeUsedWhenPlayingVideosAgain': return 'この設定は、ビデオを再生する際に前回の設定が使用されるかどうかを決定します。';
			case 'settings.playControl': return '再生制御';
			case 'settings.fastForwardTime': return '早送り時間';
			case 'settings.fastForwardTimeMustBeAPositiveInteger': return '早送り時間は正の整数でなければなりません。';
			case 'settings.rewindTime': return '巻き戻し時間';
			case 'settings.rewindTimeMustBeAPositiveInteger': return '巻き戻し時間は正の整数でなければなりません。';
			case 'settings.longPressPlaybackSpeed': return '長押し再生倍速';
			case 'settings.longPressPlaybackSpeedMustBeAPositiveNumber': return '長押し再生倍速は正の数でなければなりません。';
			case 'settings.repeat': return 'ループ再生';
			case 'settings.renderVerticalVideoInVerticalScreen': return '全屏再生時に縦画面で縦画面ビデオをレンダリング';
			case 'settings.thisConfigurationDeterminesWhetherTheVideoWillBeRenderedInVerticalScreenWhenPlayingInFullScreen': return 'この設定は、ビデオを全画面再生時に縦画面で縦画面ビデオをレンダリングするかどうかを決定します。';
			case 'settings.rememberVolume': return '音量を記憶';
			case 'settings.thisConfigurationDeterminesWhetherTheVolumeWillBeKeptWhenPlayingVideosAgain': return 'この設定は、ビデオを再生する際に前回の音量設定が使用されるかどうかを決定します。';
			case 'settings.rememberBrightness': return '明るさを記憶';
			case 'settings.thisConfigurationDeterminesWhetherTheBrightnessWillBeKeptWhenPlayingVideosAgain': return 'この設定は、ビデオを再生する際に前回の明るさ設定が使用されるかどうかを決定します。';
			case 'settings.playControlArea': return '再生制御領域';
			case 'settings.leftAndRightControlAreaWidth': return '左右制御領域幅';
			case 'settings.thisConfigurationDeterminesTheWidthOfTheControlAreasOnTheLeftAndRightSidesOfThePlayer': return 'この設定は、再生器の左右の制御領域の幅を決定します。';
			case 'settings.proxyAddressCannotBeEmpty': return 'プロキシアドレスを入力してください。';
			case 'settings.invalidProxyAddressFormatPleaseUseTheFormatOfIpPortOrDomainNamePort': return '無効なプロキシアドレス形式です。IP:ポート または ドメイン名:ポート の形式を使用してください。';
			case 'settings.proxyNormalWork': return 'プロキシが正常に動作しています。';
			case 'settings.testProxyFailedWithStatusCode': return ({required Object code}) => 'プロキシテスト失敗、ステータスコード: ${code}';
			case 'settings.testProxyFailedWithException': return ({required Object exception}) => 'プロキシテスト失敗、例外: ${exception}';
			case 'settings.proxyConfig': return 'プロキシ設定';
			case 'settings.thisIsHttpProxyAddress': return 'ここはhttpプロキシアドレスです';
			case 'settings.checkProxy': return 'プロキシチェック';
			case 'settings.proxyAddress': return 'プロキシアドレス';
			case 'settings.pleaseEnterTheUrlOfTheProxyServerForExample1270018080': return 'プロキシサーバーのURLを入力してください、例えば 127.0.0.1:8080';
			case 'settings.enableProxy': return 'プロキシを有効にする';
			case 'settings.left': return '左';
			case 'settings.middle': return '中';
			case 'settings.right': return '右';
			case 'settings.playerSettings': return 'プレイヤー設定';
			case 'settings.networkSettings': return 'ネットワーク設定';
			case 'settings.customizeYourPlaybackExperience': return '再生体験をカスタマイズ';
			case 'settings.chooseYourFavoriteAppAppearance': return 'お好きなアプリの外観を選択';
			case 'settings.configureYourProxyServer': return 'プロキシサーバーを設定';
			case 'settings.settings': return '設定';
			case 'settings.themeSettings': return 'テーマ設定';
			case 'signIn.pleaseLoginFirst': return 'ログインしてからサインインしてください';
			case 'signIn.alreadySignedInToday': return '今日はすでにサインインしました！';
			case 'signIn.youDidNotStickToTheSignIn': return 'サインインを継続できませんでした。';
			case 'signIn.signInSuccess': return 'サインイン成功！';
			case 'signIn.signInFailed': return 'サインイン失敗、再試行してください';
			case 'signIn.consecutiveSignIns': return '連続サインイン日数';
			case 'signIn.failureReason': return 'サインインを継続できなかった理由';
			case 'signIn.selectDateRange': return '日付範囲を選択';
			case 'signIn.startDate': return '開始日';
			case 'signIn.endDate': return '終了日';
			case 'signIn.invalidDate': return '無効な日付';
			case 'signIn.invalidDateRange': return '無効な日付範囲';
			case 'signIn.errorFormatText': return '日付形式エラー';
			case 'signIn.errorInvalidText': return '無効な日付範囲';
			case 'signIn.errorInvalidRangeText': return '無効な日付範囲';
			case 'signIn.dateRangeCantBeMoreThanOneYear': return '日付範囲は1年を超えてはいけません';
			case 'signIn.signIn': return 'チェックイン';
			case 'signIn.signInRecord': return '着信記録';
			case 'signIn.totalSignIns': return '総成功署名';
			case 'signIn.pleaseSelectSignInStatus': return 'チェックインステータスを選択してください';
			case 'subscriptions.pleaseLoginFirstToViewYourSubscriptions': return 'ログインしてからサブスクリプションを表示してください。';
			case 'videoDetail.videoIdIsEmpty': return 'ビデオIDが空です';
			case 'videoDetail.videoInfoIsEmpty': return 'ビデオ情報が空です';
			case 'videoDetail.thisIsAPrivateVideo': return 'これはプライベートビデオです';
			case 'videoDetail.getVideoInfoFailed': return 'ビデオ情報取得失敗、再試行してください';
			case 'videoDetail.noVideoSourceFound': return 'ビデオソースが見つかりません';
			case 'videoDetail.tagCopiedToClipboard': return ({required Object tagId}) => 'タグ "${tagId}" をクリップボードにコピーしました';
			case 'videoDetail.errorLoadingVideo': return 'ビデオの読み込み中にエラーが発生しました';
			case 'videoDetail.play': return '再生';
			case 'videoDetail.pause': return '一時停止';
			case 'videoDetail.exitAppFullscreen': return 'アプリの全画面を終了';
			case 'videoDetail.enterAppFullscreen': return 'アプリの全画面を開始';
			case 'videoDetail.exitSystemFullscreen': return 'システムの全画面を終了';
			case 'videoDetail.enterSystemFullscreen': return 'システムの全画面を開始';
			case 'videoDetail.seekTo': return '指定時間にジャンプ';
			case 'videoDetail.switchResolution': return '解像度を切り替え';
			case 'videoDetail.switchPlaybackSpeed': return '再生倍速を切り替え';
			case 'videoDetail.rewindSeconds': return ({required Object num}) => '巻き戻し${num}秒';
			case 'videoDetail.fastForwardSeconds': return ({required Object num}) => '早送り${num}秒';
			case 'videoDetail.playbackSpeedIng': return ({required Object rate}) => '再生倍速${rate}倍';
			case 'videoDetail.brightness': return '明るさ';
			case 'videoDetail.brightnessLowest': return '明るさは最低';
			case 'videoDetail.volume': return '音量';
			case 'videoDetail.volumeMuted': return '音量は静音';
			case 'videoDetail.home': return 'ホーム';
			case 'videoDetail.videoPlayer': return 'ビデオプレイヤー';
			case 'videoDetail.videoPlayerInfo': return 'ビデオプレイヤー情報';
			case 'videoDetail.moreSettings': return 'もっと設定';
			case 'videoDetail.videoPlayerFeatureInfo': return 'ビデオプレイヤー機能紹介';
			case 'videoDetail.autoRewind': return '自動巻き戻し';
			case 'videoDetail.rewindAndFastForward': return '左右两侧双击快进或后退';
			case 'videoDetail.volumeAndBrightness': return '左右两侧垂直滑动调整音量、亮度';
			case 'videoDetail.centerAreaDoubleTapPauseOrPlay': return '中心区域双击暂停或播放';
			case 'videoDetail.showVerticalVideoInFullScreen': return '全画面再生時に縦画面で縦画面ビデオを表示';
			case 'videoDetail.keepLastVolumeAndBrightness': return '最後に調整した音量、明るさを保持';
			case 'videoDetail.setProxy': return 'プロキシを設定';
			case 'videoDetail.moreFeaturesToBeDiscovered': return 'もっと機能を発見...';
			case 'videoDetail.videoPlayerSettings': return 'ビデオプレイヤー設定';
			case 'videoDetail.commentCount': return ({required Object num}) => '${num} コメント';
			case 'videoDetail.writeYourCommentHere': return 'コメントを書いてください...';
			case 'videoDetail.authorOtherVideos': return '作者の他のビデオ';
			case 'videoDetail.relatedVideos': return '関連ビデオ';
			default: return null;
		}
	}
}

