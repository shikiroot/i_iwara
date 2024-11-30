import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// 实验性组件
/// 自定义GridView，使用demo可参考 {@link PlayListPage}
class CustomPagedGridView<T> extends StatefulWidget {
  final int pageSize;
  // pageKey: 每次翻页都会+1
  final Future<List<T>> Function(int pageKey, int pageSize) onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double maxCrossAxisExtent;
  final double? mainAxisExtent;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context)? loadingIndicatorBuilder;
  final Widget Function(BuildContext context, VoidCallback onRetry)?
      errorIndicatorBuilder;
  final Widget Function(BuildContext context)? emptyIndicatorBuilder;
  final Widget Function(BuildContext context)? noMoreItemsIndicatorBuilder;
  final PagingController<int, T>? controller;

  const CustomPagedGridView({
    super.key,
    this.pageSize = 20,
    required this.onFetch,
    required this.itemBuilder,
    this.controller,
    this.maxCrossAxisExtent = 128,
    this.mainAxisExtent,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.padding = const EdgeInsets.all(16),
    this.loadingIndicatorBuilder,
    this.errorIndicatorBuilder,
    this.emptyIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
  });

  @override
  State<CustomPagedGridView<T>> createState() => _CustomPagedGridViewState<T>();
}

class _CustomPagedGridViewState<T> extends State<CustomPagedGridView<T>> {
  late final PagingController<int, T> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = widget.controller ?? PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.onFetch(pageKey, widget.pageSize);
      final isLastPage = newItems.length < widget.pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PagedSliverGrid<int, T>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width / widget.maxCrossAxisExtent).floor(),
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisSpacing: widget.crossAxisSpacing,
            childAspectRatio: widget.mainAxisExtent != null 
                ? widget.maxCrossAxisExtent / widget.mainAxisExtent!
                : 1.0,
          ),
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: widget.itemBuilder,
            firstPageProgressIndicatorBuilder: widget.loadingIndicatorBuilder ??
                (_) => const DefaultLoadingIndicator(),
            newPageProgressIndicatorBuilder: widget.loadingIndicatorBuilder ??
                (_) => const DefaultLoadingIndicator(),
            firstPageErrorIndicatorBuilder: widget.errorIndicatorBuilder != null
                ? (context) => widget.errorIndicatorBuilder!(
                    context, () => _pagingController.refresh())
                : (_) => DefaultErrorIndicator(
                      onRetry: () => _pagingController.refresh(),
                    ),
            noItemsFoundIndicatorBuilder: widget.emptyIndicatorBuilder ??
                (_) => const DefaultEmptyIndicator(),
            noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder ??
                (_) => const DefaultNoMoreItemsIndicator(),
            animateTransitions: true,
          ),
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class DefaultLoadingIndicator extends StatelessWidget {
  const DefaultLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class DefaultErrorIndicator extends StatelessWidget {
  final VoidCallback onRetry;

  const DefaultErrorIndicator({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('加载失败'),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }
}

class DefaultEmptyIndicator extends StatelessWidget {
  const DefaultEmptyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('暂无数据'),
    );
  }
}

class DefaultNoMoreItemsIndicator extends StatelessWidget {
  const DefaultNoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const Text('没有更多数据了'),
    );
  }
}
