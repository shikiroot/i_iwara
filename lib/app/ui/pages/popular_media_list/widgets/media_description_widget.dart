import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/services/config_service.dart';
import 'package:i_iwara/app/services/translation_service.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;

import '../../../widgets/custom_markdown_body_widget.dart';

class MediaDescriptionWidget extends StatefulWidget {
  final String? description;
  final RxBool isDescriptionExpanded;
  final int defaultMaxLines;

  const MediaDescriptionWidget({
    super.key,
    required this.description,
    required this.isDescriptionExpanded,
    this.defaultMaxLines = 3,
  });

  @override
  State<MediaDescriptionWidget> createState() => _MediaDescriptionWidgetState();
}

class _MediaDescriptionWidgetState extends State<MediaDescriptionWidget> {
  bool _showTranslationMenu = false;
  bool _isTranslating = false;
  String? _translatedText;

  final TranslationService _translationService = Get.find();
  final ConfigService _configService = Get.find();

  Widget _buildTranslationButton(BuildContext context) {
    final t = slang.Translations.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 左侧翻译按钮
          Flexible(
            child: InkWell(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              onTap: _isTranslating ? null : () => _handleTranslation(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isTranslating)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      const Icon(Icons.translate, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      t.common.translate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 分割线
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          // 右侧下拉按钮
          InkWell(
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
            onTap: () => setState(() => _showTranslationMenu = !_showTranslationMenu),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                _showTranslationMenu ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationMenu() {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: CommonConstants.translationSorts.map((sort) {
          final isSelected = sort.id == _configService.currentTranslationSort.id;
          return ListTile(
            dense: true,
            selected: isSelected,
            title: Text(sort.label),
            onTap: () {
              _configService.updateTranslationLanguage(sort);
              setState(() {
                _showTranslationMenu = false;
                _translatedText = null;
              });
              _handleTranslation();
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _handleTranslation() async {
    if (_isTranslating) return;

    setState(() => _isTranslating = true);

    ApiResult<String> result = await _translationService.translate(widget.description ?? '');
    if (result.isSuccess) {
      setState(() {
        _translatedText = result.data;
        _isTranslating = false;
      });
    } else {
      setState(() {
        _translatedText = slang.t.errors.translationFailedPleaseTryAgainLater;
        _isTranslating = false;
      });
    }
  }

  Widget _buildTranslatedContent(BuildContext context) {
    final t = slang.Translations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.translate, size: 14),
              const SizedBox(width: 4),
              Text(
                t.common.translationResult,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                'Powered by Google',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_translatedText == t.errors.translationFailedPleaseTryAgainLater)
            Text(
              _translatedText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 14,
              ),
            )
          else
            CustomMarkdownBody(data: _translatedText!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前主题的文本样式，以动态计算行高
    final textStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 14.0);
    final lineHeight = textStyle.height ?? 1.2; // 默认行高为1.2
    final t = slang.Translations.of(context);

    return Obx(() {
      final expanded = widget.isDescriptionExpanded.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.mediaList.personalIntroduction,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTranslationButton(context),
            ],
          ),
          if (_showTranslationMenu)
            Align(
              alignment: Alignment.centerRight,
              child: _buildTranslationMenu(),
            ),
          const SizedBox(height: 8),
          // 使用 ClipRect 和 AnimatedContainer 来限制高度并裁剪内容
          ClipRect(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // 根据是否展开，设置高度
              height: expanded ? null : (textStyle.fontSize ?? 14.0) * lineHeight * widget.defaultMaxLines,
              child: SingleChildScrollView(
                // 禁用滚动，以防止展开状态下出现滚动条
                physics: expanded ? null : const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomMarkdownBody(data: widget.description ?? ''),
                    if (_translatedText != null) ...[
                      const SizedBox(height: 12),
                      _buildTranslatedContent(context),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // 展开/收起按钮
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: AnimatedRotation(
                turns: expanded ? 0.5 : 0.0, // 旋转图标
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
              onPressed: widget.isDescriptionExpanded.toggle,
            ),
          ),
        ],
      );
    });
  }
}
