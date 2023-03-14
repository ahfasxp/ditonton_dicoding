import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(GetWatchlistMoviesEvent());
      context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMoviesEvent());
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Movie',
                ),
                Tab(
                  text: 'Tv Series',
                ),
              ],
            ),
            title: const Text('Watchlist'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                  builder: (context, state) {
                    if (state is GetWatchlistMoviesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetWatchlistMoviesEmpty) {
                      return Center(child: const Text('Not Found'));
                    } else if (state is GetWatchlistMoviesHasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.movies.length,
                      );
                    } else if (state is GetWatchlistMoviesError) {
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                  builder: (context, state) {
                    if (state is GetWatchlistTvLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetWatchlistTvEmpty) {
                      return Center(child: const Text('Not Found'));
                    } else if (state is GetWatchlistTvHasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = state.watchlistTv[index];
                          return TvCard(tv);
                        },
                        itemCount: state.watchlistTv.length,
                      );
                    } else if (state is GetWatchlistTvError) {
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
