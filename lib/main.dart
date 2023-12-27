import 'package:flutter/material.dart';
import 'package:movie_app/assets/Colors.dart';
import 'package:movie_app/classes/MoviesList.dart';
import 'package:movie_app/helpers/movie_provider.dart';
import 'package:movie_app/helpers/network_provider.dart';
import 'package:movie_app/pages/Movies.dart';
import 'package:provider/provider.dart';

import 'helpers/sqflit_provider.dart';
import 'pages/MovieDetail.dart';
import 'widgets/dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Appdialog.dialog.setupLocator();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MoviesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: NetworkProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SqfliteProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: locator<Appdialog>().navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: AppColor.appTheme,
        ),
        initialRoute: '/MovieList',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/MovieList':
              return MaterialPageRoute(
                builder: (context) => const Movies(),
              );
            case '/MovieDetails':
              return MaterialPageRoute(
                builder: (context) => MovieDetial(
                  detial: settings.arguments as MoviesList,
                ),
              );
          }
          return null;
        },
      ),
    );
  }
}
