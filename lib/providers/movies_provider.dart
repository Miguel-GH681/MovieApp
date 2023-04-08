import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_response.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier{

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies =  [];

  int _popularPage = 0;

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'c4c4cc7d9b280c1e1dcd6eb38e69f25f';
  final String _language = 'es-ES';

  MoviesProvider(){
    print('MoviesProvider inicializado');
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    var url = Uri.https(_baseUrl, endpoint, {'api_key':_apiKey, 'language':_language, 'page':'$page'});

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
}