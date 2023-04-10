import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_response.dart';
import 'package:movie_app/models/search_movie.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier{

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies =  [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'c4c4cc7d9b280c1e1dcd6eb38e69f25f';
  final String _language = 'es-ES';

  MoviesProvider(){
    print('MoviesProvider inicializado');
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1, String query = ''] ) async {
    var url = Uri.https(_baseUrl, endpoint, {'api_key':_apiKey, 'language':_language, 'page':'$page', 'query':'$query'});

      final response = await http.get(url);
      return response.body;
  }

  getNowPlayingMovies() async {
      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Movie>> searchMovie( String query ) async {
    final jsonData = await _getJsonData('3/search/movie', 1, query);
    final response = SearchMovie.fromRawJson(jsonData);

    return response.results;
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    
    print('Solicitando información al servidor...');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}