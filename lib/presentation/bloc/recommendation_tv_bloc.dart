import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations)
      : super(RecommendationTvInitial()) {
    on<GetRecommendationTvEvent>((event, emit) async {
      emit(RecommendationTvLoading());

      final recommendationTv = await _getTvRecommendations.execute(event.idTv);

      recommendationTv.fold(
        (failure) {
          emit(RecommendationTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(RecommendationTvEmpty());
          } else {
            emit(RecommendationTvHasData(tvData));
          }
        },
      );
    });
  }
}
