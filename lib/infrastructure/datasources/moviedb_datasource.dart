import 'package:cinemapedia2/config/constants/enviroment.dart';
import 'package:cinemapedia2/config/domain/entities/movie.dart';
import 'package:cinemapedia2/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia2/infrastructure/models/moviedb/moviedb_details.dart';
import 'package:cinemapedia2/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../config/domain/datasources/movies_datasource.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Enviroment.theMovieDbKey,
        "language": "es-MX"
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != "no poster")
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get("/movie/popular", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get("/movie/$id");

    if (response.statusCode != 200) {
      throw Exception("Movie with id: $id not found");
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailstoEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get("/search/movie", queryParameters: {"query": query});
    return _jsonToMovies(response.data);
  }
}
