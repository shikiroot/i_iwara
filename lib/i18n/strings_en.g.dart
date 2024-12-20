///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn._(_root);
	late final TranslationsFriendsEn friends = TranslationsFriendsEn._(_root);
	late final TranslationsAuthorProfileEn authorProfile = TranslationsAuthorProfileEn._(_root);
	late final TranslationsFavoritesEn favorites = TranslationsFavoritesEn._(_root);
	late final TranslationsGalleryDetailEn galleryDetail = TranslationsGalleryDetailEn._(_root);
	late final TranslationsPlayListEn playList = TranslationsPlayListEn._(_root);
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appName => 'Love Iwara';
	String get ok => 'OK';
	String get cancel => 'Cancel';
	String get save => 'Save';
	String get delete => 'Delete';
	String get loading => 'Loading...';
	String get privacyHint => 'Privacy content, not displayed';
	String get latest => 'Latest';
	String get likesCount => 'Likes';
	String get viewsCount => 'Views';
	String get popular => 'Popular';
	String get trending => 'Trending';
	String get commentList => 'Comment List';
	String get sendComment => 'Send Comment';
	String get send => 'Send';
	String get retry => 'Retry';
	String get premium => 'Premium';
	String get follower => 'Follower';
	String get friend => 'Friend';
	String get video => 'Video';
	String get following => 'Following';
	String get cancelFriendRequest => 'Cancel Request';
	String get addFriend => 'Add Friend';
	String get removeFriend => 'Remove Friend';
	String get followed => 'Followed';
	String get follow => 'Follow';
	String get specialFollow => 'Special Follow';
	String get specialFollowed => 'Special Followed';
	String get gallery => 'Gallery';
	String get playlist => 'Playlist';
	String get commentPostedSuccessfully => 'Comment Posted Successfully';
	String get commentPostedFailed => 'Comment Posted Failed';
	String get success => 'Success';
	String get commentDeletedSuccessfully => 'Comment Deleted Successfully';
	String get commentUpdatedSuccessfully => 'Comment Updated Successfully';
	String totalComments({required Object count}) => '${count} Comments';
	String get writeYourCommentHere => 'Write your comment here...';
	String get tmpNoReplies => 'No replies yet';
	String get loadMore => 'Load More';
	String get noMoreDatas => 'No more data';
	String get selectTranslationLanguage => 'Select Translation Language';
	String get translate => 'Translate';
	String get translateFailedPleaseTryAgainLater => 'Translate failed, please try again later';
	String get translationResult => 'Translation Result';
	String get justNow => 'Just Now';
	String minutesAgo({required Object num}) => '${num} minutes ago';
	String hoursAgo({required Object num}) => '${num} hours ago';
	String daysAgo({required Object num}) => '${num} days ago';
	String editedAt({required Object num}) => 'Edited at ${num} ago';
	String get editComment => 'Edit Comment';
	String get commentUpdated => 'Comment Updated';
	String get replyComment => 'Reply Comment';
	String get reply => 'Reply';
	String get edit => 'Edit';
	String get unknownUser => 'Unknown User';
	String get me => 'Me';
	String get author => 'Author';
	String get admin => 'Admin';
	String viewReplies({required Object num}) => 'View Replies (${num})';
	String get hideReplies => 'Hide Replies';
	String get confirmDelete => 'Confirm Delete';
	String get areYouSureYouWantToDeleteThisItem => 'Are you sure you want to delete this item?';
	String get tmpNoComments => 'No comments yet';
	String get refresh => 'Refresh';
	String get back => 'Back';
	String get tips => 'Tips';
	String get linkIsEmpty => 'Link is empty';
	String get linkCopiedToClipboard => 'Link copied to clipboard';
	String get imageCopiedToClipboard => 'Image copied to clipboard';
	String get copyImageFailed => 'Copy image failed';
	String get mobileSaveImageIsUnderDevelopment => 'Mobile save image is under development';
	String get imageSavedTo => 'Image saved to';
	String get saveImageFailed => 'Save image failed';
	String get close => 'Close';
	String get more => 'More';
	String get moreFeaturesToBeDeveloped => 'More features to be developed';
	String get all => 'All';
	String selectedRecords({required Object num}) => 'Selected ${num} records';
	String get cancelSelectAll => 'Cancel Select All';
	String get selectAll => 'Select All';
	String get exitEditMode => 'Exit Edit Mode';
	String areYouSureYouWantToDeleteSelectedItems({required Object num}) => 'Are you sure you want to delete selected ${num} items?';
	String get searchHistoryRecords => 'Search History Records...';
	String get settings => 'Settings';
	String get subscriptions => 'Subscriptions';
	String videoCount({required Object num}) => '${num} videos';
	String get share => 'Share';
	String get areYouSureYouWantToShareThisPlaylist => 'Are you sure you want to share this playlist?';
	String get editTitle => 'Edit Title';
	String get editMode => 'Edit Mode';
	String get pleaseEnterNewTitle => 'Please enter new title';
	String get createPlayList => 'Create Play List';
	String get create => 'Create';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Login';
	String get logout => 'Logout';
	String get email => 'Email';
	String get password => 'Password';
	String get loginOrRegister => 'Login / Register';
	String get register => 'Register';
	String get pleaseEnterEmail => 'Please enter email';
	String get pleaseEnterPassword => 'Please enter password';
	String get passwordMustBeAtLeast6Characters => 'Password must be at least 6 characters';
	String get pleaseEnterCaptcha => 'Please enter captcha';
	String get captcha => 'Captcha';
	String get refreshCaptcha => 'Refresh Captcha';
	String get captchaNotLoaded => 'Captcha not loaded';
	String get loginSuccess => 'Login Success';
	String get emailVerificationSent => 'Email verification sent';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get error => 'Error';
	String get required => 'This field is required';
	String get invalidEmail => 'Invalid email address';
	String get networkError => 'Network error, please try again';
	String get errorWhileFetching => 'Error while fetching';
	String get commentCanNotBeEmpty => 'Comment content cannot be empty';
	String get errorWhileFetchingReplies => 'Error while fetching replies, please check network connection';
	String get canNotFindCommentController => 'Can not find comment controller';
	String get errorWhileLoadingGallery => 'Error while loading gallery';
	String get howCouldThereBeNoDataItCantBePossible => 'How could there be no data? It can\'t be possible :<';
	String unsupportedImageFormat({required Object str}) => 'Unsupported image format: ${str}';
	String get invalidGalleryId => 'Invalid gallery ID';
}

