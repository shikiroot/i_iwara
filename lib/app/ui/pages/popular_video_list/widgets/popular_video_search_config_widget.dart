import 'package:flutter/material.dart';
import 'package:i_iwara/utils/logger_utils.dart';
import '../../../../models/tag.model.dart';
import '../../../../services/video_service.dart';

/// 热门视频的搜索配置
class PopularVideoSearchConfig extends StatefulWidget {
  final List<Tag> searchTags;
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
  _PopularVideoSearchConfigState createState() => _PopularVideoSearchConfigState();
}

class _PopularVideoSearchConfigState extends State<PopularVideoSearchConfig> {
  late List<Tag> tags;
  late String year;
  late String rating;
  late VideoRating _selectedRating;

  @override
  void initState() {
    super.initState();
    tags = List.from(widget.searchTags);
    year = widget.searchYear;
    rating = widget.searchRating;
    _selectedRating = VideoRating.values.firstWhere((VideoRating rating) => rating.value == widget.searchRating);
    LogUtils.d('tags: $tags, year: $year rating: $rating', 'PopularVideoSearchConfig');
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
            child: _buildPageContent(),
          ),
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

 Widget _buildPageContent() {
    final currentYear = DateTime.now().year;
    const startYear = 2010;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 内容评级
        const Text('内容评级: ', style: TextStyle(fontSize: 16)),
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
        ),
        // 年份选择
        const Text('年份: ', style: TextStyle(fontSize: 16)),
        DropdownButton<String?>(
          value: year.isEmpty ? null : year,
          hint: const Text('全部'), // 当值为空时显示的提示文本
          items: [
            // 添加一个空值选项
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('全部'),
            ),
            // 年份选项
            for (int i = 0; i < (currentYear - startYear + 1); i++)
              DropdownMenuItem(
                value: (currentYear - i).toString(),
                child: Text((currentYear - i).toString()),
              ),
          ],
          onChanged: (String? newValue) {
            setState(() {
              year = newValue ?? '';
            });
          },
        ),
        // 标签选择
        const Text('标签: ', style: TextStyle(fontSize: 16)),
      ],
    );
  }

}
