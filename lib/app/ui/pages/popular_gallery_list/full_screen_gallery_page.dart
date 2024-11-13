import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// 全屏查看图片的页面
// TODO : 全屏图页面优化
class FullScreenGallery extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  _FullScreenGalleryState createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${currentIndex + 1} / ${widget.imageUrls.length}'),
        // 最后面的 TODO 图的操作
        actions: [IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: Listener(
        onPointerSignal: (PointerSignalEvent signal) {
          if (signal is PointerScrollEvent) {
            // 向下滚动为正，向上滚动为负
            if (signal.scrollDelta.dy > 0) {
              // 向下滚动，显示下一张
              if (currentIndex < widget.imageUrls.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            } else {
              // 向上滚动，显示上一张
              if (currentIndex > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }
          }
        },
        child: PhotoViewGallery.builder(
          wantKeepAlive: true,
          itemCount: widget.imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
                  CachedNetworkImageProvider(widget.imageUrls[index]),
              initialScale: PhotoViewComputedScale.contained * 1.0,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: widget.imageUrls[index]),
            );
          },
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          pageController: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded /
                      (event.expectedTotalBytes ?? 1),
            ),
          ),
        ),
      ),
    );
  }
}
