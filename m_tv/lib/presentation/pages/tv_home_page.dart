import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/utils/routes.dart';
import 'package:m_tv/m_tv.dart';

class TvHomePage extends StatefulWidget {
  const TvHomePage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<TvHomePage> {
  bool _isTv = true;

  @override
  void initState() {
    super.initState();
    context.read<TvNowPlayingBloc>().add(const OnTvNowPlaying());
    context.read<TvPopularBloc>().add(const OnTvPopular());
    context.read<TvTopRatedBloc>().add(const OnTvTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Movie'),
              onTap: () {
                Navigator.pushNamed(context, routeHomeMovie);
              },
            ),
            ListTile(
              leading: const Icon(Icons.connected_tv),
              title: const Text('Tv'),
              onTap: () {
                Navigator.pushNamed(context, routeHomeTv);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, routeWatchList);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, routeAbout);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, routeSearchTv, arguments: _isTv);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: _buildColumn(),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              key: Key(title),
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'On The Air',
          style: kHeading6,
        ),
        BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(builder: (context, state) {
          if (state is StateLoadingNowPlaying) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorNowPlaying) {
            return Text(state.message);
          } else if (state is StateEmptyNowPlaying) {
            return const Text('No available tv right now');
          } else if (state is StateTvNowPlaying) {
            return TvList(state.tvs);
          } else {
            return const Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () => Navigator.pushNamed(context, routePopularTv, arguments: _isTv),
        ),
        BlocBuilder<TvPopularBloc, TvPopularState>(builder: (context, state) {
          if (state is StateLoadingPopular) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorPopular) {
            return Text(state.message);
          } else if (state is StateEmptyPopular) {
            return const Text('No available tv right now');
          } else if (state is StateTvPopular) {
            return TvList(state.tvs);
          } else {
            return const Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () => Navigator.pushNamed(context, routeTopRateTv, arguments: _isTv),
        ),
        BlocBuilder<TvTopRatedBloc, TvTopRatedState>(builder: (context, state) {
          if (state is StateLoadingTopRated) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorTopRated) {
            return Text(state.message);
          } else if (state is StateEmptyTopRated) {
            return const Text('No available tv right now');
          } else if (state is StateTvTopRated) {
            return TvList(state.tvs);
          } else {
            return const Text('Failed');
          }
        }),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeDetailTv,
                  arguments: [tv.id],
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
