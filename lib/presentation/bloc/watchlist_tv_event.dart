part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistTvStatus extends WatchlistTvEvent {
  final int idTv;

  const LoadWatchlistTvStatus(this.idTv);

  @override
  List<Object> get props => [idTv];
}

class AddWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const AddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DeleteWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const DeleteWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class GetWatchlistTvEvent extends WatchlistTvEvent {}
