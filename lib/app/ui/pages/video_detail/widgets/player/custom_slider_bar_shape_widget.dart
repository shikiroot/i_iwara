import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/common_utils.dart';
import '../../controllers/my_video_state_controller.dart';

/// 自定义的视频进度条组件
class CustomVideoProgressbar extends StatefulWidget {
  final MyVideoStateController controller;

  const CustomVideoProgressbar({super.key, required this.controller});

  @override
  _CustomVideoProgressbarState createState() => _CustomVideoProgressbarState();
}

class _CustomVideoProgressbarState extends State<CustomVideoProgressbar> {
  // 临时值，用于存储用户拖动的滑动条值（以秒为单位）
  double? _draggingValue;
  bool _dragging = false;

  // 用于存储悬停或长按的滑动条值（以秒为单位）
  double? _hoverValue;

  // 用于存储悬停或长按的像素位置，用于定位标签
  double? _hoverPosition;

  // GlobalKey 用于获取滑动条的 RenderBox
  final GlobalKey _sliderKey = GlobalKey();

  // 用于判断当前是否为移动端
  bool get isMobile =>
      GetPlatform.isAndroid || GetPlatform.isIOS || GetPlatform.isFuchsia;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          // 仅在移动端处理长按事件
          onLongPressStart: isMobile
              ? (details) {
                  _handleLongPress(details.globalPosition);
                }
              : null,
          onLongPressMoveUpdate: isMobile
              ? (details) {
                  _handleLongPress(details.globalPosition);
                }
              : null,
          onLongPressEnd: isMobile
              ? (details) {
                  setState(() {
                    _hoverValue = null;
                    _hoverPosition = null;
                  });
                }
              : null,
          child: MouseRegion(
            // 当鼠标进入滑动条区域时
            onEnter: isMobile
                ? null
                : (event) {
                    // 可以选择在进入时执行某些操作
                  },
            // 当鼠标离开滑动条区域时
            onExit: isMobile
                ? null
                : (event) {
                    setState(() {
                      _hoverValue = null;
                      _hoverPosition = null;
                    });
                  },
            // 当鼠标在滑动条上移动时
            onHover: isMobile
                ? null
                : (event) {
                    _handleMouseHover(event.position);
                  },
            child: Obx(() {
              // 计算当前播放位置（秒）
              double? current = (widget.controller.videoBuffering.value &&
                          !widget.controller.sliderDragLoadFinished.value ||
                      _dragging)
                  ? _draggingValue
                  : widget.controller.currentPosition.value.inSeconds
                      .toDouble();
              double max =
                  widget.controller.totalDuration.value.inSeconds.toDouble();

              // 获取缓冲区段
              List<BufferRange> buffers = widget.controller.buffers.toList();

              return Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4.0,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6.0,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12.0,
                      ),
                      // 使用自定义的轨道形状，并传入缓冲区段列表
                      trackShape: CustomSliderTrackShape(
                        hoverValue: _hoverValue,
                        currentValue: current ?? 0.0,
                        bufferRanges: buffers, // 传入缓冲区段
                        maxValue: max,
                      ),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white.withOpacity(0.3),
                      thumbColor: Colors.white,
                      overlayColor: Colors.white.withOpacity(0.1),
                      valueIndicatorColor: Colors.white,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    child: Slider(
                      key: _sliderKey,
                      value: current?.clamp(0.0, max > 0 ? max : 1.0) ?? 0.0,
                      min: 0.0,
                      max: max > 0 ? max : 1.0,
                      onChangeStart: (value) {
                        setState(() {
                          _draggingValue = value;
                          _dragging = true;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _draggingValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          _dragging = false;
                        });
                        widget.controller.sliderDragLoadFinished.value = false;
                        widget.controller.player.play();
                        widget.controller.player
                            .seek(Duration(seconds: value.toInt()));
                      },
                      // 计算总时长和当前播放位置的百分比
                      divisions: max > 0 ? max.toInt() : 1,
                      label: CommonUtils.formatDuration(Duration(
                        seconds:
                            _draggingValue?.toInt() ?? current?.toInt() ?? 0,
                      )),
                    ),
                  ),
                  // 显示悬停或长按标签
                  if (_hoverValue != null && _hoverPosition != null)
                    Positioned(
                      left: _hoverPosition! - 30, // 调整标签位置
                      bottom: 40, // 标签距离滑动条的距离
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          CommonUtils.formatDuration(
                              Duration(seconds: _hoverValue!.toInt())),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  /// 处理鼠标悬停事件
  void _handleMouseHover(Offset globalPosition) {
    RenderBox? box =
        _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset localPosition = box.globalToLocal(globalPosition);
      double relative = localPosition.dx / box.size.width;
      // 获取当前的最大值
      double max = widget.controller.totalDuration.value.inSeconds.toDouble();
      double hoverValue = (relative * max).clamp(0.0, max);
      double hoverPosition = localPosition.dx.clamp(0.0, box.size.width);

      setState(() {
        _hoverValue = hoverValue;
        _hoverPosition = hoverPosition;
      });
    }
  }

  /// 处理移动端的长按事件
  void _handleLongPress(Offset globalPosition) {
    if (!isMobile) return;

    RenderBox? box =
        _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset localPosition = box.globalToLocal(globalPosition);
      double relative = localPosition.dx / box.size.width;
      // 获取当前的最大值
      double max = widget.controller.totalDuration.value.inSeconds.toDouble();
      double hoverValue = (relative * max).clamp(0.0, max);
      double hoverPosition = localPosition.dx.clamp(0.0, box.size.width);

      setState(() {
        _hoverValue = hoverValue;
        _hoverPosition = hoverPosition;
      });
    }
  }
}

