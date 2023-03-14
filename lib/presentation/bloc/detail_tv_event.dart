part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTvEvent extends DetailTvEvent {
  final int idTv;

  const GetDetailTvEvent(this.idTv);

  @override
  List<Object> get props => [idTv];
}
