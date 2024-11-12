/// Result
class ApiResult<T> {
  final bool isSuccess;
  final String message;
  final int code;
  final T? data;

  // 私有化构造函数
  ApiResult._(this.isSuccess, this.message, this.data, this.code);

  // 成功
  factory ApiResult.success(
      {String message = '操作成功', T? data, int code = 200}) {
    return ApiResult._(true, message, data, code);
  }

  // 失败
  factory ApiResult.fail(String message, {T? data, int code = 500}) {
    return ApiResult._(false, message, data, code);
  }

  // 是否失败
  bool get isFail => !isSuccess;
}
