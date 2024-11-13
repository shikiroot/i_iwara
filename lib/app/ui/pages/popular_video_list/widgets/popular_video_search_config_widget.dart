import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_iwara/app/services/user_preference_service.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import 'package:i_iwara/utils/widget_extensions.dart';
import '../../../../models/tag.model.dart';
import '../../../../services/video_service.dart';
import '../../../widgets/empty_widget.dart';
import 'add_search_tag_dialog.dart';

/// 热门视频的搜索配置
class PopularVideoSearchConfig extends StatefulWidget {
  final List<Tag> searchTags; // 此时用作搜索的标签
  final String searchYear;
  final String searchRating;
  final Function(List<Tag> tags, String year, String rating) onConfirm;

  const PopularVideoSearchConfig({
    super.key,
    required this.searchTags,
    required this.searchYear,
    required this.searchRating,
    required this.onConfirm,
  });

  @override
  _PopularVideoSearchConfigState createState() =>
      _PopularVideoSearchConfigState();
}

class _PopularVideoSearchConfigState extends State<PopularVideoSearchConfig> {
  late List<Tag> tags; // 选中的标签
  late String year; // 选中的年份
  late String rating;
  late VideoRating _selectedRating;
  late UserPreferenceService _userPreferenceService;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _userPreferenceService = Get.find<UserPreferenceService>();
    tags = List.from(widget.searchTags);
    year = widget.searchYear;
    rating = widget.searchRating;
    _selectedRating = VideoRating.values.firstWhere(
        (VideoRating rating) => rating.value == widget.searchRating);
    LogUtils.d(
        'tags: $tags, year: $year rating: $rating', 'PopularVideoSearchConfig');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      // 屏幕宽度大于600，使用Dialog形式展示
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 设置圆角
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
            minWidth: 400,
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('搜索配置', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 16),
                      _buildPageContent(),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        widget.onConfirm(tags, year, _selectedRating.value);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )),
        ),
      );
    } else {
      // 屏幕宽度小于等于600，使用普通页面展示
      return Scaffold(
        appBar: AppBar(
          title: const Text('搜索配置'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                widget.onConfirm(tags, year, _selectedRating.value);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildPageContent(),
        ),
      );
    }
  }

  // 构建页面内容
  Widget _buildPageContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContentRatingSection(),
          _buildYearSelectionSection(),
          _buildTagSelectionSection(),
        ],
      ),
    );
  }

  // 构建内容评级部分
  Widget _buildContentRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('内容评级: ', style: TextStyle(fontSize: 16)).paddingBottom(8),
        SegmentedButton<VideoRating>(
          segments: VideoRating.values.map((VideoRating rating) {
            return ButtonSegment<VideoRating>(
              value: rating,
              label: Text(rating.label),
            );
          }).toList(),
          selected: {_selectedRating},
          onSelectionChanged: (Set<VideoRating> selected) {
            LogUtils.d('选择的元素: ${selected.first}', 'PopularVideoSearchConfig');
            setState(() {
              _selectedRating = selected.first;
            });
          },
        ).paddingBottom(8),
      ],
    );
  }

  // 构建年份选择部分
  Widget _buildYearSelectionSection() {
    final currentYear = DateTime.now().year;
    const startYear = 2010;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('年份: ', style: TextStyle(fontSize: 16)).paddingBottom(8),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch, // 触摸设备
              PointerDeviceKind.mouse, // 鼠标设备
            },
            scrollbars: true,
          ),
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                _scrollController.jumpTo(
                  _scrollController.position.pixels +
                      pointerSignal.scrollDelta.dy,
                );
              }
            },
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: (currentYear - startYear + 2),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: const Text('全部'),
                        selected: year.isEmpty,
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              year = '';
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    final yearValue = (currentYear - (index - 1)).toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(yearValue),
                        selected: year == yearValue,
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              year = yearValue;
                            });
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ).paddingBottom(8),
      ],
    );
  }

  // 构建标签选择部分
  Widget _buildTagSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('标签: ', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                    return const AddSearchTagDialog();
                  },
                );
              },
            ),
          ],
        ).paddingBottom(8),
        Obx(() {
          List<Tag> remappedTags =
              _userPreferenceService.videoSearchTagHistory.value;

          if (remappedTags.isEmpty) {
            return const EmptyWidget();
          }

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: remappedTags.map((tag) {
              return FilterChip(
                label: Text(tag.id),
                selected: tags.any((element) => element.id == tag.id),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      tags.add(tag);
                    } else {
                      tags.removeWhere((element) => element.id == tag.id);
                    }
                  });
                },
              );
            }).toList(),
          );
        })
      ],
    );
  }
}
