
import 'package:http/http.dart' as http;
import 'package:lib_core/data/sources/local/db/database_helper.dart';
import 'package:lib_core/data/sources/local/movie_local_data_source.dart';
import 'package:lib_core/data/sources/local/tv_local_data_source.dart';
import 'package:lib_core/data/sources/remote/movie_remote_data_source.dart';
import 'package:lib_core/data/sources/remote/tv_remote_data_source.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient, returnNullOnMissingStub: true)
])
void main() {}
