import 'photo.dart';

class Album {
  final int id;
  final String title;
  final List<Photo> photos;
  final int userId;

  Album({
    required this.id,
    required this.title,
    required this.photos,
    required this.userId,
  });
}
