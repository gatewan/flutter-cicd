import 'dart:io';

import 'package:lib_core/data/sources/local/db/database_helper.dart';
import 'package:lib_core/data/sources/local/movie_local_data_source.dart';
import 'package:lib_core/data/sources/local/tv_local_data_source.dart';
import 'package:lib_core/data/sources/remote/movie_remote_data_source.dart';
import 'package:lib_core/data/sources/remote/tv_remote_data_source.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';
import 'package:m_tv/domain/interface/tv_interface.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieInterface,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvInterface,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<HttpClient>(as: #MockHttpClient, returnNullOnMissingStub: true)
])
void main() {}
