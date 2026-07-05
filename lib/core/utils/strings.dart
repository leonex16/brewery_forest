/// Helpers to turn a list of optional strings into a clean value — the shared
/// "drop null/empty [and join]" idiom used by address lines, the IP place
/// label, and the location banner.
extension StringParts on Iterable<String?> {
  /// The non-null, non-empty items, in order.
  List<String> compact() =>
      where((s) => s != null && s.isNotEmpty).cast<String>().toList();

  /// [compact] joined by [separator], or null when there is nothing to join.
  String? joinNonEmpty([String separator = ', ']) {
    final kept = compact();
    return kept.isEmpty ? null : kept.join(separator);
  }
}
