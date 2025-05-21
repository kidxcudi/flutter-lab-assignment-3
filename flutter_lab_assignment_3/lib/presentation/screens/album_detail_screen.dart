import 'package:flutter/material.dart';
import '../../domain/entities/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album #${album.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(album.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('Photos:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: album.photos.length,
                itemBuilder: (context, index) {
                  final photo = album.photos[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(photo.thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(photo.title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
