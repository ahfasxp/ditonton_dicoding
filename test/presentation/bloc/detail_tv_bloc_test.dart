import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvDetail extends Mock implements GetTvDetail {}

void main() {
  late DetailTvBloc detailTvBloc;
  late GetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  final tId = 1;

  group('DetailTvBloc', () {
    test('initial state should be DetailTvInitial', () {
      expect(detailTvBloc.state, equals(DetailTvInitial()));
    });

    blocTest<DetailTvBloc, DetailTvState>(
      'should emit [DetailTvLoading, DetailTvHasData] when data is gotten successfully',
      build: () {
        when(() => mockGetTvDetail.execute(tId)).thenAnswer(
          (_) async => Right(testTvDetail),
        );
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(GetDetailTvEvent(tId)),
      expect: () => [
        DetailTvLoading(),
        DetailTvHasData(testTvDetail),
      ],
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'should emit [DetailTvLoading, DetailTvError] when get data is unsuccessful',
      build: () {
        when(() => mockGetTvDetail.execute(tId)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(GetDetailTvEvent(tId)),
      expect: () => [
        DetailTvLoading(),
        DetailTvError('Server Failure'),
      ],
    );
  });
}
