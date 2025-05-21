import '../../domain/entities/album.dart';
import '../../domain/entities/photo.dart';

class AlbumModel {
  final int id;
  final String title;

  AlbumModel({
    required this.id,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Album toEntity(List<Photo> photos) {
    return Album(
      id: id,
      title: title,
      photos: photos,
    );
  }
}
