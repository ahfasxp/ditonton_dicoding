import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv.dart';
import 'package:flutter/foundation.dart';

class OnAirTvNotifier extends ChangeNotifier {
  final GetOnAirTv getOnAirTv;

  OnAirTvNotifier(this.getOnAirTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _listTv = [];
  List<Tv> get listTv => _listTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _listTv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
