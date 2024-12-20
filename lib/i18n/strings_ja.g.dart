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
	@override String get addFriend => 'フレンド追加';
	@override String get removeFriend => 'フレンド解除';
	@override String get followed => 'フォロー済み';
	@override String get follow => 'フォロー';
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
}

// Path: auth
class _TranslationsAuthJa implements TranslationsAuthEn {
	_TranslationsAuthJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
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
			case 'common.addFriend': return 'フレンド追加';
			case 'common.removeFriend': return 'フレンド解除';
			case 'common.followed': return 'フォロー済み';
			case 'common.follow': return 'フォロー';
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
			default: return null;
		}
	}
}

