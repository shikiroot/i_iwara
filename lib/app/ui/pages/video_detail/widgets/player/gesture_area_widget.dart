import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../../../services/config_service.dart';
import '../../controllers/my_video_state_controller.dart';
import 'my_video_screen.dart';

/// 视频播放器的手势区域
enum GestureRegion { left, right, center }

class GestureArea extends StatefulWidget {
  final GestureRegion region;
  final MyVideoStateController myVideoStateController;
  final Size screenSize;

  // 添加回调函数
  final VoidCallback? onDoubleTapLeft;
  final VoidCallback? onDoubleTapRight;
  final VoidCallback? onTap;
  final Function(LongPressType?, bool)? setLongPressing;

  const GestureArea({
    super.key,
    required this.region,
    required this.myVideoStateController,
    this.onDoubleTapLeft,
    this.onDoubleTapRight,
    this.onTap,
    required this.screenSize,
    this.setLongPressing,
  });

  @override
  _GestureAreaState createState() => _GestureAreaState();
}

class _GestureAreaState extends State<GestureArea>
    with SingleTickerProviderStateMixin {
  final Logger logger = Logger();
  final ConfigService _configService = Get.find();
  VolumeController? _volumeController;
  ScreenBrightness? _screenBrightness;

  // 提示信息
  String? _infoMessage;

  // 拖动的距离
  late AnimationController _infoMessageFadeController;
  late Animation<double> _infoMessageOpacity;

  @override
  void initState() {
    super.initState();
    _initializeInfoMessageController();
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      _volumeController = VolumeController();
    }

    if (!GetPlatform.isLinux && !GetPlatform.isWeb) {
      _screenBrightness = ScreenBrightness();
    }
  }

  void _onTap() {
    widget.onTap?.call();
  }

  void _onDoubleTap() {
    // 如果是中心区域，双击切换播放状态
    switch (widget.region) {
      case GestureRegion.center:
        widget.myVideoStateController.videoPlaying.value
            ? widget.myVideoStateController.player.pause()
            : widget.myVideoStateController.player.play();
        break;
      case GestureRegion.left:
        // 触发左侧波纹动画
        widget.onDoubleTapLeft?.call();
        _showInfoMessage();
        break;
      case GestureRegion.right:
        // 触发右侧波纹动画
        widget.onDoubleTapRight?.call();
        _showInfoMessage();
        break;
      default:
        break;
    }
  }

  void _initializeInfoMessageController() {
    _infoMessageFadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _infoMessageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _infoMessageFadeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _showInfoMessage() {
    String message;
    if (widget.region == GestureRegion.left) {
      message = '后退${_configService[ConfigService.REWIND_SECONDS_KEY]}秒';
    } else {
      message = '快进${_configService[ConfigService.FAST_FORWARD_SECONDS_KEY]}秒';
    }

    setState(() {
      _infoMessage = message;
    });
    _infoMessageFadeController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _infoMessageFadeController.reverse();
      }
    });
  }

  void _onLongPressStart(LongPressStartDetails details) {
    // 如果视频在暂停或buffering状态，不处理
    if (!widget.myVideoStateController.videoPlaying.value ||
        widget.myVideoStateController.videoBuffering.value) {
      return;
    }
    widget.setLongPressing?.call(LongPressType.normal, true);
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    widget.setLongPressing?.call(LongPressType.normal, false);
  }

  // 检查左侧和中心区域是否可以处理垂直拖动
  bool _checkLeftAndCenterVerticalDragProcessable() {
    // 中心区域不处理
    if (widget.region == GestureRegion.center) {
      return false;
    }

    // PC设备和Web不处理亮度调节
    if (widget.region == GestureRegion.left &&
        (GetPlatform.isDesktop || GetPlatform.isWeb)) {
      return false;
    }
    return true;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (!_checkLeftAndCenterVerticalDragProcessable()) {
      return;
    }

    LongPressType? type;
    if (widget.region == GestureRegion.left) {
      type = LongPressType.brightness;
    } else if (widget.region == GestureRegion.right) {
      type = LongPressType.volume;
    }

    widget.setLongPressing?.call(type, false); // 确保结束时调用淡出动画

    // 结束时让信息提示淡出
    _infoMessageFadeController.reverse().whenComplete(() {
      setState(() {
        _infoMessage = null; // 清除提示信息
      });
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!_checkLeftAndCenterVerticalDragProcessable()) {
      return;
    }

    // 缩放因子，亮度区域的缩放因子为2，音量区域的缩放因子为1
    var scalingFactor = widget.region == GestureRegion.left ? 2 : 1;
    final double max = widget.screenSize.height * scalingFactor;

    if (widget.region == GestureRegion.left &&
        !GetPlatform.isWeb &&
        !GetPlatform.isLinux &&
        !GetPlatform.isWindows &&
        !GetPlatform.isMacOS) {
      // 只在移动设备上调整亮度
      double rx = _configService[ConfigService.BRIGHTNESS_KEY] -
          details.primaryDelta! / max;
      rx = rx.clamp(0.0, 1.0);
      _configService[ConfigService.BRIGHTNESS_KEY] = rx;
      _screenBrightness?.setScreenBrightness(rx); // 调整系统亮度

      widget.setLongPressing?.call(LongPressType.brightness, true); // 显示亮度提示
    } else if (widget.region == GestureRegion.right) {
      // 调整音量
      double rx = _configService[ConfigService.VOLUME_KEY] -
          details.primaryDelta! / max;
      rx = rx.clamp(0.0, 1.0);
      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        _volumeController?.setVolume(rx);
        logger.d('系统音量调整：$rx');
      } else {
        widget.myVideoStateController.player.setVolume(rx * 100); // 调整播放器音量
        logger.d('播放器音量调整:$rx');
      }
      _configService[ConfigService.VOLUME_KEY] = rx;

      widget.setLongPressing?.call(LongPressType.volume, true); // 显示音量提示
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // TODO 水平方向拖动调整进度
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 单击时显示/隐藏工具栏
        widget.myVideoStateController.toggleToolbars();
      },
      onDoubleTap: _onDoubleTap,
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: _onLongPressEnd,
      onVerticalDragStart: (_) {
        // 开始垂直滑动时
        widget.myVideoStateController.setInteracting(true);
      },
      onVerticalDragEnd: (_) {
        // 结束垂直滑动时
        widget.myVideoStateController.setInteracting(false);
        _onVerticalDragEnd(_);
      },
      onVerticalDragUpdate: widget.region == GestureRegion.left ||
              widget.region == GestureRegion.right
          ? _onVerticalDragUpdate
          : null,
      onHorizontalDragUpdate: widget.region == GestureRegion.center
          ? _onHorizontalDragUpdate
          : null,
      child: Container(
        /// 如果不用transparent的Container包裹，会导致center区域无法触发手势，GTP给出的解释是
        /// "当你使用一个没有颜色（即 color: null）的 Container 时，如果它没有子组件绘制任何内容，Flutter 可能不会为这个区域分配绘制层。这意味这个区域在视觉上是透明的，但在命中测试中也是"不可命中"的，因为没有实际的绘制内容。"
        /// 离谱奥
        color: Colors.transparent,
        child: Stack(
          children: [
            if (_infoMessage != null)
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _infoMessageOpacity,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _infoMessage!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