// Path: friends
class TranslationsFriendsEn {
	TranslationsFriendsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get clickToRestoreFriend => 'Click to restore friend';
	String get friendsList => 'Friends List';
	String get friendRequests => 'Friend Requests';
	String get friendRequestsList => 'Friend Requests List';
}

// Path: authorProfile
class TranslationsAuthorProfileEn {
	TranslationsAuthorProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get noMoreDatas => 'No more data';
	String get userProfile => 'User Profile';
}

// Path: favorites
class TranslationsFavoritesEn {
	TranslationsFavoritesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get clickToRestoreFavorite => 'Click to restore favorite';
	String get myFavorites => 'My Favorites';
}

// Path: galleryDetail
class TranslationsGalleryDetailEn {
	TranslationsGalleryDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get copyLink => 'Copy Link';
	String get copyImage => 'Copy Image';
	String get saveAs => 'Save As';
	String get saveToAlbum => 'Save to Album';
	String get publishedAt => 'Published At';
	String get viewsCount => 'Views Count';
	String get imageLibraryFunctionIntroduction => 'Image Library Function Introduction';
	String get rightClickToSaveSingleImage => 'Right Click to Save Single Image';
	String get batchSave => 'Batch Save';
	String get keyboardLeftAndRightToSwitch => 'Keyboard Left and Right to Switch';
	String get keyboardUpAndDownToZoom => 'Keyboard Up and Down to Zoom';
	String get mouseWheelToSwitch => 'Mouse Wheel to Switch';
	String get ctrlAndMouseWheelToZoom => 'CTRL + Mouse Wheel to Zoom';
	String get moreFeaturesToBeDiscovered => 'More Features to Be Discovered...';
	String get authorOtherGalleries => 'Author\'s Other Galleries';
	String get relatedGalleries => 'Related Galleries';
}

