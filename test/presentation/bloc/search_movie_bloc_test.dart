import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  MockSearchMovies mockSearchMovies = MockSearchMovies();

  group('Search Movie Bloc Test', () {
    final query = "Harry Potter";

    blocTest<SearchMovieBloc, SearchMovieState>(
        'should emit [Loading, HasData] states when searching movies is successful',
        build: () {
          when(() => mockSearchMovies.execute(query))
              .thenAnswer((_) async => Right(testMovieList));
          return SearchMovieBloc(mockSearchMovies);
        },
        act: (bloc) => bloc.add(OnQueryChangedMovie(query)),
        expect: () => [
              SearchMovieLoading(),
              SearchMovieHasData(testMovieList),
            ],
        verify: (_) {
          verify(() => mockSearchMovies.execute(query)).called(1);
        });

    blocTest<SearchMovieBloc, SearchMovieState>(
        'should emit [Loading, Error] states when searching movies is unsuccessful',
        build: () {
          when(() => mockSearchMovies.execute(query)).thenAnswer(
              (_) async => Left(ServerFailure("Server Failure occured!")));
          return SearchMovieBloc(mockSearchMovies);
        },
        act: (bloc) => bloc.add(OnQueryChangedMovie(query)),
        expect: () => [
              SearchMovieLoading(),
              SearchMovieError("Server Failure occured!"),
            ],
        verify: (_) {
          verify(() => mockSearchMovies.execute(query)).called(1);
        });
  });
}
