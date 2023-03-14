import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late GetWatchListStatus getWatchListStatus;
  late SaveWatchlist saveWatchlist;
  late RemoveWatchlist removeWatchlist;
  late GetWatchlistMovies getWatchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    getWatchListStatus = MockGetWatchListStatus();
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    getWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
        getWatchListStatus, saveWatchlist, removeWatchlist, getWatchlistMovies);
  });

  final tMovieId = 1;

  group('WatchlistMovieBloc', () {
    test('initial state is WatchlistMovieInitial', () {
      expect(watchlistMovieBloc.state, WatchlistMovieInitial());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emit LoadWatchlistMovieStatusHasData when LoadWatchlistMovieStatus is added',
      build: () {
        when(() => getWatchListStatus.execute(tMovieId))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistMovieStatus(tMovieId)),
      expect: () => [
        LoadWatchlistMovieStatusLoading(),
        LoadWatchlistMovieStatusHasData(true),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emit AddWatchlistMovieHasData when AddWatchlistMovie is added',
      build: () {
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Watchlist is added'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        AddWatchlistMovieLoading(),
        AddWatchlistMovieHasData('Watchlist is added'),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emit DeleteWatchlistMovieHasData when DeleteWatchlistMovie is added',
      build: () {
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Watchlist is deleted'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovie(testMovieDetail)),
      expect: () => [
        DeleteWatchlistMovieLoading(),
        DeleteWatchlistMovieHasData('Watchlist is deleted'),
      ],
    );
  });

  group('GetWatchlistMovies', () {
    test('should get list of watchlist movies from the use case', () async {
      // arrange
      when(() => getWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      // assert later
      final expected = [
        GetWatchlistMoviesLoading(),
        GetWatchlistMoviesHasData(testMovieList),
      ];
      expectLater(watchlistMovieBloc.stream, emitsInOrder(expected));

      // act
      watchlistMovieBloc.add(GetWatchlistMoviesEvent());
    });

    test('should emit error when get list of watchlist movies is unsuccessful',
        () async {
      // arrange
      when(() => getWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // assert later
      final expected = [
        GetWatchlistMoviesLoading(),
        GetWatchlistMoviesError('Server Failure'),
      ];
      expectLater(watchlistMovieBloc.stream, emitsInOrder(expected));

      // act
      watchlistMovieBloc.add(GetWatchlistMoviesEvent());
    });

    test('should emit empty state when there is no watchlist movie', () async {
      // arrange
      when(() => getWatchlistMovies.execute())
          .thenAnswer((_) async => Right([]));

      // assert later
      final expected = [
        GetWatchlistMoviesLoading(),
        GetWatchlistMoviesEmpty(),
      ];
      expectLater(watchlistMovieBloc.stream, emitsInOrder(expected));

      // act
      watchlistMovieBloc.add(GetWatchlistMoviesEvent());
    });
  });
}
