import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:i_iwara/app/models/tag.model.dart';
import 'package:i_iwara/app/ui/pages/tag_blacklist/widgets/black_list_search_tag_dialog.dart';
import 'package:i_iwara/app/ui/pages/tag_blacklist/controllers/tag_blacklist_controller.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:i_iwara/i18n/strings.g.dart';

class TagBlacklistPage extends StatefulWidget {
  const TagBlacklistPage({super.key});

  @override
  State<TagBlacklistPage> createState() => _TagBlacklistPageState();
}

class _TagBlacklistPageState extends State<TagBlacklistPage> {
  late TagBlacklistController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TagBlacklistController());
  }

  @override
  void dispose() {
    Get.delete<TagBlacklistController>();
    super.dispose();
  }

  Widget _buildSaveButton() {
    return Obx(() {
      if (controller.isSaving.value) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          highlightColor: Theme.of(context).colorScheme.primary,
          child: TextButton(
            onPressed: null,
            child: Text(
              t.common.save,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      }
      return TextButton(
        onPressed: controller.saveBlacklistTags,
        child: Text(t.common.save),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.common.tagBlacklist),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Get.dialog(
                BlackListTagSearchDialog(
                  onSave: (tags) {
                    // 要去重
                    final currentTagIds = controller.blacklistTags.map((tag) => tag.id).toList();
                    final newTags = tags.where((tag) => !currentTagIds.contains(tag.id)).toList();
                    controller.addTags(newTags);
                  },
                ),
              );
            },
          ),
          _buildSaveButton(),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.blacklistTags.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.blacklistTags.isEmpty) {
          return MyEmptyWidget(
            message: t.common.noData,
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchBlacklistTags(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${t.common.tagLimit}: ${controller.blacklistTags.length}/${controller.tagLimit}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: controller.blacklistTags.map((tag) {
                      return Chip(
                        label: Text(tag.id),
                        avatar: _buildTagIcon(tag),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => controller.removeTag(tag),
                        labelStyle: TextStyle(
                          color: tag.type == 'ecchi' ? Colors.red : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTagIcon(Tag tag) {
    if (tag.sensitive) {
      return const Icon(Icons.warning, size: 18, color: Colors.red);
    }
    return Icon(
      Icons.local_offer,
      size: 18,
      color: tag.type == 'ecchi' ? Colors.red : null,
    );
  }
} 