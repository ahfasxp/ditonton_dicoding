import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv.dart';
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetOnAirTv extends Mock implements GetOnAirTv {}

void main() {
  late OnAirTvBloc bloc;
  late GetOnAirTv mockGetOnAirTv;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTv();
    bloc = OnAirTvBloc(mockGetOnAirTv);
  });

  group('On Air TV Bloc Test', () {
    test('initialState should be OnAirTvInitial', () {
      expect(bloc.state, OnAirTvInitial());
    });

    blocTest<OnAirTvBloc, OnAirTvState>(
      'emits [loading, empty] when no data is returned',
      build: () {
        when(() => mockGetOnAirTv.execute()).thenAnswer((_) async => Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(GetOnAirTvEvent()),
      expect: () => [OnAirTvLoading(), OnAirTvEmpty()],
    );

    blocTest<OnAirTvBloc, OnAirTvState>(
      'emits [loading, hasData] when data is returned',
      build: () {
        when(() => mockGetOnAirTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetOnAirTvEvent()),
      expect: () => [OnAirTvLoading(), OnAirTvHasData(testTvList)],
    );

    blocTest<OnAirTvBloc, OnAirTvState>(
      'emits [loading, error] when there is an exception',
      build: () {
        when(() => mockGetOnAirTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(GetOnAirTvEvent()),
      expect: () => [OnAirTvLoading(), OnAirTvError('Server Failure')],
    );
  });
}
