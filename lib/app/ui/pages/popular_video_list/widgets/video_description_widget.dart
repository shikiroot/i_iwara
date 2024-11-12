import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_markdown_body_widget.dart';

class VideoDescriptionWidget extends StatelessWidget {
  final String? description;
  final RxBool isDescriptionExpanded;
  final VoidCallback onToggleDescription;
  final int defaultMaxLines;

  const VideoDescriptionWidget({
    super.key,
    required this.description,
    required this.isDescriptionExpanded,
    required this.onToggleDescription,
    this.defaultMaxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    // 获取当前主题的文本样式，以动态计算行高
    final textStyle = Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 14.0);
    final lineHeight = textStyle.height ?? 1.2; // 默认行高为1.2

    return Obx(() {
      final expanded = isDescriptionExpanded.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 使用 ClipRect 和 AnimatedContainer 来限制高度并裁剪内容
          ClipRect(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // 根据是否展开，设置高度
              height: expanded ? null : (textStyle.fontSize ?? 14.0) * lineHeight * defaultMaxLines,
              child: SingleChildScrollView(
                // 禁用滚动，以防止展开状态下出现滚动条
                physics: expanded ? null : const NeverScrollableScrollPhysics(),
                child: CustomMarkdownBody(data: description ?? ''),
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
              onPressed: onToggleDescription,
            ),
          ),
        ],
      );
    });
  }
}
