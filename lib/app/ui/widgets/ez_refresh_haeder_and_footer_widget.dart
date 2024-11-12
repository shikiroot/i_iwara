
import 'package:easy_refresh/easy_refresh.dart';

// TODO 监听语言变化设置文案
void initEzRefreshHeaderAndFooter () {
  EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
    position: IndicatorPosition.above,
    infiniteOffset: null,
  );

  EasyRefresh.defaultHeaderBuilder = () => ClassicHeader();
}