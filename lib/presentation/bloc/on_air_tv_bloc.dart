import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTv _getOnAirTv;

  OnAirTvBloc(this._getOnAirTv) : super(OnAirTvInitial()) {
    on<GetOnAirTvEvent>((event, emit) async {
      emit(OnAirTvLoading());

      final onAirTv = await _getOnAirTv.execute();

      onAirTv.fold(
        (failure) {
          emit(OnAirTvError(failure.message));
        },
        (tvData) {
          if (tvData.isEmpty) {
            emit(OnAirTvEmpty());
          } else {
            emit(OnAirTvHasData(tvData));
          }
        },
      );
    });
  }
}
