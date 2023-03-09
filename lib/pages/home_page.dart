import 'package:flutter/material.dart';
import 'package:interview_test/provider/movies_provider.dart';

import '../models/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final movieProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          movieProvider.getPopularMovies();
        },
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 60,
        ),
        child: Column(
          children: [_moviesSection()],
        ),
      ),
    );
  }

  Widget _moviesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Movies'),
        const SizedBox(
          height: 10,
        ),
        AnimatedBuilder(
          animation: movieProvider,
          builder: (context, child) {
            if (movieProvider.moviesStatus == MoviesStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (movieProvider.moviesStatus == MoviesStatus.failed) {
              return const Center(
                child: Text('Something happened fetching movies'),
              );
            }

            return SizedBox(
              height: 180,
              child: _moviesCardsList(movieProvider.movies),
            );
          },
        ),
      ],
    );
  }

  Widget _moviesCardsList(List<MovieModel> movies) {
    return ListView.separated(
      itemCount: movies.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return _movieCard(movie);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 10),
    );
  }

  Widget _movieCard(MovieModel movie) {
    return Container(
      height: 180,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
          ),
        ),
      ),
    );
  }
}
