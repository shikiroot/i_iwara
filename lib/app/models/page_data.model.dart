
class PageData<T> {
  final int count;
  final int page;
  final int limit;
  List<T> results = <T>[];

  PageData({
    required this.count,
    required this.page,
    required this.limit,
    required this.results,
  });
}