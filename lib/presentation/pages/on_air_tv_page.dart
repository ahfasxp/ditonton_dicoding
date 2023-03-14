import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv';

  @override
  _OnAirTvPageState createState() => _OnAirTvPageState();
}

class _OnAirTvPageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<OnAirTvBloc>().add(GetOnAirTvEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvEmpty) {
              return const Text('Not Found');
            } else if (state is OnAirTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.onAirTv[index];
                  return TvCard(tv);
                },
                itemCount: state.onAirTv.length,
              );
            } else if (state is OnAirTvError) {
              return Text(state.message);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
