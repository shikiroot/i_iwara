import 'package:get/get.dart';
import 'dart:math';

import 'package:i_iwara/app/models/search_record.model.dart';

class GlobalService extends GetxService {
  final Rx<String> currentSearch = ''.obs;
  final Rx<String> searchPlaceholder = 'loli'.obs;
  final RxSet<String> selectedSegment = {'video'}.obs;
  
  final RxString searchErrorText = ''.obs;
  
  void setSearchError(String? error) {
    searchErrorText.value = error ?? '';
  }

  void clearSearchError() {
    searchErrorText.value = '';
  }

  void updateSearchPlaceholder(List<SearchRecord> history) {
    if (history.isEmpty) {
      searchPlaceholder.value = '';
      return;
    }

    // 计算最大使用次数，用于归一化
    final maxUsedTimes = history.map((e) => e.usedTimes).reduce(max);

    // 为每条记录计算权重分数
    final now = DateTime.now();
    List<(SearchRecord, double)> weightedRecords = history.map((record) {
      // 使用频率得分 (0-40分)
      double freqScore = (record.usedTimes / maxUsedTimes) * 40;
      
      // 时间衰减得分 (0-40分)
      double daysAgo = now.difference(record.lastUsedAt).inDays.toDouble();
      double timeScore = (1 - (daysAgo / 30)).clamp(0.0, 1.0) * 40;
      
      // 随机因素 (0-20分)
      double randomScore = Random().nextDouble() * 20;

      return (record, freqScore + timeScore + randomScore);
    }).toList();

    // 按总分排序
    weightedRecords.sort((a, b) => b.$2.compareTo(a.$2));

    // 从前3条中随机选择一条
    final topCount = min(3, weightedRecords.length);
    final selectedIndex = Random().nextInt(topCount);
    
    searchPlaceholder.value = weightedRecords[selectedIndex].$1.keyword;
  }
}