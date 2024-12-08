import 'package:flutter/material.dart';
import 'package:i_iwara/app/ui/widgets/empty_widget.dart';
import 'package:loading_more_list/loading_more_list.dart';

Widget myLoadingMoreIndicator(BuildContext context, IndicatorStatus status,
    {bool isSliver = true, LoadingMoreBase? loadingMoreBase}) {
  Widget? widget;

  switch (status) {
    case IndicatorStatus.none:
      widget = Container(height: 0.0);
      break;
    case IndicatorStatus.loadingMoreBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            height: 15.0,
            width: 15.0,
            child: getIndicator(context),
          ),
          const Text('正在加载...')
        ],
      );
      break;
    case IndicatorStatus.fullScreenBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 0.0),
            height: 30.0,
            width: 30.0,
            child: getIndicator(context),
          ),
          const SizedBox(width: 10.0),
          const Text('正在加载...')
        ],
      );
      widget = isSliver
          ? SliverFillRemaining(child: widget)
          : CustomScrollView(
              slivers: <Widget>[SliverFillRemaining(child: widget)],
            );
      break;
    case IndicatorStatus.error:
      widget = GestureDetector(
        onTap: () => loadingMoreBase?.errorRefresh(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.error, color: Colors.red),
              Text('啊哦，好像出现了问题呢？'),
            ],
          ),
        ),
      );
      break;
    case IndicatorStatus.fullScreenError:
      widget = GestureDetector(
        onTap: () => loadingMoreBase?.errorRefresh(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.error, color: Colors.red),
            Text('啊哦，好像出现了问题呢？'),
          ],
        ),
      );
      widget = isSliver
          ? SliverFillRemaining(child: widget)
          : CustomScrollView(
              slivers: <Widget>[SliverFillRemaining(child: widget)],
            );
      break;
    case IndicatorStatus.noMoreLoad:
      widget = Center(
        child: Text(
          '没有更多了',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      );
      break;
    case IndicatorStatus.empty:
      widget = const MyEmptyWidget(message: '没有数据');
      widget = isSliver
          ? SliverToBoxAdapter(child: widget)
          : CustomScrollView(
              slivers: <Widget>[SliverFillRemaining(child: widget)],
            );
      break;
  }
  return widget;
}

Widget getIndicator(BuildContext context) {
  return CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor: AlwaysStoppedAnimation<Color>(
      Theme.of(context).colorScheme.primary,
    ),
  );
}
