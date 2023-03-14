import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/recommendation_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late GetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  tearDown(() {
    recommendationMoviesBloc.close();
  });

  final tIdMovie = 1;

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'emits [Loading, HasData] when successful',
    build: () {
      when(() => mockGetMovieRecommendations.execute(tIdMovie))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMoviesEvent(tIdMovie)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesHasData(testMovieList),
    ],
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'emits [Loading, Empty] when empty',
    build: () {
      when(() => mockGetMovieRecommendations.execute(tIdMovie))
          .thenAnswer((_) async => Right([]));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMoviesEvent(tIdMovie)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesEmpty(),
    ],
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'emits [Loading, Error] with error message when error occurred',
    build: () {
      when(() => mockGetMovieRecommendations.execute(tIdMovie))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMoviesEvent(tIdMovie)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesError('Server Failure'),
    ],
  );
}
