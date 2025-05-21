import 'photo.dart';

class Album {
  final int id;
  final String title;
  final List<Photo> photos;

  Album({
    required this.id,
    required this.title,
    required this.photos,
  });
}
