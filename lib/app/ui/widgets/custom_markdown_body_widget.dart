import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants.dart';
import '../../routes/app_routes.dart';

class CustomMarkdownBody extends StatelessWidget {
  final String data;

  const CustomMarkdownBody({super.key, required this.data});

  String processMarkdown(String data) {
    data = formatMarkdownLinks(data);
    data = formatMentions(data);
    data = replaceNewlines(data);
    return data;
  }

  /// 将文本中的链接格式化为 Markdown 链接
  String formatMarkdownLinks(String data) {
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
  String replaceNewlines(String data) {
    return data.replaceAll(RegExp(r'\n'), '  \n');
  }

  /// 将文本中的 @ 用户名格式化为 Markdown 链接
  String formatMentions(String data) {
    final mentionPattern = RegExp(r'(?<!\/)@([\w\u4e00-\u9fa5]+)'); // 怎么会有url
    return data.replaceAllMapped(mentionPattern, (match) {
      final mention = match.group(0);
      return '[$mention](${CommonConstants.iwaraBaseUrl}/${ApiConstants.profilePrefix}/${match.group(1)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    final markdownStyleSheet = MarkdownStyleSheet.fromTheme(
      Theme.of(context),
    );

    return MarkdownBody(
      data: processMarkdown(data),
      styleSheet: markdownStyleSheet,
      onTapLink: (text, href, title) {
        if (href != null) {
          // 如果是profile页，则直接跳转应用内的profile页
          if (href.contains(ApiConstants.profilePrefix())) {
            final userName = href.split('/').last;
            context.delegate.toNamed(
              Routes.AUTHOR_PROFILE(userName),
              preventDuplicates: false,
            );
          } else {
            launchUrl(Uri.parse(href));
          }
        }
      },
      selectable: true,
      imageBuilder: (uri, title, alt) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CachedNetworkImage(
            imageUrl: uri.toString(),
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
      },
    );
  }
}
