import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashEvent>((event, emit) {});

    on<InitSplash>((event, emit) {
      navigateToNextScreen();
    });
  }

  Future<void> navigateToNextScreen() async {
    emit(state.copyWith(state: SplashStateEnum.loading));

    // reset the SP for testing // comment this line for production
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    SplashRedirectEnum splashRedirectEnum = SplashRedirectEnum.notLoggedIn;
    if (isFirstTime) {
      splashRedirectEnum = SplashRedirectEnum.firstTime;
    } else {
      try {
        final GoogleSignInAccount? googleUser =
            await GoogleSignIn().signInSilently(suppressErrors: false);
        if (googleUser != null) {
          splashRedirectEnum = SplashRedirectEnum.loggedIn;
        } else {
          splashRedirectEnum = SplashRedirectEnum.notLoggedIn;
        }
      } catch (error) {
        debugPrint('Google sign-in error: $error');
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        state: SplashStateEnum.loaded, redirect: splashRedirectEnum));
  }
}
