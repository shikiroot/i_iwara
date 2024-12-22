import 'package:get/get.dart';
import 'package:i_iwara/app/repositories/history_repository.dart';
import 'package:i_iwara/i18n/strings.g.dart';
import 'history_list_repository.dart';

class HistoryListController extends GetxController {
  final HistoryRepository _historyRepository;
  late HistoryListRepository repository;
  
  final RxBool isMultiSelect = false.obs;
  final RxSet<int> selectedRecords = <int>{}.obs;
  final RxBool showBackToTop = false.obs;
  final RxString searchKeyword = ''.obs;
  final String itemType;

  HistoryListController({
    required HistoryRepository historyRepository,
    required this.itemType,
  }) : _historyRepository = historyRepository {
    repository = HistoryListRepository(
      historyRepository: historyRepository,
      itemType: itemType == 'all' ? null : itemType,
    );
  }

  bool get isAllSelected => selectedRecords.length == repository.length;


  Future<void> clearHistoryByType(String itemType) async {
    if (itemType == 'all') {
      await _historyRepository.clearHistory();
    } else {
      await _historyRepository.clearHistoryByType(itemType);
    }
    repository.refresh();
    Get.snackbar(t.common.success, '');
  }

  void toggleMultiSelect() {
    isMultiSelect.value = !isMultiSelect.value;
    if (!isMultiSelect.value) {
      selectedRecords.clear();
    }
  }

  void toggleSelection(int recordId) {
    if (selectedRecords.contains(recordId)) {
      selectedRecords.remove(recordId);
    } else {
      selectedRecords.add(recordId);
    }
  }

  void selectAll() {
    if (selectedRecords.length == repository.length) {
      selectedRecords.clear();
    } else {
      selectedRecords.addAll(repository.map((record) => record.id));
    }
  }

  Future<void> deleteSelected() async {
    await _historyRepository.deleteRecords(selectedRecords.toList());
    selectedRecords.clear();
    repository.refresh();
    Get.snackbar(t.common.success, '');
  }

  void search(String keyword) {
    searchKeyword.value = keyword;
    repository.keyword = keyword;
    repository.refresh();
  }

  @override
  void onClose() {
    repository.dispose();
    super.onClose();
  }
} 