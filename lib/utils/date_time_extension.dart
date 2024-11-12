/// TODO: date extension国际化
extension DateTimeCustomFormatter on DateTime {
  /// 自定义格式化时间
  /// @param formatType 格式类型
  /// @return 格式化后的时间字符串
  /// 如果时间在一小时内，返回 "x分钟前"
  /// 如果时间在一天内，返回 "x小时前"
  /// 如果是昨天，返回 "昨天"
  /// 如果是大于一天，返回 "MM-dd" 格式
  /// 默认返回原始时间字符串
  String customFormat([String formatType = "DEFAULT"]) {
    final now = DateTime.now();
    final difference = now.difference(this);

    // 检查输入的格式类型
    switch (formatType) {
      case "SHORT_CHINESE":
        // 1. 如果时间在一小时内，返回 "x分钟前"
        if (difference.inMinutes < 60) {
          return "${difference.inMinutes}分钟前";
        }
        // 2. 如果时间在一天内，返回 "x小时前"
        if (difference.inHours < 24) {
          return "${difference.inHours}小时前";
        }
        // 3. 如果是昨天，返回 "昨天"
        if (difference.inDays == 1) {
          return "昨天";
        }
        // 4. 如果是大于一天，返回 "MM-dd" 格式
        return "${_twoDigits(month)}-${_twoDigits(day)}";

      default:
        return toString();
    }
  }

  // 辅助方法，确保个位数前面加 '0'
  String _twoDigits(int n) {
    return n >= 10 ? "$n" : "0$n";
  }
}

extension IntCustomFormatter on int {
  /// 自定义格式化数字
  /// @return 格式化后的数字字符串
  /// 如果数字大于等于 1000，返回 "x.x千"
  /// 如果数字大于等于 10000，返回 "x.x万"
  /// 默认返回原始数字字符串
  String customFormat() {
    if (this >= 10000) {
      return "${(this / 10000).toStringAsFixed(1)}万";
    } else if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}千";
    } else {
      return toString();
    }
  }
}
