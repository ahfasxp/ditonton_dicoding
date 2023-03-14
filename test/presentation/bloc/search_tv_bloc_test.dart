import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTv extends Mock implements SearchTv {}

void main() {
  late SearchTvBloc searchTvBloc;
  late SearchTv searchTv;

  setUp(() {
    searchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(searchTv);
  });

  final tQuery = 'black mirror';

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [SearchTvLoading, SearchTvHasData] when success',
    build: () {
      when(() => searchTv.execute(any()))
          .thenAnswer((_) async => Right(testTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(testTvList),
    ],
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [SearchTvLoading, SearchTvEmpty] when data is empty',
    build: () {
      when(() => searchTv.execute(any())).thenAnswer((_) async => Right([]));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    expect: () => [
      SearchTvLoading(),
      SearchTvEmpty(),
    ],
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [SearchTvLoading, SearchTvError] when failed',
    build: () {
      when(() => searchTv.execute(any()))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    expect: () => [
      SearchTvLoading(),
      SearchTvError('Server Failure'),
    ],
  );
}
