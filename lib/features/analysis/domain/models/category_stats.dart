class CategoryStats {
  final int total;
  final int exceeded;
  final int low;
  final double? average;

  const CategoryStats({
    required this.total,
    required this.exceeded,
    required this.low,
    this.average,
  });

  static const empty = CategoryStats(total: 0, exceeded: 0, low: 0);
}
