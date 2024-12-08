import 'package:logger/logger.dart';

class LogUtils {
  static late Logger _logger;

  static const String _TAG = "i_iwara";

  static void init() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        // 显示调用方法数
        errorMethodCount: 8,
        // 显示错误方法数
        lineLength: 120,
        // 每行长度
        colors: true,
        // 是否显示颜色
        printEmojis: true, // 是否显示表情
      ),
    );
    // TODO 临时设置为debug
    Logger.level = Level.debug;
  }

  static String _getTimeString() {
    return DateTime.now().toString().substring(0, 19);
  }

  static void d(String message, [String tag = _TAG]) {
    _logger.d("[${_getTimeString()}][$tag] $message");
  }

  static void i(String message, [String tag = _TAG]) {
    _logger.i("[${_getTimeString()}][$tag] $message");
  }

  static void w(String message, [String tag = _TAG]) {
    _logger.w("[${_getTimeString()}][$tag] $message");
  }

  static void e(String message,
      {String tag = _TAG, Object? error, StackTrace? stackTrace, StackTrace? stack}) {
    _logger.e("[${_getTimeString()}][$tag] $message",
        stackTrace: stackTrace ?? stack, error: error);
  }

}
