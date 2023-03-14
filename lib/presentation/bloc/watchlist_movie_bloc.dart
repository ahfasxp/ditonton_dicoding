import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchListStatus, this._saveWatchlist,
      this._removeWatchlist, this._getWatchlistMovies)
      : super(WatchlistMovieInitial()) {
    on<LoadWatchlistMovieStatus>((event, emit) async {
      emit(LoadWatchlistMovieStatusLoading());

      try {
        final result = await _getWatchListStatus.execute(event.idMovie);
        emit(LoadWatchlistMovieStatusHasData(result));
      } catch (e) {
        emit(LoadWatchlistMovieStatusError(e.toString()));
      }
    });

    on<AddWatchlistMovie>((event, emit) async {
      emit(AddWatchlistMovieLoading());
      final result = await _saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(AddWatchlistMovieError(failure.message));
        },
        (movieData) {
          emit(AddWatchlistMovieHasData(movieData));
        },
      );
    });

    on<DeleteWatchlistMovie>((event, emit) async {
      emit(DeleteWatchlistMovieLoading());
      final result = await _removeWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(DeleteWatchlistMovieError(failure.message));
        },
        (movieData) {
          emit(DeleteWatchlistMovieHasData(movieData));
        },
      );
    });

    on<GetWatchlistMoviesEvent>((event, emit) async {
      emit(GetWatchlistMoviesLoading());

      final watchlistMovie = await _getWatchlistMovies.execute();

      watchlistMovie.fold(
        (failure) {
          emit(GetWatchlistMoviesError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(GetWatchlistMoviesEmpty());
          } else {
            emit(GetWatchlistMoviesHasData(moviesData));
          }
        },
      );
    });
  }
}
