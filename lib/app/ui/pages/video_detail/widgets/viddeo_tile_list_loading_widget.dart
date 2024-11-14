import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VideoTileListSkeletonWidget extends StatelessWidget {
  const VideoTileListSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.0));
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemExtent: 120,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 14,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
