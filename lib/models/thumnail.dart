class Thumbnail {
  String path = '';
  String extension = '';

  Thumbnail({required this.path, required this.extension});

  factory Thumbnail.fromJson(json) {
    final tumb = Thumbnail(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );
    return tumb;
  }
}
