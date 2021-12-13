import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/lib_core.dart';
import 'package:provider/provider.dart';

import '../../m_tv.dart';

class TvPopularPage extends StatefulWidget {
  const TvPopularPage({Key? key}) : super(key: key);

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<TvPopularPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvPopularBloc>().add(const OnTvPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(builder: (context, state) {
          if (state is StateLoadingPopular) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorPopular) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is StateTvPopular) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tvs[index];
                return TvCard(tv);
              },
              itemCount: state.tvs.length,
            );
          } else {
            return const Text('Failed');
          }
        }),
      ),
    );
  }
}
