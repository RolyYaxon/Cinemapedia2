
import 'package:cinemapedia2/config/constants/enviroment.dart';
import 'package:dio/dio.dart';

import '../../config/domain/datasources/actos_datasource.dart';
import '../../config/domain/entities/actor.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Enviroment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    
    return actors;
  }

 }