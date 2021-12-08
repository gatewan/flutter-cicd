import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:lib_core/data/models/tv_detail_model.dart';
import 'package:lib_core/data/models/tv_model.dart';
import 'package:lib_core/data/models/tv_response.dart';
import 'package:lib_core/utils/exception.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvs();

  Future<List<TvModel>> getPopularTvs();

  Future<List<TvModel>> getTopRatedTvs();

  Future<TvDetailModel> getTvDetail(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  Future<List<TvModel>> searchTvs(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final HttpClient sslClient;

  TvRemoteDataSourceImpl({required this.sslClient});

  @override
  Future<List<TvModel>> getNowPlayingTvs() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    debugPrint('WTF: tv remote data source RUN $BASE_URL/tv/on_the_air?$API_KEY');
    if (response.statusCode == 200) {
      debugPrint('WTF: tv remote data source OK');
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      debugPrint('WTF: tv remote data source FAIL');
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    debugPrint('WTF: tv remote data source RUN $BASE_URL/tv/$id?$API_KEY');

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvs(String query) async {
    sslClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient client = IOClient(sslClient);
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
