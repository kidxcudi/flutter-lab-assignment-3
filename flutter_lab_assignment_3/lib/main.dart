import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/api/album_remote_data_source.dart';
import 'data/repositories/album_repository_impl.dart';
import 'domain/usecases/get_albums_with_photos.dart';
import 'logic/album_bloc/album_bloc.dart';
import 'logic/album_bloc/album_event.dart';
import 'logic/album_bloc/album_state.dart';
import 'presentation/screens/album_list_screen.dart';

void main() {
  final albumRepository = AlbumRepositoryImpl(AlbumRemoteDataSource(http.Client()));
  final getAlbumsWithPhotos = GetAlbumsWithPhotos(albumRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlbumBloc(getAlbumsWithPhotos),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AlbumListScreen(),
    );
  }
}
