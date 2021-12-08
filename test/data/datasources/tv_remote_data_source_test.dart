import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:lib_core/data/models/tv_response.dart';
import 'package:lib_core/data/sources/remote/tv_remote_data_source.dart';
import 'package:lib_core/lib_core.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(sslClient: mockHttpClient);
  });

  group('get Now Playing Tvs', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json'))).tvList;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_the_air.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTvs();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvs', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/popular.json'))).tvList;

    test('should return list of tvs when response is success (200)', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularTvs();
      // assert
      expect(result, tTvList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvs', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/top_rated.json'))).tvList;

    test('should return list of tvs when response code is 200 ', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvs();
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(json.decode(readJson('dummy_data/movie_recommendations.json'))).tvList;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvs', () {
    final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/search_spiderman_movie.json'))).tvList;
    final tQuery = 'spiderman';

    test('should return list of tvs when response code is 200', () async {
      // arrange
            mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchTvs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
            mockHttpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      IOClient client = IOClient(mockHttpClient);
      when(client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
