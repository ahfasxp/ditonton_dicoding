part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> topRatedMovies;

  const TopRatedMoviesHasData(this.topRatedMovies);

  @override
  List<Object> get props => [topRatedMovies];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
