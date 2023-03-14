import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late GetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, HasData] when successful',
    build: () {
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(testMovieList),
    ],
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, Empty] when data is empty',
    build: () {
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, Error] when getting data fails',
    build: () {
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
  );
}
