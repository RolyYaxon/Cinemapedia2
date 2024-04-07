import 'package:cinemapedia2/config/domain/entities/actor.dart';
import 'package:cinemapedia2/config/domain/repositories/actos_repository.dart';

import '../../config/domain/datasources/actos_datasource.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;
  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {

    return datasource.getActorsByMovie(movieId);

  }
}
