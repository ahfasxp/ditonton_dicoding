part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

// LoadWatchlistMovieStatus
class LoadWatchlistMovieStatusLoading extends WatchlistMovieState {}

class LoadWatchlistMovieStatusHasData extends WatchlistMovieState {
  final bool isAddedWatchlist;

  const LoadWatchlistMovieStatusHasData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class LoadWatchlistMovieStatusError extends WatchlistMovieState {
  final String message;

  const LoadWatchlistMovieStatusError(this.message);

  @override
  List<Object> get props => [message];
}

// AddWatchlistMovie
class AddWatchlistMovieLoading extends WatchlistMovieState {}

class AddWatchlistMovieHasData extends WatchlistMovieState {
  final String watchlistMessage;

  const AddWatchlistMovieHasData(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class AddWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const AddWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

// DeleteWatchlistMovie
class DeleteWatchlistMovieLoading extends WatchlistMovieState {}

class DeleteWatchlistMovieHasData extends WatchlistMovieState {
  final String watchlistMessage;

  const DeleteWatchlistMovieHasData(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class DeleteWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const DeleteWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
