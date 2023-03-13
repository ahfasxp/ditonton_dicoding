import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTv(mockMovieRepository);
  });

  final tTvSeries = <Tv>[];
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}