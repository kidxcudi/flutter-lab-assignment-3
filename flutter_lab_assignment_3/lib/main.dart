import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'navigation/router.dart';
import 'data/api/album_remote_data_source.dart';
import 'data/repositories/album_repository_impl.dart';
import 'domain/usecases/get_albums_with_photos.dart';
import 'logic/album_bloc/album_bloc.dart';

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
    return MaterialApp.router(
      title: 'Album App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
