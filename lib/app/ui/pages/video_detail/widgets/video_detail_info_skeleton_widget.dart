import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediaDetailInfoSkeletonWidget extends StatelessWidget {
  const MediaDetailInfoSkeletonWidget({super.key});

  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 播放器
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: width * 9 / 16, // 16:9 aspect ratio
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              // 标题
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 24,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 用户信息
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 16,
                        width: 100,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16,
                    width: 150,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 描述
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 16,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // 标签
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List.generate(5, (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Chip(
                        label: Container(
                          width: 50,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // 点赞等
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const Icon(
                        Icons.thumb_up_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: const Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
