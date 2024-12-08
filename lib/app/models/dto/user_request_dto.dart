
import 'package:i_iwara/app/models/user.model.dart';

/// 应用在 朋友请求列表
/// target：如果target是自己，那么表示user是别人，别人请求加我
/// target：如果target不是自己，那么表示user是我，我请求加别人
class UserRequestDTO {
  final String id;
  final DateTime createdAt;
  final User target; // 目标用户，
  final User user; // 请求用户

  UserRequestDTO({
    required this.id,
    required this.createdAt,
    required this.target,
    required this.user,
  });

  factory UserRequestDTO.fromJson(Map<String, dynamic> json) {
    return UserRequestDTO(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      target: User.fromJson(json['target']),
      user: User.fromJson(json['user']),
    );
  }

}
