import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'c4c4cc7d9b280c1e1dcd6eb38e69f25f';
  String _language = 'es-ES';

  MoviesProvider(){
    print('MoviesProvider inicializado');
    this.getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
      var url = Uri.https(_baseUrl, '3/movie/now_playing', {'api_key':_apiKey, 'language':_language, 'page':'1'});
      final response = await http.get(url);
      final Map<String, dynamic> decodeData = json.decode( response.body );
      if(response.statusCode == 200){
        print(decodeData);
      }
  }
}