import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late GetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [Loading, HasData] when successful',
    build: () {
      when(() => mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(testMovieList),
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [Loading, Empty] when data is empty',
    build: () {
      when(() => mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right([]));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesEmpty(),
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [Loading, Error] when getting data fails',
    build: () {
      when(() => mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError('Server Failure'),
    ],
  );
}
