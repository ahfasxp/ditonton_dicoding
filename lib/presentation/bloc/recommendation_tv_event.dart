part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationTvEvent extends RecommendationTvEvent {
  final int idTv;

  const GetRecommendationTvEvent(this.idTv);

  @override
  List<Object> get props => [idTv];
}
