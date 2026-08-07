class PageMeta {
  const PageMeta({
    required this.total,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  final int total;
  final int limit;
  final int offset;
  final bool hasMore;
}
