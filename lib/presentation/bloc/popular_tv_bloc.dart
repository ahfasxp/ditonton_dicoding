import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(PopularTvInitial()) {
    on<GetPopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());

      final popularTv = await _getPopularTv.execute();

      popularTv.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(PopularTvEmpty());
          } else {
            emit(PopularTvHasData(tvData));
          }
        },
      );
    });
  }
}
