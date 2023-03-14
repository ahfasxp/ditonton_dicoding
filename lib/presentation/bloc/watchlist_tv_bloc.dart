import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final GetWatchlistTv _getWatchlistTv;

  WatchlistTvBloc(this._getWatchListStatusTv, this._saveWatchlistTv,
      this._removeWatchlistTv, this._getWatchlistTv)
      : super(WatchlistTvInitial()) {
    on<LoadWatchlistTvStatus>((event, emit) async {
      emit(LoadWatchlistTvStatusLoading());

      try {
        final result = await _getWatchListStatusTv.execute(event.idTv);
        emit(LoadWatchlistTvStatusHasData(result));
      } catch (e) {
        emit(LoadWatchlistTvStatusError(e.toString()));
      }
    });

    on<AddWatchlistTv>((event, emit) async {
      emit(AddWatchlistTvLoading());
      final result = await _saveWatchlistTv.execute(event.tvDetail);

      result.fold(
        (failure) {
          emit(AddWatchlistTvError(failure.message));
        },
        (tvData) {
          emit(AddWatchlistTvHasData(tvData));
        },
      );
    });

    on<DeleteWatchlistTv>((event, emit) async {
      emit(DeleteWatchlistTvLoading());
      final result = await _removeWatchlistTv.execute(event.tvDetail);

      result.fold(
        (failure) {
          emit(DeleteWatchlistTvError(failure.message));
        },
        (tvData) {
          emit(DeleteWatchlistTvHasData(tvData));
        },
      );
    });

    on<GetWatchlistTvEvent>((event, emit) async {
      emit(GetWatchlistTvLoading());

      final watchlistTv = await _getWatchlistTv.execute();

      watchlistTv.fold(
        (failure) {
          emit(GetWatchlistTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(GetWatchlistTvEmpty());
          } else {
            emit(GetWatchlistTvHasData(tvData));
          }
        },
      );
    });
  }
}
