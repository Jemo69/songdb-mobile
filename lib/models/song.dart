class Song {
  final String id;
  final String title;
  final String? lyrics;
  final String? slug;

  const Song({required this.id, required this.title, this.lyrics, this.slug});

  factory Song.fromSummaryJson(Map<String, dynamic> json) {
    return Song(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? 'Untitled').toString(),
      slug: json['slug']?.toString(),
    );
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? 'Untitled').toString(),
      lyrics: json['lyrics']?.toString(),
      slug: json['slug']?.toString(),
    );
  }

  /// Many titles embed the artist after " - " (e.g. "Victory - Eben").
  /// Splits into display title and artist for the list.
  ({String title, String? artist}) get parsedTitle {
    final dash = title.indexOf(' - ');
    if (dash <= 0 || dash >= title.length - 3) {
      return (title: title, artist: null);
    }
    return (
      title: title.substring(0, dash).trim(),
      artist: title.substring(dash + 3).trim(),
    );
  }

  Song withLyrics(String lyrics) =>
      Song(id: id, title: title, lyrics: lyrics, slug: slug);
}
