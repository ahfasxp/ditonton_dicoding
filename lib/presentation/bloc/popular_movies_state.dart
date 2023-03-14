part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> popularMovies;

  const PopularMoviesHasData(this.popularMovies);

  @override
  List<Object> get props => [popularMovies];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
