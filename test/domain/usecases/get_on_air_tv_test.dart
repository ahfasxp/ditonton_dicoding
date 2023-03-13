import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetOnAirTv(mockMovieRepository);
  });

  final tTvSeries = <Tv>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockMovieRepository.getOnAirTv())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
