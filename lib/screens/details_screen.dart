import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget{
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    print(movie.title);
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(screenTitle: movie.title, backDropPath: movie.fullBackDropPath),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(
                  moviePoster: movie.fullImagePath,
                  movieOriginalTitle: movie.originalTitle,
                  movieVoteAverage: movie.voteAverage,
                  movieOriginalLanguage: movie.originalLanguage
                ),
                _Overview(overview: movie.overview),
                CastingCards( movieId: movie.id )
              ]
            ),
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String screenTitle;
  final String? backDropPath;
  const _CustomAppBar({super.key, required this.screenTitle, this.backDropPath});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber.shade600,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(bottom: 0),
          child: Text(screenTitle, textAlign: TextAlign.center)
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image:  NetworkImage(backDropPath ?? 'assets/loading.gif'), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final String movieOriginalTitle;
  final String moviePoster;
  final double movieVoteAverage;
  final String? movieOriginalLanguage;

  const _PosterAndTitle(
    {
      super.key, 
      required this.movieOriginalTitle, 
      required this.moviePoster, 
      required this.movieVoteAverage, 
      this.movieOriginalLanguage
    }
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(moviePoster),
              height: 130,
            ),
          ),
          
          const SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(movieOriginalTitle, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movieOriginalLanguage ?? 'No Disponible', style: textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, size: 20, color: Colors.amber.shade700),
                    const SizedBox(width: 5),
                    Text(movieVoteAverage.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;
  const _Overview({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(overview,
      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}