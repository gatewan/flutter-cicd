import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/widgets/tv_card_list.dart';
import 'package:m_tv/m_tv.dart';
import 'package:provider/provider.dart';

class TvTopRatedPage extends StatefulWidget {
  const TvTopRatedPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvTopRatedBloc>().add(const OnTvTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(builder: (context, state) {
          if (state is StateLoadingTopRated) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorTopRated) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is StateTvTopRated) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tvs[index];
                return TvCard(tv);
              },
              itemCount: state.tvs.length,
            );
          } else {
            return const Center();
          }
        }),
      ),
    );
  }
}
