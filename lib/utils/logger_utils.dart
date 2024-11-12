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

  static void d(String message, [String tag = _TAG]) {
    _logger.d("[$tag] $message");
  }

  static void i(String message, [String tag = _TAG]) {
    _logger.i("[$tag] $message");
  }

  static void w(String message, [String tag = _TAG]) {
    _logger.w("[$tag] $message");
  }

  static void e(String message,
      {String tag = _TAG, Object? error, StackTrace? stackTrace}) {
    _logger.e("[$tag] $message", stackTrace: stackTrace, error: error);
  }

}
