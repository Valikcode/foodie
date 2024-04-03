import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/adapters/restaurant_hive_adapter.dart';
import 'package:foodie/blocs/bookmark/bookmark_bloc.dart';
import 'package:foodie/blocs/home/home_bloc.dart';
import 'package:foodie/blocs/login/login_bloc.dart';
import 'package:foodie/screens/auth/login_screen.dart';
import 'package:foodie/screens/common/info_screen.dart';
import 'package:foodie/screens/common/splash_screen.dart';
import 'package:foodie/screens/main/main_screen.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/routes.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<BookmarkBloc>(
          create: (context) => BookmarkBloc()
            ..add(
              InitBookmarkStatus(),
            ),
        ),
      ],
      child: MaterialApp(
        routes: {
          Routes.login: (context) => const LoginScreen(),
          Routes.info: (context) => InfoScreen(),
          Routes.splash: (context) => const SplashScreen(),
          Routes.main: (context) => const MainScreen(),
        },
        title: 'Foodie',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color(AppColors.primaryColor)),
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            displayMedium: TextStyle(fontSize: 24, color: Colors.white),
            titleLarge: TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
