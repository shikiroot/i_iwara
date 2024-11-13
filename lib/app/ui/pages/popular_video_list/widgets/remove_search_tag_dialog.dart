import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/models/tag.model.dart';

class RemoveSearchTagDialog extends StatefulWidget {
  final Function(List<String>) onRemoveIds;
  final RxList<Tag> videoSearchTagHistory;

  const RemoveSearchTagDialog({super.key, required this.onRemoveIds, required this.videoSearchTagHistory});

  @override
  _RemoveSearchTagDialogState createState() => _RemoveSearchTagDialogState();
}

class _RemoveSearchTagDialogState extends State<RemoveSearchTagDialog> {
  Set<String> selectedIds = <String>{};

  // 用于记录拖拽选择的起始和结束位置
  Offset? dragStart;
  Offset? dragCurrent;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // 设置圆角
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1200,
          minWidth: 400,
          maxHeight: 800,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('移除标签', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  // 切换全选或取消全选
                  Stack(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedIds.length ==
                              widget.videoSearchTagHistory
                                  .length) {
                            setState(() {
                              selectedIds.clear();
                            });
                          } else {
                            setState(() {
                              selectedIds.addAll(
                                  widget.videoSearchTagHistory
                                      .map((e) => e.id));
                            });
                          }
                        },
                        child: Text(selectedIds.length ==
                            widget.videoSearchTagHistory.length
                            ? '取消全选'
                            : '全选'),
                      ),
                      if (selectedIds.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${selectedIds.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // 删除
                  ElevatedButton(
                    onPressed: () => _deleteSelected(),
                    child: const Text('删除'),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    dragStart = details.localPosition;
                    dragCurrent = dragStart;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    dragCurrent = details.localPosition;
                    _updateSelection();
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    dragStart = null;
                    dragCurrent = null;
                  });
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 根据需要调整
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 5, // 调整标签宽高比
                        ),
                        itemCount: widget.videoSearchTagHistory
                            .length,
                        itemBuilder: (context, index) {
                          Tag tag = widget
                              .videoSearchTagHistory[index];
                          bool isSelected = selectedIds.contains(tag.id);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedIds.remove(tag.id);
                                } else {
                                  selectedIds.add(tag.id);
                                }
                              });
                            },
                            child: Chip(
                              label: Text(tag.id),
                              backgroundColor: isSelected ? Theme
                                  .of(context)
                                  .primaryColor : Colors.grey[200],
                              labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : Colors
                                      .black),
                            ),
                          );
                        },
                      ),
                    ),
                    // 绘制选择矩形
                    if (dragStart != null && dragCurrent != null)
                      Positioned.fill(
                        child: CustomPaint(
                          painter: SelectionPainter(
                            start: dragStart!,
                            end: dragCurrent!,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelection() {
    if (dragStart == null || dragCurrent == null) return;

    // 获取选择区域的矩形
    Rect selectionRect = Rect.fromPoints(dragStart!, dragCurrent!);
    Set<String> newSelectedIds = {};

    // 遍历所有标签，判断是否在选择区域内
    for (var tag in widget.videoSearchTagHistory) {
      // 通过标签在 GridView 中的索引和 GridView 的布局信息计算位置
      int index = widget.videoSearchTagHistory.indexOf(tag);
      int crossAxisCount = 3; // 与 GridView 中的 crossAxisCount 保持一致
      double spacing = 8.0;
      double padding = 8.0;

      // 计算行列
      int row = index ~/ crossAxisCount;
      int column = index % crossAxisCount;

      // 假设每个标签的宽度和高度相同
      double tagWidth = (MediaQuery
          .of(context)
          .size
          .width - padding * 2 - spacing * (crossAxisCount - 1)) /
          crossAxisCount;
      double tagHeight = 40.0; // 根据 childAspectRatio 和实际情况调整

      // 计算标签的位置
      double left = padding + column * (tagWidth + spacing);
      double top = padding + row * (tagHeight + spacing);

      Rect tagRect = Rect.fromLTWH(left, top, tagWidth, tagHeight);

      if (selectionRect.overlaps(tagRect)) {
        newSelectedIds.add(tag.id);
      }
    }

    setState(() {
      selectedIds.addAll(newSelectedIds);
    });
  }

  void _deleteSelected() {
    if (selectedIds.isEmpty) return;
    widget.onRemoveIds(selectedIds.toList());
    setState(() {
      selectedIds.clear();
    });
  }
}

class SelectionPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  SelectionPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromPoints(start, end);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant SelectionPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
