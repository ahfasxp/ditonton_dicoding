import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTopRatedTv extends Mock implements GetTopRatedTv {}

void main() {
  group('TopRatedTvBloc', () {
    late TopRatedTvBloc topRatedTvBloc;
    late GetTopRatedTv mockGetTopRatedTv;

    setUp(() {
      mockGetTopRatedTv = MockGetTopRatedTv();
      topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
    });

    tearDown(() {
      topRatedTvBloc.close();
    });

    test('initial state is TopRatedTvInitial', () {
      // assert
      expect(topRatedTvBloc.state, equals(TopRatedTvInitial()));
    });

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [TopRatedTvLoading] then [TopRatedTvHasData] states '
      'when GetTopRatedTvEvent is added and use case returns Tv data',
      build: () {
        when(() => mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(GetTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(testTvList),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedTv.execute()).called(1);
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [TopRatedTvLoading] then [TopRatedTvError] states '
      'when GetTopRatedTvEvent is added and use case returns failure',
      build: () {
        when(() => mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Something went wrong')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(GetTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvError('Something went wrong'),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedTv.execute()).called(1);
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'emits [TopRatedTvLoading] then [TopRatedTvEmpty] states '
      'when GetTopRatedTvEvent is added and use case returns no data',
      build: () {
        when(() => mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right([]));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(GetTopRatedTvEvent()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvEmpty(),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedTv.execute()).called(1);
      },
    );
  });
}
