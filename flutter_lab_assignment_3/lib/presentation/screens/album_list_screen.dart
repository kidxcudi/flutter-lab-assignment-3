import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/constants.dart';
import '../../logic/album_bloc/album_bloc.dart';
import '../../logic/album_bloc/album_event.dart';
import '../../logic/album_bloc/album_state.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(FetchAlbumsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF252525),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFF1F3F7),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            final albums = state.albums;

            if (albums.isEmpty) {
              return const Center(child: Text(AppStrings.noAlbumsFound));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                final photo = album.photos.isNotEmpty ? album.photos.first : null;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.push(AppStrings.albumDetailRoute, extra: album);
                      },
                      child: SizedBox(
                        height: 100, 
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            photo != null
                                ? Image.network(
                                    photo.thumbnailUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey.shade300,
                                        child: const Icon(Icons.broken_image),
                                      );
                                    },
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.image_not_supported),
                                  ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      album.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'by @user${album.userId} · Album ${album.id} · ${album.photos.length} photos',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is AlbumError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 48, color: Colors.grey.shade600),
                    const SizedBox(height: 12),
                    Text(
                      'No Internet Connection',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Please check your connection and try again.',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text(AppStrings.retry),
                      onPressed: () {
                        context.read<AlbumBloc>().add(FetchAlbumsEvent());
                      },
                    ),
                  ],
                ),
              );
            }


          return const SizedBox.shrink();
        },
      ),
    );
  }
}
