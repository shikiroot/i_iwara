import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:i_iwara/app/models/video_source.model.dart';

import '../app/ui/pages/video_detail/controllers/my_video_state_controller.dart';

class CommonUtils {
  /// 格式化Duration 为 mm:ss
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// 进入全屏
  /// toVerticalScreen: 是否进入竖屏全屏（仅IOS Android有效）
  static Future<void> defaultEnterNativeFullscreen(
      {bool toVerticalScreen = false}) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await Future.wait(
          [
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.immersiveSticky,
              overlays: [],
            ),
            SystemChrome.setPreferredOrientations(
              toVerticalScreen
                  ? [DeviceOrientation.portraitUp]
                  : [
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ],
            ),
          ],
        );
      } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        // 此处使用media_kit_video的MethodChannel，
        await const MethodChannel('com.alexmercerind/media_kit_video')
            .invokeMethod(
          'Utils.EnterNativeFullscreen',
        );
      }
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
    }
  }

  /// 将videoSources转换成videoResolutions
  static List<VideoResolution> convertVideoSourcesToResolutions(
      List<VideoSource>? videoSources,
      {filterPreview = false}) {
    // VideoSource#src#view 是视频播放源
    final List<VideoResolution> videoResolutions = [];
    if (videoSources == null) {
      return videoResolutions;
    }

    for (final VideoSource videoSource in videoSources) {
      if (videoSource.src != null && videoSource.src!.view != null) {
        if (filterPreview) {
          if (videoSource.name == 'preview') {
            continue;
          }
        }
        videoResolutions.add(
          VideoResolution(
            label: videoSource.name ?? '',
            url: 'https:${videoSource.src!.view}',
          ),
        );
      }
    }

    return videoResolutions;
  }

  /// 根据清晰度标签查找对应的视频源
  static String? findUrlByResolutionTag(
      List<VideoResolution>? videoResolutions, String? resolutionTag) {
    if (videoResolutions == null || resolutionTag == null) {
      return null;
    }
    return videoResolutions
        .firstWhere(
          (element) =>
      element.label.toLowerCase() == resolutionTag.toLowerCase(),
      orElse: () => VideoResolution(label: '', url: ''),
    )
        .url;
  }
}
