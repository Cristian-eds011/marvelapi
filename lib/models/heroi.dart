import 'package:marvelapi/models/thumnail.dart';

class Heroi {
  String name;
  String description;
  Thumbnail thumbnail;

  Heroi(
      {required this.name, required this.description, required this.thumbnail});

  factory Heroi.fromJson(Map<String, dynamic> json) {

    final heroi = Heroi(
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
    );
    return heroi;
  }
}
