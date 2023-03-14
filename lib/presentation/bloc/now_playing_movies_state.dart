part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> nowPlayingMovies;

  const NowPlayingMoviesHasData(this.nowPlayingMovies);

  @override
  List<Object> get props => [nowPlayingMovies];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