/// 自定义的滑动条轨道形状，用于实现鼠标悬停效果和显示多个缓冲区段
class CustomSliderTrackShape extends SliderTrackShape {
  final double? hoverValue;
  final double currentValue;
  final List<BufferRange> bufferRanges;
  final double maxValue;

  CustomSliderTrackShape({
    this.hoverValue,
    required this.currentValue,
    required this.bufferRanges,
    required this.maxValue,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // 计算当前播放位置的比例
    double currentRatio = (currentValue / maxValue).clamp(0.0, 1.0);
    double currentX = trackRect.left + currentRatio * trackRect.width;

    final Paint activePaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final Paint bufferedPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // 绘制未播放部分
    context.canvas.drawRect(
      Rect.fromLTRB(currentX, trackRect.top, trackRect.right, trackRect.bottom),
      inactivePaint,
    );

    // 绘制已播放部分
    context.canvas.drawRect(
      Rect.fromLTRB(trackRect.left, trackRect.top, currentX, trackRect.bottom),
      activePaint,
    );

    // 绘制缓冲区段
    for (BufferRange range in bufferRanges) {
      double startRatio = (range.start.inSeconds / maxValue).clamp(0.0, 1.0);
      double endRatio = (range.end.inSeconds / maxValue).clamp(0.0, 1.0);
      double startX = trackRect.left + startRatio * trackRect.width;
      double endX = trackRect.left + endRatio * trackRect.width;

      // 确保缓冲区段在已播放部分之后
      if (endX <= currentX) continue;

      // 缓冲区段的起始点不能小于当前播放位置
      if (startX < currentX) {
        startX = currentX;
      }

      // 绘制缓冲区段
      context.canvas.drawRect(
        Rect.fromLTRB(startX, trackRect.top, endX, trackRect.bottom),
        bufferedPaint,
      );
    }

    // 如果有悬停值且悬停值在未播放区域，则增强该区域的颜色
    if (hoverValue != null && hoverValue! > currentValue) {
      double hoverRatio = (hoverValue! / maxValue).clamp(0.0, 1.0);
      double hoverX = trackRect.left + hoverRatio * trackRect.width;

      // 确保hoverX不超过轨道右边界
      hoverX = hoverX.clamp(trackRect.left, trackRect.right);

      // 绘制从当前播放位置到hover位置的增强颜色
      Paint hoverPaint = Paint()
        ..color = Colors.white.withOpacity(0.5)
        ..style = PaintingStyle.fill;

      context.canvas.drawRect(
        Rect.fromLTRB(currentX, trackRect.top, hoverX, trackRect.bottom),
        hoverPaint,
      );
    }
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

/// 定义缓冲区段的类
class BufferRange {
  final Duration start;
  final Duration end;

  BufferRange({required this.start, required this.end});

  /// 合并两个重叠或相邻的缓冲区段
  bool overlapsOrAdjacent(BufferRange other) {
    return end >= other.start && other.end >= start;
  }

  /// 合并两个缓冲区段，返回一个新的缓冲区段
  BufferRange merge(BufferRange other) {
    return BufferRange(
      start: start < other.start ? start : other.start,
      end: end > other.end ? end : other.end,
    );
  }
}
