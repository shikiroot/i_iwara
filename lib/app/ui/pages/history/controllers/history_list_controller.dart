import 'package:get/get.dart';
import 'package:i_iwara/app/repositories/history_repository.dart';
import 'history_list_repository.dart';

class HistoryListController extends GetxController {
  final HistoryRepository _historyRepository;
  late HistoryListRepository repository;
  
  final RxBool isMultiSelect = false.obs;
  final RxSet<String> selectedRecords = <String>{}.obs;
  final RxBool showBackToTop = false.obs;
  
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

  void toggleMultiSelect() {
    isMultiSelect.value = !isMultiSelect.value;
    if (!isMultiSelect.value) {
      selectedRecords.clear();
    }
  }

  void toggleSelection(String recordId) {
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
      selectedRecords.addAll(repository.map((record) => record.itemId));
    }
  }

  Future<void> deleteSelected() async {
    await _historyRepository.deleteRecords(selectedRecords.toList(), itemType);
    selectedRecords.clear();
    repository.refresh();
    Get.snackbar('已删除选中的记录', '');
  }

  @override
  void onClose() {
    repository.dispose();
    super.onClose();
  }
} 