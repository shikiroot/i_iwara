import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:i_iwara/app/services/light_service.dart';
import 'package:i_iwara/app/ui/widgets/MDToastWidget.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants.dart';

class CustomMarkdownBody extends StatefulWidget {
  final String data;

  const CustomMarkdownBody({super.key, required this.data});

  @override
  State<CustomMarkdownBody> createState() => _CustomMarkdownBodyState();
}

class _CustomMarkdownBodyState extends State<CustomMarkdownBody> {
  String _displayData = "";

  @override
  void initState() {
    super.initState();
    _displayData = widget.data; // 初始显示原始数据
    _processMarkdown(widget.data);
  }

  @override
  void didUpdateWidget(CustomMarkdownBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      setState(() {
        _displayData = widget.data;
      });
      _processMarkdown(widget.data);
    }
  }

  Future<void> _processMarkdown(String data) async {
    String processed = data;

    // 分步骤处理，每步单独捕获错误
    try {
      processed = await _formatLinks(processed);
    } catch (e) {
      LogUtils.e('格式化链接时发生错误', error: e, tag: 'CustomMarkdownBody');
    }

    try {
      processed = _formatMarkdownLinks(processed);
      setState(() {
        _displayData = processed;
      });
    } catch (e) {
      LogUtils.e('格式化 Markdown 链接时发生错误', error: e, tag: 'CustomMarkdownBody');
    }

    try {
      processed = _formatMentions(processed);
      setState(() {
        _displayData = processed;
      });
    } catch (e) {
      LogUtils.e('格式化提及时发生错误', error: e, tag: 'CustomMarkdownBody');
    }

    try {
      processed = _replaceNewlines(processed);
      setState(() {
        _displayData = processed;
      });
    } catch (e) {
      LogUtils.e('替换换行符时发生错误', error: e, tag: 'CustomMarkdownBody');
    }
  }

  Future<String> _formatLinks(String data) async {
    final patterns = {
      'video': RegExp(
          r'https?://(?:www\.)?iwara\.tv/video/([a-zA-Z0-9]+)(?:/[^\s]*)?',
          caseSensitive: false),
      'forum': RegExp(
          r'https?://(?:www\.)?iwara\.tv/forum/[^/\s]+/([a-zA-Z0-9-]+)',
          caseSensitive: false),
      'image': RegExp(r'https?://(?:www\.)?iwara\.tv/image/([a-zA-Z0-9]+)',
          caseSensitive: false),
      'profile': RegExp(r'https?://(?:www\.)?iwara\.tv/profile/([^/\s]+)',
          caseSensitive: false),
      'playlist': RegExp(
          r'https?://(?:www\.)?iwara\.tv/playlist/([a-zA-Z0-9-]+)',
          caseSensitive: false),
    };

    for (var entry in patterns.entries) {
      data = await _formatLinkType(data, entry.key, entry.value);
    }

    return data;
  }

  Future<String> _formatLinkType(
      String data, String type, RegExp pattern) async {
    final matches = pattern.allMatches(data).toList();
    if (matches.isEmpty) return data;

    for (final match in matches) {
      final id = match.group(1)!;
      final originalUrl = match.group(0)!;

      final info = await _fetchInfo(type, id);

      final emoji = _getEmoji(type);
      final replacement = info.isSuccess
          ? '[$emoji ${info.data}]($originalUrl)'
          : '[$emoji ${type.capitalize} $id]($originalUrl)';

      data = data.replaceAll(originalUrl, replacement);

      // 每处理一个链接后更新显示数据
      setState(() {
        _displayData = data;
      });
    }

    return data;
  }

  Future<ApiResult<String>> _fetchInfo(String type, String id) async {
    LightService? lightService;
    try {
      lightService = Get.find<LightService>();
    } catch (e) {
      LogUtils.e('LightService 未找到', tag: 'CustomMarkdownBody', error: e);
      return ApiResult.fail(t.errors.serviceNotInitialized);
    }

    try {
      switch (type) {
        case 'video':
          return lightService.fetchLightVideoTitle(id);
        case 'forum':
          return lightService.fetchLightForumTitle(id);
        case 'image':
          return lightService.fetchLightImageTitle(id);
        case 'profile':
          final result = await lightService.fetchLightProfile(id);
          if (result.isSuccess && result.data != null) {
            return ApiResult.success(data: result.data!['name'] as String);
          }
          return ApiResult.fail(result.message);
        case 'playlist':
          final result = await lightService.fetchPlaylistInfo(id);
          if (result.isSuccess && result.data != null) {
            return ApiResult.success(data: result.data.toString());
          }
          return ApiResult.fail(result.message);
        default:
          return ApiResult.fail(t.errors.unknownType);
      }
    } catch (e) {
      LogUtils.e('获取信息失败', tag: 'CustomMarkdownBody', error: e);
      return ApiResult.fail(t.errors.errorWhileFetching);
    }
  }

  String _getEmoji(String type) {
    switch (type) {
      case 'video':
        return '🎬';
      case 'forum':
        return '📌';
      case 'image':
        return '🖼️';
      case 'profile':
        return '👤';
      case 'playlist':
        return '🎵';
      default:
        return '❓';
    }
  }

  /// 将文本中的链接格式化为 Markdown 链接
  String _formatMarkdownLinks(String data) {
    // 负向前瞻，确保URL前面不是[文本](
    final linkPattern = RegExp(
      r'(?<!\]\()(\bhttps?://[^\s<]+)',
      caseSensitive: false,
    );

    return data.replaceAllMapped(linkPattern, (match) {
      final url = match.group(0);
      return '[$url]($url)';
    });
  }

  /// 将文本中的换行符替换为两个空格和换行符
  String _replaceNewlines(String data) {
    return data.replaceAll(RegExp(r'\n'), '  \n');
  }

  /// 将文本中的 @ 用户名格式化为 Markdown 链接
  String _formatMentions(String data) {
    final mentionPattern =
        RegExp(r'(?<![\/\w])@([\w\u4e00-\u9fa5]+)'); // 确保 @ 前不是 / 或字母数字字符
    return data.replaceAllMapped(mentionPattern, (match) {
      final mention = match.group(0);
      final username = match.group(1);
      if (username == null) return mention ?? '';
      return '[$mention](https://www.iwara.tv/profile/$username)';
    });
  }

  void _onTapLink(String text, String? href, String title) async {
    if (href == null) return;

    try {
      if (href.startsWith(
          '${CommonConstants.iwaraBaseUrl}${ApiConstants.profilePrefix()}')) {
        final userName = href.split('/').last;
        NaviService.navigateToAuthorProfilePage(userName);
      } else if (href.startsWith(
          '${CommonConstants.iwaraBaseUrl}${ApiConstants.galleryDetail()}')) {
        final imageId = href.split('/').last;
        NaviService.navigateToGalleryDetailPage(imageId);
      } else {
        final uri = Uri.parse(href);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          LogUtils.e('无法打开链接: $href', tag: 'CustomMarkdownBody');
          showToastWidget(MDToastWidget(message: t.errors.errorWhileOpeningLink(link: href), type: MDToastType.error),position: ToastPosition.top);
        }
      }
    } catch (e) {
      LogUtils.e('处理链接点击时发生错误', tag: 'CustomMarkdownBody', error: e);
      showToastWidget(MDToastWidget(message: t.errors.errorWhileOpeningLink(link: href), type: MDToastType.error),position: ToastPosition.top);
    }
  }

  @override
  Widget build(BuildContext context) {
    final markdownStyleSheet = MarkdownStyleSheet.fromTheme(
      Theme.of(context),
    ).copyWith(
      p: Theme.of(context).textTheme.bodyMedium,
      a: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
    );

    return MarkdownBody(
      data: _displayData,
      styleSheet: markdownStyleSheet,
      onTapLink: _onTapLink,
      selectable: true,
      imageBuilder: (uri, title, alt) {
        try {
          final imageUrl = uri.toString();
          final parsedUri = Uri.tryParse(imageUrl);
          if (parsedUri == null || !parsedUri.hasAbsolutePath) {
            throw FormatException(t.errors.invalidUrl);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        } catch (e) {
          LogUtils.e('图片加载失败', tag: 'CustomMarkdownBody', error: e);
          return const Icon(Icons.error);
        }
      },
    );
  }
}
