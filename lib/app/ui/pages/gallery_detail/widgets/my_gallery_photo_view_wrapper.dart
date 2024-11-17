import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/app_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// TODO 继续施工 详情图页
class MyGalleryPhotoViewWrapper extends StatefulWidget {
  const MyGalleryPhotoViewWrapper({
    super.key,
    required this.galleryItems,
    this.initialIndex = 0,
  });

  final List<String> galleryItems;
  final int initialIndex;

  @override
  State<MyGalleryPhotoViewWrapper> createState() => _MyGalleryPhotoViewWrapperState();
}

class _MyGalleryPhotoViewWrapperState extends State<MyGalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;
  late PageController pageController;
  bool isDragging = false;
  bool isCtrlPressed = false; // 新增:控制键状态
  double dragStartX = 0;
  late List<PhotoViewController> controllers;
  final double _zoomInterval = 0.2;
  final double _fineZoomInterval = 0.1; // 新增:精细缩放间隔
  final AppService appService = Get.find();

  @override
  void initState() {
    super.initState();
    appService.hideSystemUI(hideTitleBar: false);
    pageController = PageController(initialPage: widget.initialIndex);
    controllers = List.generate(
      widget.galleryItems.length,
          (index) => PhotoViewController(),
    );
  }

  @override
  void dispose() {
    appService.showSystemUI();
    pageController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.controlLeft) {
      setState(() => isCtrlPressed = true);
    }
    if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.controlLeft) {
      setState(() => isCtrlPressed = false);
    }
  }

  void goToNextPage() {
    if (currentIndex < widget.galleryItems.length - 1) {
      pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPreviousPage() {
    if (currentIndex > 0) {
      pageController.animateToPage(
        currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _zoomIn({bool fine = false}) {
    final scale = controllers[currentIndex].scale;
    if (scale != null) {
      controllers[currentIndex].scale = scale + (fine ? _fineZoomInterval : _zoomInterval);
    }
  }

  void _zoomOut({bool fine = false}) {
    final scale = controllers[currentIndex].scale;
    if (scale != null && scale > 0.5) {
      controllers[currentIndex].scale = scale - (fine ? _fineZoomInterval : _zoomInterval);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (KeyEvent event) {
          _handleKeyPress(event);
          if (event is KeyDownEvent) {
            switch (event.logicalKey) {
              case LogicalKeyboardKey.arrowRight:
                goToNextPage();
                break;
              case LogicalKeyboardKey.arrowLeft:
                goToPreviousPage();
                break;
              case LogicalKeyboardKey.arrowUp:
                _zoomIn();
                break;
              case LogicalKeyboardKey.arrowDown:
                _zoomOut();
                break;
            }
          }
        },
        child: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              if (isCtrlPressed) {
                // Ctrl + 滚轮进行精细缩放
                if (pointerSignal.scrollDelta.dy > 0) {
                  _zoomOut(fine: true);
                } else {
                  _zoomIn(fine: true);
                }
              } else {
                // 正常滚动切换图片
                if (pointerSignal.scrollDelta.dy > 0) {
                  goToNextPage();
                } else {
                  goToPreviousPage();
                }
              }
            }
          },
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              isDragging = true;
              dragStartX = details.globalPosition.dx;
            },
            onHorizontalDragUpdate: (details) {
              if (!isDragging) return;
              final currentX = details.globalPosition.dx;
              final diff = currentX - dragStartX;

              if (diff.abs() > 50) {
                if (diff > 0) {
                  goToPreviousPage();
                } else {
                  goToNextPage();
                }
                isDragging = false;
              }
            },
            onHorizontalDragEnd: (details) {
              isDragging = false;
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  allowImplicitScrolling: true,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      controller: controllers[index],
                      imageProvider: NetworkImage(widget.galleryItems[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained * 0.5,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
                    );
                  },
                  itemCount: widget.galleryItems.length,
                  loadingBuilder: (context, event) => Center(
                    child: CircularProgressIndicator(
                      value: event == null
                          ? null
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                    ),
                  ),
                  pageController: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          '${currentIndex + 1}/${widget.galleryItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}