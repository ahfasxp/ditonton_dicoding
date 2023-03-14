import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late TopRatedMoviesBloc bloc;
  late GetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be TopRatedMoviesInitial', () {
    expect(bloc.state, TopRatedMoviesInitial());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesLoading, TopRatedMoviesHasData] when successful',
    build: () {
      when(() => mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(testMovieList),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesLoading, TopRatedMoviesEmpty] when data is empty',
    build: () {
      when(() => mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right([]));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesEmpty(),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesLoading, TopRatedMoviesError] when unsuccessful',
    build: () {
      when(() => mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesError('Server Failure'),
    ],
  );
}
