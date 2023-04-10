import 'dart:convert';

import 'package:movie_app/models/models.dart';

SearchMovie searchMovieFromJson(String str) => SearchMovie.fromJson(json.decode(str));

class SearchMovie {
    SearchMovie({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchMovie.fromRawJson(String str) => SearchMovie.fromJson(json.decode(str));

    factory SearchMovie.fromJson(Map<String, dynamic> json) => SearchMovie(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
