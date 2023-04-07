import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget{
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _PosterAndTitle(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const CastingCards()
              ]
            ),
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber.shade600,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        title:  Text('movie.title'),
        background: FadeInImage(
          placeholder:  AssetImage('assets/loading.gif'), 
          image:  AssetImage('assets/loading.gif'), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          
          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movie.originalTitle', style: textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.amber.shade700),
                  const SizedBox(width: 5),
                  const Text('movie.voteAverage')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text('jlkasjdflk jlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflkjlkasjdflk',
      textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}