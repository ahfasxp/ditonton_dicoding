part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationMoviesEvent extends RecommendationMoviesEvent {
  final int idMovie;

  const GetRecommendationMoviesEvent(this.idMovie);

  @override
  List<Object> get props => [idMovie];
}
