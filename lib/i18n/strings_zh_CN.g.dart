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
	@override String welcome({required Object name}) => '欢迎，${name}！';
}

// Path: errors
class _TranslationsErrorsZhCn implements TranslationsErrorsEn {
	_TranslationsErrorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get required => '此项必填';
	@override String get invalidEmail => '邮箱格式不正确';
	@override String get networkError => '网络错误，请重试';
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
			case 'auth.login': return '登录';
			case 'auth.logout': return '退出登录';
			case 'auth.email': return '邮箱';
			case 'auth.password': return '密码';
			case 'auth.welcome': return ({required Object name}) => '欢迎，${name}！';
			case 'errors.required': return '此项必填';
			case 'errors.invalidEmail': return '邮箱格式不正确';
			case 'errors.networkError': return '网络错误，请重试';
			default: return null;
		}
	}
}

