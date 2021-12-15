import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/utils/routes.dart';
import 'package:lib_core/utils/ssl_pinning.dart';
import 'package:m_about/m_about.dart';
import 'package:m_movie/m_movie.dart';
import 'package:m_movie/presentation/pages/movie_detail_page.dart';
import 'package:m_movie/presentation/pages/movie_home_page.dart';
import 'package:m_movie/presentation/pages/movie_popular_page.dart';
import 'package:m_movie/presentation/pages/movie_search_page.dart';
import 'package:m_movie/presentation/pages/movie_top_rated_page.dart';
import 'package:m_tv/m_tv.dart';
import 'package:m_tv/presentation/pages/tv_detail_page.dart';
import 'package:m_tv/presentation/pages/tv_home_page.dart';
import 'package:m_tv/presentation/pages/tv_popular_page.dart';
import 'package:m_tv/presentation/pages/tv_search_page.dart';
import 'package:m_tv/presentation/pages/tv_top_rated_page.dart';
import 'package:m_watchlist/m_watchlist.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //MOVIE HERE
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchListBloc>(),
        ),
        //TV HERE
        BlocProvider(
          create: (_) => di.locator<TvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchListBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: MovieHomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case routeHomeMovie:
              return MaterialPageRoute(builder: (_) => MovieHomePage());
            case routeHomeTv:
              return MaterialPageRoute(builder: (_) => TvHomePage());
            case routePopularMovie:
              return CupertinoPageRoute(
                builder: (_) => MoviePopularPage(),
                settings: settings,
              );
            case routePopularTv:
              return CupertinoPageRoute(
                builder: (_) => TvPopularPage(),
                settings: settings,
              );
            case routeTopRateMovie:
              return CupertinoPageRoute(builder: (_) => MovieTopRatedPage());
            case routeTopRateTv:
              return CupertinoPageRoute(builder: (_) => TvTopRatedPage());
            case routeDetailMovie:
              final arg = settings.arguments as List<dynamic>;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(
                  id: arg[0],
                ),
                settings: settings,
              );
            case routeDetailTv:
              final arg = settings.arguments as List<dynamic>;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(
                  id: arg[0],
                ),
                settings: settings,
              );
            case routeSearchMovie:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case routeSearchTv:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case routeWatchList:
              return MaterialPageRoute(builder: (_) => WatchListPage());
            case routeAbout:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
