

class UserDTO {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;

  UserDTO({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'avatarUrl': avatarUrl,
    };
  }
}