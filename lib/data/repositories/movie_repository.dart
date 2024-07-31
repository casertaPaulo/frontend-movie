import 'dart:convert';
import 'package:movies/data/http/exceptions.dart';
import 'package:movies/data/http/http_client.dart';
import 'package:movies/data/model/movie_entity.dart';

abstract class IMovieRepository {
  Future<List<MovieEntity>> searchMovies({required String title});
  Future<List<MovieEntity>> getMovies();
  Future saveMovie({required String title});
}

class MovieRepository implements IMovieRepository {
  final IHttpClient client;

  MovieRepository({required this.client});

  @override
  Future<List<MovieEntity>> searchMovies({required String title}) async {
    final response =
        await client.get(url: "http://192.168.1.13:8080/movie/search/$title");

    final stringJson = utf8.decode(response.bodyBytes);
    final body = jsonDecode(stringJson);

    if (response.statusCode == 200) {
      final List<MovieEntity> movies = [];

      body.map((item) {
        movies.add(MovieEntity.fromJson(item));
      }).toList();

      return movies;
    } else if (response.statusCode == 404) {
      throw NotFoundException(body['title'] + " " + body['detail']);
    } else {
      throw TooManyResultsException(body['title'] + " " + body['detail']);
    }
  }

  @override
  Future<List<MovieEntity>> getMovies() async {
    final response = await client.get(url: "http://192.168.1.13:8080/movie");

    final stringJson = utf8.decode(response.bodyBytes);
    final body = jsonDecode(stringJson);

    if (response.statusCode == 200) {
      final List<MovieEntity> movies = [];

      body.map((item) {
        movies.add(MovieEntity.fromJson(item));
      }).toList();

      return movies;
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future saveMovie({required String title}) async {
    final response =
        await client.post(url: "http://192.168.1.13:8080/movie/$title");
    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw NotFoundException(body['title'] + " " + body['detail']);
    }
  }
}
