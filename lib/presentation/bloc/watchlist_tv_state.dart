part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

// LoadWatchlistTvStatus
class LoadWatchlistTvStatusLoading extends WatchlistTvState {}

class LoadWatchlistTvStatusHasData extends WatchlistTvState {
  final bool isAddedWatchlist;

  const LoadWatchlistTvStatusHasData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class LoadWatchlistTvStatusError extends WatchlistTvState {
  final String message;

  const LoadWatchlistTvStatusError(this.message);

  @override
  List<Object> get props => [message];
}

// AddWatchlistTv
class AddWatchlistTvLoading extends WatchlistTvState {}

class AddWatchlistTvHasData extends WatchlistTvState {
  final String watchlistMessage;

  const AddWatchlistTvHasData(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class AddWatchlistTvError extends WatchlistTvState {
  final String message;

  const AddWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

// DeleteWatchlistTv
class DeleteWatchlistTvLoading extends WatchlistTvState {}

class DeleteWatchlistTvHasData extends WatchlistTvState {
  final String watchlistMessage;

  const DeleteWatchlistTvHasData(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class DeleteWatchlistTvError extends WatchlistTvState {
  final String message;

  const DeleteWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

// GetWatchlistTvs
class GetWatchlistTvLoading extends WatchlistTvState {}

class GetWatchlistTvEmpty extends WatchlistTvState {}

class GetWatchlistTvHasData extends WatchlistTvState {
  final List<Tv> watchlistTv;

  const GetWatchlistTvHasData(this.watchlistTv);

  @override
  List<Object> get props => [watchlistTv];
}

class GetWatchlistTvError extends WatchlistTvState {
  final String message;

  const GetWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
