import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  final tIdMovie = 1;

  test('initial state should be DetailMovieInitial', () {
    expect(detailMovieBloc.state, equals(DetailMovieInitial()));
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should emit [DetailMovieLoading, DetailMovieHasData] when successful',
    build: () {
      when(() => mockGetMovieDetail.execute(any())).thenAnswer(
          (_) async => Right<Failure, MovieDetail>(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(tIdMovie)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieHasData(testMovieDetail),
    ],
    verify: (_) {
      verify(() => mockGetMovieDetail.execute(tIdMovie)).called(1);
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should emit [DetailMovieLoading, DetailMovieError] when failed',
    build: () {
      when(() => mockGetMovieDetail.execute(any())).thenAnswer((_) async =>
          Left<Failure, MovieDetail>(ServerFailure('Server Error')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(tIdMovie)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Server Error'),
    ],
    verify: (_) {
      verify(() => mockGetMovieDetail.execute(tIdMovie)).called(1);
    },
  );
}
