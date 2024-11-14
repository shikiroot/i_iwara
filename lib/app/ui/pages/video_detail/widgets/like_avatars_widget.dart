import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/constants.dart';
import '../../../../models/user.model.dart';
import '../../../../services/api_service.dart';

class LikeAvatarsWidget extends StatefulWidget {
  final String videoId;

  const LikeAvatarsWidget({super.key, required this.videoId});

  @override
  _LikeAvatarsWidgetState createState() => _LikeAvatarsWidgetState();
}

class _LikeAvatarsWidgetState extends State<LikeAvatarsWidget> {
  List<User> _users = [];
  bool _isLoading = true;
  final ApiService _apiService = Get.find();
  int count = 0;

  @override
  void initState() {
    super.initState();
    _fetchLikes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchLikes() async {
    try {
      final response = await _apiService.get(
        'https://api.iwara.tv/video/${widget.videoId}/likes',
        queryParameters: {'page': 0, 'limit': 6},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (!mounted) return; // 检查组件是否仍然挂载
        setState(() {
          _users = (data['results'] as List)
              .map((userJson) => User.fromJson(userJson['user']))
              .toList();
          _isLoading = false;
          count = data['count'];
        });
      } else {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        SizedBox(
          height: 40,
          width: _calculateStackWidth(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...List.generate(_users.length, (index) {
                return Positioned(
                  left: index * 20.0,
                  child: _buildAvatarCircle(_users[index]),
                );
              }),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count Likes',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  double _calculateStackWidth() {
    return (_users.length - 1) * 20.0 + 40.0;
  }

  Widget _buildAvatarCircle(User user) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.avatar?.avatarUrl ?? CommonConstants.defaultAvatarUrl,
          httpHeaders: const {'referer': CommonConstants.iwaraBaseUrl},
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
