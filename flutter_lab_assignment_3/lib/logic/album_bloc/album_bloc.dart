import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../../domain/usecases/get_albums_with_photos.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumsWithPhotos getAlbumsWithPhotos;

  AlbumBloc(this.getAlbumsWithPhotos) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await getAlbumsWithPhotos();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError('Failed to load albums'));
      }
    });
  }
}
