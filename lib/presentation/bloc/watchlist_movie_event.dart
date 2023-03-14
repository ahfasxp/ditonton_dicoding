part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistMovieStatus extends WatchlistMovieEvent {
  final int idMovie;

  const LoadWatchlistMovieStatus(this.idMovie);

  @override
  List<Object> get props => [idMovie];
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const DeleteWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
