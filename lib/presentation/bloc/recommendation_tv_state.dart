part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

class RecommendationTvInitial extends RecommendationTvState {}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvEmpty extends RecommendationTvState {}

class RecommendationTvHasData extends RecommendationTvState {
  final List<Tv> recommendationTv;

  const RecommendationTvHasData(this.recommendationTv);

  @override
  List<Object> get props => [recommendationTv];
}

class RecommendationTvError extends RecommendationTvState {
  final String message;

  const RecommendationTvError(this.message);

  @override
  List<Object> get props => [message];
}
