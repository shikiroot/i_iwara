class SearchRecord {
  final String keyword;
  final DateTime lastUsedAt;
  int usedTimes;

  SearchRecord({
    required this.keyword,
    required this.lastUsedAt,
    this.usedTimes = 1,
  });

  Map<String, dynamic> toJson() => {
        'keyword': keyword,
        'lastUsedAt': lastUsedAt.toIso8601String(),
        'usedTimes': usedTimes,
      };

  factory SearchRecord.fromJson(Map<String, dynamic> json) => SearchRecord(
        keyword: json['keyword'],
        lastUsedAt: DateTime.parse(json['lastUsedAt']),
        usedTimes: json['usedTimes'],
      );
}
