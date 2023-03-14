part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedMovie extends SearchMovieEvent {
  final String query;

  const OnQueryChangedMovie(this.query);

  @override
  List<Object> get props => [query];
}
