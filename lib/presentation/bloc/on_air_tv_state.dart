part of 'on_air_tv_bloc.dart';

abstract class OnAirTvState extends Equatable {
  const OnAirTvState();

  @override
  List<Object> get props => [];
}

class OnAirTvInitial extends OnAirTvState {}

class OnAirTvLoading extends OnAirTvState {}

class OnAirTvEmpty extends OnAirTvState {}

class OnAirTvHasData extends OnAirTvState {
  final List<Tv> onAirTv;

  const OnAirTvHasData(this.onAirTv);

  @override
  List<Object> get props => [onAirTv];
}

class OnAirTvError extends OnAirTvState {
  final String message;

  const OnAirTvError(this.message);

  @override
  List<Object> get props => [message];
}
