import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetPopularTv extends Mock implements GetPopularTv {}

void main() {
  late PopularTvBloc popularTvBloc;
  late GetPopularTv getPopularTv;

  setUp(() {
    getPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(getPopularTv);
  });

  tearDown(() => popularTvBloc.close());

  group('getPopularTv', () {
    blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, HasData] states for successful data fetch',
      build: () {
        when(() => getPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(GetPopularTvEvent()),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(testTvList),
      ],
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, Empty] states for successful empty data fetch',
      build: () {
        when(() => getPopularTv.execute())
            .thenAnswer((_) async => const Right([]));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(GetPopularTvEvent()),
      expect: () => [
        PopularTvLoading(),
        PopularTvEmpty(),
      ],
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'emits [Loading, Error] states for unsuccessful data fetch',
      build: () {
        when(() => getPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(GetPopularTvEvent()),
      expect: () => [
        PopularTvLoading(),
        PopularTvError('Server Failure'),
      ],
    );
  });
}
