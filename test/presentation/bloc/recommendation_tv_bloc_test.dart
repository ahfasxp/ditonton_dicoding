import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvRecommendations extends Mock implements GetTvRecommendations {}

void main() {
  late RecommendationTvBloc bloc;
  late GetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    bloc = RecommendationTvBloc(mockGetTvRecommendations);
  });

  final tIdTv = 1;

  blocTest<RecommendationTvBloc, RecommendationTvState>(
      'emits [Loading, Empty] when there are no recommended TVs',
      build: () {
        when(() => mockGetTvRecommendations.execute(tIdTv))
            .thenAnswer((_) async => Right([]));
        return bloc;
      },
      act: (RecommendationTvBloc bloc) =>
          bloc.add(GetRecommendationTvEvent(tIdTv)),
      expect: () => [
            RecommendationTvLoading(),
            RecommendationTvEmpty(),
          ],
      verify: (_) {
        verify(() => mockGetTvRecommendations.execute(tIdTv)).called(1);
      });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
      'emits [Loading, HasData] when there are recommended TVs',
      build: () {
        when(() => mockGetTvRecommendations.execute(tIdTv))
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (RecommendationTvBloc bloc) =>
          bloc.add(GetRecommendationTvEvent(tIdTv)),
      expect: () => [
            RecommendationTvLoading(),
            RecommendationTvHasData(testTvList),
          ],
      verify: (_) {
        verify(() => mockGetTvRecommendations.execute(tIdTv)).called(1);
      });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
      'emits [Loading, Error] when something goes wrong',
      build: () {
        when(() => mockGetTvRecommendations.execute(tIdTv))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (RecommendationTvBloc bloc) =>
          bloc.add(GetRecommendationTvEvent(tIdTv)),
      expect: () => [
            RecommendationTvLoading(),
            const RecommendationTvError('Server Failure'),
          ],
      verify: (_) {
        verify(() => mockGetTvRecommendations.execute(tIdTv)).called(1);
      });
}
