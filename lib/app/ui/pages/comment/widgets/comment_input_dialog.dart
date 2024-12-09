import 'package:flutter/material.dart';
import 'package:i_iwara/app/services/app_service.dart';

class CommentInputDialog extends StatefulWidget {
  final String? initialText;
  final Function(String) onSubmit;
  final String title;
  final String submitText;

  const CommentInputDialog({
    super.key,
    this.initialText,
    required this.onSubmit,
    required this.title,
    required this.submitText,
  });

  @override
  State<CommentInputDialog> createState() => _CommentInputDialogState();
}

class _CommentInputDialogState extends State<CommentInputDialog> {
  late TextEditingController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '写下你的评论...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => AppService.tryPop(),
                  child: const Text('取消'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await widget.onSubmit(_controller.text);
                    print('提交成功');
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.submitText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 