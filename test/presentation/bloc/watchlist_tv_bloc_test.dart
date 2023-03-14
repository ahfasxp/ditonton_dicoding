import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatusTv extends Mock implements GetWatchListStatusTv {}

class MockSaveWatchlistTv extends Mock implements SaveWatchlistTv {}

class MockRemoveWatchlistTv extends Mock implements RemoveWatchlistTv {}

class MockGetWatchlistTv extends Mock implements GetWatchlistTv {}

void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetWatchlistTv mockGetWatchlistTv;

  final tIdTv = 1;

  setUp(() {
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchlistTv = MockGetWatchlistTv();

    watchlistTvBloc = WatchlistTvBloc(
      mockGetWatchListStatusTv,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
      mockGetWatchlistTv,
    );
  });

  tearDown(() {
    watchlistTvBloc.close();
  });

  group('WatchlistTvBloc', () {
    test('initial state is WatchlistTvInitial', () {
      expect(watchlistTvBloc.state, WatchlistTvInitial());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emit LoadWatchlistTvStatusHasData when LoadWatchlistTvStatus is added',
      build: () {
        when(() => mockGetWatchListStatusTv.execute(tIdTv))
            .thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTvStatus(tIdTv)),
      expect: () => [
        LoadWatchlistTvStatusLoading(),
        LoadWatchlistTvStatusHasData(true),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emit AddWatchlistTvHasData when AddWatchlistTv is added',
      build: () {
        when(() => mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Watchlist is added'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
      expect: () => [
        AddWatchlistTvLoading(),
        AddWatchlistTvHasData('Watchlist is added'),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emit DeleteWatchlistTvHasData when DeleteWatchlistTv is added',
      build: () {
        when(() => mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Watchlist is deleted'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistTv(testTvDetail)),
      expect: () => [
        DeleteWatchlistTvLoading(),
        DeleteWatchlistTvHasData('Watchlist is deleted'),
      ],
    );
  });

  group('GetWatchlistTvs', () {
    test('should get list of watchlist Tvs from the use case', () async {
      // arrange
      when(() => mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));

      // assert later
      final expected = [
        GetWatchlistTvLoading(),
        GetWatchlistTvHasData(testTvList),
      ];
      expectLater(watchlistTvBloc.stream, emitsInOrder(expected));

      // act
      watchlistTvBloc.add(GetWatchlistTvEvent());
    });

    test('should emit error when get list of watchlist Tvs is unsuccessful',
        () async {
      // arrange
      when(() => mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // assert later
      final expected = [
        GetWatchlistTvLoading(),
        GetWatchlistTvError('Server Failure'),
      ];
      expectLater(watchlistTvBloc.stream, emitsInOrder(expected));

      // act
      watchlistTvBloc.add(GetWatchlistTvEvent());
    });

    test('should emit empty state when there is no watchlist Tv', () async {
      // arrange
      when(() => mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right([]));

      // assert later
      final expected = [
        GetWatchlistTvLoading(),
        GetWatchlistTvEmpty(),
      ];
      expectLater(watchlistTvBloc.stream, emitsInOrder(expected));

      // act
      watchlistTvBloc.add(GetWatchlistTvEvent());
    });
  });
}
