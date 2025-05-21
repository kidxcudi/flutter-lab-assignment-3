import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSource(this.client);

  Future<List<AlbumModel>> fetchAlbums() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((json) => AlbumModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
