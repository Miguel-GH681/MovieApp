
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot){

        if(!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
            height: 180,
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => const _CastCard(),
            itemCount: 10,
          ),
        );
      }
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 110,
      height: 140,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              image: NetworkImage('https://via.placeholder.com/200x300'),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          const Text('movie.actor', overflow: TextOverflow.ellipsis, maxLines: 2)
        ],
      ),
    );
  }
}