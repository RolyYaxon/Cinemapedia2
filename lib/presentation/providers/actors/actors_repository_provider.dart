
import 'package:cinemapedia2/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';


// Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl( ActorMovieDbDatasource() );
});