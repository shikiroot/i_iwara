import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i_iwara/i18n/strings.g.dart' as slang;
import '../../../../../common/constants.dart';

/// 订阅列表选择框
class SubscriptionSelectItem {
  final String id;
  final String label;
  final String avatarUrl;

  SubscriptionSelectItem({
    required this.id,
    required this.label,
    required this.avatarUrl,
  });
}

class SubscriptionSelectList extends StatefulWidget {
  final List<SubscriptionSelectItem> selectionList;
  final String selectedId;
  final Function(String) onIdSelected;

  const SubscriptionSelectList({
    super.key,
    required this.selectionList,
    required this.selectedId,
    required this.onIdSelected,
  });

  @override
  _SubscriptionSelectListState createState() => _SubscriptionSelectListState();
}

class _SubscriptionSelectListState extends State<SubscriptionSelectList> {
  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;

  final allSubscriptionItem = SubscriptionSelectItem(
    id: '',
    label: slang.t.common.all,
    avatarUrl: '',
  );

  void _scrollToPage(bool isLeft) {
    final viewportWidth = _scrollController.position.viewportDimension;
    final currentOffset = _scrollController.offset;
    final targetOffset = isLeft
        ? max(currentOffset - viewportWidth, 0.0)
        : min(currentOffset + viewportWidth,
            _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildIconWithLabel(
                allSubscriptionItem,
                theme,
              ),
            ),
            Expanded(
              child: MouseRegion(
                onEnter: (_) => setState(() => _showButtons = true),
                onExit: (_) => setState(() => _showButtons = false),
                child: Stack(
                  children: [
                    Listener(
                      onPointerSignal: (pointerSignal) {
                        if (pointerSignal is PointerScrollEvent) {
                          final double scrollAmount =
                              pointerSignal.scrollDelta.dy * 2;
                          _scrollController.jumpTo(
                            (_scrollController.offset + scrollAmount).clamp(
                              0.0,
                              _scrollController.position.maxScrollExtent,
                            ),
                          );
                        }
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: widget.selectionList
                              .map((item) => _buildIconWithLabel(item, theme))
                              .toList(),
                        ),
                      ),
                    ),
                    if (_showButtons) ..._buildScrollButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScrollButtons() {
    return [
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: _buildScrollButton(true),
        ),
      ),
      Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: _buildScrollButton(false),
        ),
      ),
    ];
  }

  Widget _buildScrollButton(bool isLeft) {
    return AnimatedOpacity(
      opacity: _showButtons ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _scrollToPage(isLeft),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isLeft ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithLabel(
    SubscriptionSelectItem selectItem,
    ThemeData theme,
  ) {
    final bool isSelected = widget.selectedId == selectItem.id;
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () => {
          if (widget.selectedId != selectItem.id)
            widget.onIdSelected(selectItem.id)
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectItem.avatarUrl.isEmpty)
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isSelected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  child: Icon(
                    Icons.cloud,
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                    size: 20,
                  ),
                )
              else
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isSelected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: selectItem.avatarUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      httpHeaders: const {
                        'referer': CommonConstants.iwaraBaseUrl
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                selectItem.label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyMedium?.color,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
