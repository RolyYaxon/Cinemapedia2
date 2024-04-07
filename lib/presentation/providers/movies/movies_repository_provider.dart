import 'package:cinemapedia2/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia2/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {

  return MovieRepositoryImpl(MoviedbDatasource());
});
