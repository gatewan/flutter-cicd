import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:lib_core/data/models/movie_detail_model.dart';
import 'package:lib_core/data/models/movie_model.dart';
import 'package:lib_core/data/models/movie_response.dart';
import 'package:lib_core/utils/exception.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailResponse> getMovieDetail(int id);

  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final HttpClient sslClient;

  MovieRemoteDataSourceImpl({required this.sslClient});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));
    debugPrint('WTF: movie remote data source RUN $BASE_URL/movie/now_playing?$API_KEY');
    if (response.statusCode == 200) {
      debugPrint('WTF: movie remote data source OK');
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      debugPrint('WTF: movie remote data source FAIL');
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
