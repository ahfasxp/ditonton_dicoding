import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getTvDetail;

  DetailTvBloc(this._getTvDetail) : super(DetailTvInitial()) {
    on<GetDetailTvEvent>((event, emit) async {
      emit(DetailTvLoading());

      final detailResult = await _getTvDetail.execute(event.idTv);

      detailResult.fold(
        (failure) {
          emit(DetailTvError(failure.message));
        },
        (movie) {
          emit(DetailTvHasData(movie));
        },
      );
    });
  }
}
