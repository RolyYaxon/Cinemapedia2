import 'package:cinemapedia2/config/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia2/config/domain/entities/movie.dart';
import 'package:cinemapedia2/config/domain/repositories/local_storage_repository.dart';

class LocalStorareRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorareRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 20, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
