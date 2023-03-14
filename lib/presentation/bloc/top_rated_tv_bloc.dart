import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvInitial()) {
    on<GetTopRatedTvEvent>((event, emit) async {
      emit(TopRatedTvLoading());

      final topRatedTv = await _getTopRatedTv.execute();

      topRatedTv.fold(
        (failure) {
          emit(TopRatedTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(TopRatedTvEmpty());
          } else {
            emit(TopRatedTvHasData(tvData));
          }
        },
      );
    });
  }
}
