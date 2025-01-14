import 'package:get/get.dart';
import 'package:i_iwara/app/models/api_result.model.dart';
import 'package:i_iwara/app/models/message_and_conversation.model.dart';
import 'package:i_iwara/app/models/page_data.model.dart';
import 'package:i_iwara/app/services/api_service.dart';
import 'package:i_iwara/common/constants.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'package:i_iwara/utils/logger_utils.dart';

/// 消息列表响应数据模型，有用于接收并转化返回结果
class MessageListModel {
  final int count; // 消息数量
  final DateTime first; // 当前返回结果里最新的日期
  final DateTime last; // 当前返回结果里最旧的日期
  final int limit; // 每页数量
  final List<MessageModel> results; // 消息列表

  MessageListModel({
    required this.count,
    required this.first,
    required this.last,
    required this.limit,
    required this.results,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    return MessageListModel(
      count: json['count'] as int? ?? 0,
      first: json['first'] != null ? DateTime.parse(json['first'] as String) : DateTime.now(),
      last: json['last'] != null ? DateTime.parse(json['last'] as String) : DateTime.now(),
      limit: json['limit'] as int? ?? 20,
      results: json['results'] != null
          ? (json['results'] as List<dynamic>)
              .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'first': first.toIso8601String(),
      'last': last.toIso8601String(),
      'limit': limit,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class ConversationService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  /// 获取会话列表
  /// /user/:userId/conversations
  /// @params
  /// `userId` 用户ID
  /// `page` 页码
  /// `limit` 每页数量
  Future<ApiResult<PageData<ConversationModel>>> getConversations(
    String userId,
    {
      int page = 0,
      int limit = 10,
    }
  ) async {
    try {
      var response = await apiService.get(
        ApiConstants.userConversations(userId),
        queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    final PageData<ConversationModel> pageData = PageData.fromJsonWithConverter(
      response.data,
      ConversationModel.fromJson,
    );

      return ApiResult.success(data: pageData);
    } catch (e) {
      LogUtils.e('获取会话列表失败', tag: 'ConversationService', error: e);
      return ApiResult.fail(t.errors.failedToFetchData);
    }
  }

  /// 获取消息列表
  /// conversation/:conversationId/messages
  /// @params
  /// `conversationId` 会话ID
  /// `before` 消息时间戳, 当请求时，第第一次要请求当前时间，之后就拿第一次接口的last
  /// `limit` 每页数量
  /// @return
  /// `count` 消息数量
  /// `first` 当前返回结果里最新的日期
  /// `last` 当前返回结果里最旧的日期
  /// `limit` 每页数量
  /// `results` 消息列表 {@link MessageModel} 数组里越靠前的数据，越旧
  Future<ApiResult<MessageListModel>> getMessages(
    String conversationId,
    {
      String? before,
      int limit = 100,
    }
  ) async {
    try {
      var response = await apiService.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {
          'before': before,
          'limit': limit,
        },
      );

      final MessageListModel data = MessageListModel.fromJson(response.data);

      // print('获取消息列表成功: ${data.toJson()}, 参数: before=$before, limit=$limit');
      return ApiResult.success(data: data);
    } catch (e) {
      LogUtils.e('获取消息列表失败', tag: 'ConversationService', error: e);
      return ApiResult.fail(t.errors.failedToFetchData);
    }
  }

  /// 撤销消息（删除)
  /// DELETE message/:messageId
  /// @params
  /// `messageId` 消息ID
  Future<ApiResult<void>> deleteMessage(String messageId) async {
    try {
      await apiService.delete(ApiConstants.messageWithId(messageId));
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('撤销消息失败', tag: 'ConversationService', error: e);
      return ApiResult.fail(t.errors.failedToOperate);
    }
  }

  /// 发送消息
  /// POST conversation/:conversationId/messages
  /// @params
  /// `conversationId` 会话ID
  /// `message` 消息内容
  Future<ApiResult<void>> sendMessage(String conversationId, String message) async {
    try {
      await apiService.post(ApiConstants.conversationMessages(conversationId), data: {'body': message});
      return ApiResult.success();
    } catch (e) {
      LogUtils.e('发送消息失败', tag: 'ConversationService', error: e);
      return ApiResult.fail(t.errors.failedToOperate);
    }
  }
}
