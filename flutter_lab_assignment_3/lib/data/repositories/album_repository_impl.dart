import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../api/album_remote_data_source.dart';
import '../../domain/entities/photo.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Album>> getAlbumsWithPhotos() async {
    final albums = await remoteDataSource.fetchAlbums();
    final photos = await remoteDataSource.fetchPhotos();

    // Group photos by albumId
    final Map<int, List<Photo>> photoMap = {};
    for (var photo in photos) {
      photoMap.putIfAbsent(photo.albumId, () => <Photo>[]).add(photo.toEntity());
    }

    // Combine photos with corresponding album
    return albums.map((album) {
      final matchedPhotos = photoMap[album.id] ?? [];
      return album.toEntity(matchedPhotos);
    }).toList();
  }
}
