import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/blocs/info/info_screen_bloc.dart';
import 'package:foodie/blocs/splash/splash_bloc.dart';
import 'package:foodie/blocs/home/home_bloc.dart';
import 'package:foodie/screens/common/info_screen.dart';
import 'package:foodie/screens/main/main_screen.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/images.dart';
import 'package:foodie/values/routes.dart';
import 'package:foodie/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(InitSplash()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.state == SplashStateEnum.loaded) {
                if (state.redirect == SplashRedirectEnum.firstTime) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BlocProvider(
                        create: (context) =>
                            InfoScreenBloc()..add(InitInfoScreenEvent()),
                        child: InfoScreen(),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero)
                              .animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                } else if (state.redirect == SplashRedirectEnum.notLoggedIn) {
                  Navigator.pushReplacementNamed(context, Routes.login);
                } else if (state.redirect == SplashRedirectEnum.loggedIn) {
                  BlocProvider.of<HomeBloc>(context).add(InitHomePage());
                }
              }
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.state == HomeStateEnum.loaded) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => MainScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end);
                      final curvedAnimation =
                          CurvedAnimation(parent: animation, curve: curve);

                      return SlideTransition(
                        position: tween.animate(curvedAnimation),
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Color(AppColors.primaryColor),
          body: Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(AppImages.logoImageLocation),
                    width: 200,
                  ),
                  const SpinKitChasingDots(
                    color: Colors.white,
                    size: 50.0,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.motto1,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        AppStrings.motto2,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    AppStrings.foodie,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
