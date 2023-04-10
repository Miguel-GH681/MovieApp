
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

        final casting = snapshot.data;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i){
              final cast = casting[i];
              return _CastCard(actor: cast.name, urlActor: cast.fullProfilePath);
            },
            itemCount: casting!.length,
          ),
        );
      }
    );
  }
}

class _CastCard extends StatelessWidget {

  final String actor;
  final String urlActor;

  const _CastCard({super.key, required this.actor, required this.urlActor});

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
            child: FadeInImage(
              image: NetworkImage(urlActor),
              placeholder: const AssetImage('assets/no-image.jpg'),
              height: 140,
              fit: BoxFit.cover,
            ), 
          ),
          const SizedBox(height: 5),
          Text(actor, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}