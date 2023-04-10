import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/movie_search_delegate.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Movie'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: ()=> showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper( movies: moviesProvider.onDisplayMovies ),
            MovieSlider(
              popularMovies: moviesProvider.popularMovies, 
              sectionTitle: 'Populares', 
              onNextPage: ()=> moviesProvider.getPopularMovies()
            ),
            // const MovieSlider(),
            // const MovieSlider(),
            // const MovieSlider(),
            // const MovieSlider(),
          ],
        ),
      )
    );
  }
}
