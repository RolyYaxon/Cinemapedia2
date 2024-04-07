import 'package:cinemapedia2/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia2/infrastructure/repositories/local_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorareRepositoryImpl(IsarDatasource());
});
