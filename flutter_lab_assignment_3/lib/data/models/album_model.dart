import '../../domain/entities/album.dart';
import '../../domain/entities/photo.dart';

class AlbumModel {
  final int id;
  final String title;
  final int userId;

  AlbumModel({
    required this.id,
    required this.title,
    required this.userId,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }

  Album toEntity(List<Photo> photos) {
    return Album(
      id: id,
      title: title,
      photos: photos,
      userId: userId,
    );
  }
}