// Path: playList
class TranslationsPlayListEn {
	TranslationsPlayListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get myPlayList => 'My Play List';
	String get friendlyTips => 'Friendly Tips';
	String get dearUser => 'Dear User';
	String get iwaraPlayListSystemIsNotPerfectYet => 'iwara\'s play list system is not perfect yet';
	String get notSupportSetCover => 'Not support set cover';
	String get notSupportDeleteList => 'Not support delete list';
	String get notSupportSetPrivate => 'Not support set private';
	String get yesCreateListWillAlwaysExistAndVisibleToEveryone => 'Yes... create list will always exist and visible to everyone';
	String get smallSuggestion => 'Small Suggestion';
	String get useLikeToCollectContent => 'If you are more concerned about privacy, it is recommended to use the "like" function to collect content';
	String get welcomeToDiscussOnGitHub => 'If you have other suggestions or ideas, welcome to discuss on GitHub!';
	String get iUnderstand => 'I Understand';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.appName': return 'Love Iwara';
			case 'common.ok': return 'OK';
			case 'common.cancel': return 'Cancel';
			case 'common.save': return 'Save';
			case 'common.delete': return 'Delete';
			case 'common.loading': return 'Loading...';
			case 'common.privacyHint': return 'Privacy content, not displayed';
			case 'common.latest': return 'Latest';
			case 'common.likesCount': return 'Likes';
			case 'common.viewsCount': return 'Views';
			case 'common.popular': return 'Popular';
			case 'common.trending': return 'Trending';
			case 'common.commentList': return 'Comment List';
			case 'common.sendComment': return 'Send Comment';
			case 'common.send': return 'Send';
			case 'common.retry': return 'Retry';
			case 'common.premium': return 'Premium';
			case 'common.follower': return 'Follower';
			case 'common.friend': return 'Friend';
			case 'common.video': return 'Video';
			case 'common.following': return 'Following';
			case 'common.cancelFriendRequest': return 'Cancel Request';
			case 'common.addFriend': return 'Add Friend';
			case 'common.removeFriend': return 'Remove Friend';
			case 'common.followed': return 'Followed';
			case 'common.follow': return 'Follow';
			case 'common.specialFollow': return 'Special Follow';
			case 'common.specialFollowed': return 'Special Followed';
			case 'common.gallery': return 'Gallery';
			case 'common.playlist': return 'Playlist';
			case 'common.commentPostedSuccessfully': return 'Comment Posted Successfully';
			case 'common.commentPostedFailed': return 'Comment Posted Failed';
			case 'common.success': return 'Success';
			case 'common.commentDeletedSuccessfully': return 'Comment Deleted Successfully';
			case 'common.commentUpdatedSuccessfully': return 'Comment Updated Successfully';
			case 'common.totalComments': return ({required Object count}) => '${count} Comments';
			case 'common.writeYourCommentHere': return 'Write your comment here...';
			case 'common.tmpNoReplies': return 'No replies yet';
			case 'common.loadMore': return 'Load More';
			case 'common.noMoreDatas': return 'No more data';
			case 'common.selectTranslationLanguage': return 'Select Translation Language';
			case 'common.translate': return 'Translate';
			case 'common.translateFailedPleaseTryAgainLater': return 'Translate failed, please try again later';
			case 'common.translationResult': return 'Translation Result';
			case 'common.justNow': return 'Just Now';
			case 'common.minutesAgo': return ({required Object num}) => '${num} minutes ago';
			case 'common.hoursAgo': return ({required Object num}) => '${num} hours ago';
			case 'common.daysAgo': return ({required Object num}) => '${num} days ago';
			case 'common.editedAt': return ({required Object num}) => 'Edited at ${num} ago';
			case 'common.editComment': return 'Edit Comment';
			case 'common.commentUpdated': return 'Comment Updated';
			case 'common.replyComment': return 'Reply Comment';
			case 'common.reply': return 'Reply';
			case 'common.edit': return 'Edit';
			case 'common.unknownUser': return 'Unknown User';
			case 'common.me': return 'Me';
			case 'common.author': return 'Author';
			case 'common.admin': return 'Admin';
			case 'common.viewReplies': return ({required Object num}) => 'View Replies (${num})';
			case 'common.hideReplies': return 'Hide Replies';
			case 'common.confirmDelete': return 'Confirm Delete';
			case 'common.areYouSureYouWantToDeleteThisItem': return 'Are you sure you want to delete this item?';
			case 'common.tmpNoComments': return 'No comments yet';
			case 'common.refresh': return 'Refresh';
			case 'common.back': return 'Back';
			case 'common.tips': return 'Tips';
			case 'common.linkIsEmpty': return 'Link is empty';
			case 'common.linkCopiedToClipboard': return 'Link copied to clipboard';
			case 'common.imageCopiedToClipboard': return 'Image copied to clipboard';
			case 'common.copyImageFailed': return 'Copy image failed';
			case 'common.mobileSaveImageIsUnderDevelopment': return 'Mobile save image is under development';
			case 'common.imageSavedTo': return 'Image saved to';
			case 'common.saveImageFailed': return 'Save image failed';
			case 'common.close': return 'Close';
			case 'common.more': return 'More';
			case 'common.moreFeaturesToBeDeveloped': return 'More features to be developed';
			case 'common.all': return 'All';
			case 'common.selectedRecords': return ({required Object num}) => 'Selected ${num} records';
			case 'common.cancelSelectAll': return 'Cancel Select All';
			case 'common.selectAll': return 'Select All';
			case 'common.exitEditMode': return 'Exit Edit Mode';
			case 'common.areYouSureYouWantToDeleteSelectedItems': return ({required Object num}) => 'Are you sure you want to delete selected ${num} items?';
			case 'common.searchHistoryRecords': return 'Search History Records...';
			case 'common.settings': return 'Settings';
			case 'common.subscriptions': return 'Subscriptions';
			case 'common.videoCount': return ({required Object num}) => '${num} videos';
			case 'common.share': return 'Share';
			case 'common.areYouSureYouWantToShareThisPlaylist': return 'Are you sure you want to share this playlist?';
			case 'common.editTitle': return 'Edit Title';
			case 'common.editMode': return 'Edit Mode';
			case 'common.pleaseEnterNewTitle': return 'Please enter new title';
			case 'common.createPlayList': return 'Create Play List';
			case 'common.create': return 'Create';
			case 'auth.login': return 'Login';
			case 'auth.logout': return 'Logout';
			case 'auth.email': return 'Email';
			case 'auth.password': return 'Password';
			case 'auth.loginOrRegister': return 'Login / Register';
			case 'auth.register': return 'Register';
			case 'auth.pleaseEnterEmail': return 'Please enter email';
			case 'auth.pleaseEnterPassword': return 'Please enter password';
			case 'auth.passwordMustBeAtLeast6Characters': return 'Password must be at least 6 characters';
			case 'auth.pleaseEnterCaptcha': return 'Please enter captcha';
			case 'auth.captcha': return 'Captcha';
			case 'auth.refreshCaptcha': return 'Refresh Captcha';
			case 'auth.captchaNotLoaded': return 'Captcha not loaded';
			case 'auth.loginSuccess': return 'Login Success';
			case 'auth.emailVerificationSent': return 'Email verification sent';
			case 'errors.error': return 'Error';
			case 'errors.required': return 'This field is required';
			case 'errors.invalidEmail': return 'Invalid email address';
			case 'errors.networkError': return 'Network error, please try again';
			case 'errors.errorWhileFetching': return 'Error while fetching';
			case 'errors.commentCanNotBeEmpty': return 'Comment content cannot be empty';
			case 'errors.errorWhileFetchingReplies': return 'Error while fetching replies, please check network connection';
			case 'errors.canNotFindCommentController': return 'Can not find comment controller';
			case 'errors.errorWhileLoadingGallery': return 'Error while loading gallery';
			case 'errors.howCouldThereBeNoDataItCantBePossible': return 'How could there be no data? It can\'t be possible :<';
			case 'errors.unsupportedImageFormat': return ({required Object str}) => 'Unsupported image format: ${str}';
			case 'errors.invalidGalleryId': return 'Invalid gallery ID';
			case 'friends.clickToRestoreFriend': return 'Click to restore friend';
			case 'friends.friendsList': return 'Friends List';
			case 'friends.friendRequests': return 'Friend Requests';
			case 'friends.friendRequestsList': return 'Friend Requests List';
			case 'authorProfile.noMoreDatas': return 'No more data';
			case 'authorProfile.userProfile': return 'User Profile';
			case 'favorites.clickToRestoreFavorite': return 'Click to restore favorite';
			case 'favorites.myFavorites': return 'My Favorites';
			case 'galleryDetail.copyLink': return 'Copy Link';
			case 'galleryDetail.copyImage': return 'Copy Image';
			case 'galleryDetail.saveAs': return 'Save As';
			case 'galleryDetail.saveToAlbum': return 'Save to Album';
			case 'galleryDetail.publishedAt': return 'Published At';
			case 'galleryDetail.viewsCount': return 'Views Count';
			case 'galleryDetail.imageLibraryFunctionIntroduction': return 'Image Library Function Introduction';
			case 'galleryDetail.rightClickToSaveSingleImage': return 'Right Click to Save Single Image';
			case 'galleryDetail.batchSave': return 'Batch Save';
			case 'galleryDetail.keyboardLeftAndRightToSwitch': return 'Keyboard Left and Right to Switch';
			case 'galleryDetail.keyboardUpAndDownToZoom': return 'Keyboard Up and Down to Zoom';
			case 'galleryDetail.mouseWheelToSwitch': return 'Mouse Wheel to Switch';
			case 'galleryDetail.ctrlAndMouseWheelToZoom': return 'CTRL + Mouse Wheel to Zoom';
			case 'galleryDetail.moreFeaturesToBeDiscovered': return 'More Features to Be Discovered...';
			case 'galleryDetail.authorOtherGalleries': return 'Author\'s Other Galleries';
			case 'galleryDetail.relatedGalleries': return 'Related Galleries';
			case 'playList.myPlayList': return 'My Play List';
			case 'playList.friendlyTips': return 'Friendly Tips';
			case 'playList.dearUser': return 'Dear User';
			case 'playList.iwaraPlayListSystemIsNotPerfectYet': return 'iwara\'s play list system is not perfect yet';
			case 'playList.notSupportSetCover': return 'Not support set cover';
			case 'playList.notSupportDeleteList': return 'Not support delete list';
			case 'playList.notSupportSetPrivate': return 'Not support set private';
			case 'playList.yesCreateListWillAlwaysExistAndVisibleToEveryone': return 'Yes... create list will always exist and visible to everyone';
			case 'playList.smallSuggestion': return 'Small Suggestion';
			case 'playList.useLikeToCollectContent': return 'If you are more concerned about privacy, it is recommended to use the "like" function to collect content';
			case 'playList.welcomeToDiscussOnGitHub': return 'If you have other suggestions or ideas, welcome to discuss on GitHub!';
			case 'playList.iUnderstand': return 'I Understand';
			default: return null;
		}
	}
}

