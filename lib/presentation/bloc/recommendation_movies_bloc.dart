import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(this._getMovieRecommendations)
      : super(RecommendationMoviesInitial()) {
    on<GetRecommendationMoviesEvent>((event, emit) async {
      emit(RecommendationMoviesLoading());

      final recommendationMovies =
          await _getMovieRecommendations.execute(event.idMovie);

      recommendationMovies.fold(
        (failure) {
          emit(RecommendationMoviesError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(RecommendationMoviesEmpty());
          } else {
            emit(RecommendationMoviesHasData(moviesData));
          }
        },
      );
    });
  }
}
