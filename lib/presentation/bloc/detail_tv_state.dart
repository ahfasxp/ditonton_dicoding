part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTvInitial extends DetailTvState {}

class DetailTvLoading extends DetailTvState {}

class DetailTvEmpty extends DetailTvState {}

class DetailTvHasData extends DetailTvState {
  final TvDetail tvDetail;

  const DetailTvHasData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DetailTvError extends DetailTvState {
  final String message;

  const DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}
