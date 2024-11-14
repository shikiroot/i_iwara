import 'package:flutter/material.dart';

import '../../../../models/tag.model.dart';

class ExpandableTagsWidget extends StatefulWidget {
  final List<Tag> tags;
  final int initialVisibleCount;
  final double horizontalPadding;
  final double spacing;
  final double runSpacing;

  const ExpandableTagsWidget({
    super.key,
    required this.tags,
    this.initialVisibleCount = 5,
    this.horizontalPadding = 16.0,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
  });

  @override
  _ExpandableTagsWidgetState createState() => _ExpandableTagsWidgetState();
}

class _ExpandableTagsWidgetState extends State<ExpandableTagsWidget>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 如果标签数量不超过初始可见数量，则不需要展开
    _expanded = widget.tags.length <= widget.initialVisibleCount;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    if (_expanded) {
      _animationController.value = 1.0; // 初始化为展开状态
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _animationController.forward(); // 展开动画
      } else {
        _animationController.reverse(); // 收起动画
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tags.isEmpty) {
      return const SizedBox.shrink(); // 如果没有标签，返回空视图
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          child: Wrap(
            spacing: widget.spacing,
            runSpacing: widget.runSpacing,
            children: [
              // 显示初始可见数量的标签
              ...widget.tags
                  .take(widget.initialVisibleCount)
                  .map((tag) => Chip(
                label: Text(tag.id ?? ''),
              )),
              // 如果标签数量超过初始可见数量，显示隐藏的标签
              if (widget.tags.length > widget.initialVisibleCount)
                SizeTransition(
                  sizeFactor: _animation,
                  axisAlignment: -1.0,
                  child: Wrap(
                    spacing: widget.spacing,
                    runSpacing: widget.runSpacing,
                    children: widget.tags
                        .skip(widget.initialVisibleCount)
                        .map((tag) => Chip(
                      label: Text(tag.id ?? ''),
                    ))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
        // 只有在标签数量超过初始可见数量时才显示切换按钮
        if (widget.tags.length > widget.initialVisibleCount)
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _toggleExpanded,
                  icon: AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
