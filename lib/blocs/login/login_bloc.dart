import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  LoginBloc() : super(const LoginState()) {
    on<LoginEvent>((event, emit) {});

    on<LoginWithGoogle>((event, emit) async {
      _loginWithGoogle();
      await _saveUserInfoInState();
    });

    on<FetchUserInfo>((event, emit) async {
      await _saveUserInfoInState();
    });

    on<LogoutEvent>((event, emit) async {
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.signOut();

        debugPrint('Name:${_googleSignIn.currentUser?.displayName}');
      } else {
        debugPrint('User already signed out or not signed in.');
      }
      emit(state.copyWith(name: null, photoUrl: null));
    });
  }

  Future<void> _loginWithGoogle() async {
    emit(state.copyWith(state: LoginStateEnum.loading));
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      await googleUser!.authentication;

      final name = googleUser.displayName;
      final email = googleUser.email;
      final photoUrl = googleUser.photoUrl;

      debugPrint('Email: $email');
      debugPrint('Name: ${name!}');
      debugPrint('photoUrl: ${photoUrl!}');

      emit(state.copyWith(state: LoginStateEnum.loaded));
    } catch (error) {
      debugPrint('Login error: $error');
      emit(state.copyWith(state: LoginStateEnum.error));
    }
  }

  Future<void> _saveUserInfoInState() async {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleUser) {
      debugPrint("User Name: $googleUser");
      if (googleUser != null) {
        final name = googleUser.displayName;
        final photoUrl = googleUser.photoUrl;
        debugPrint("User Name: $name");
        debugPrint("User Photo: $photoUrl");

        emit(state.copyWith(name: name, photoUrl: photoUrl));
      }
    });
    await _googleSignIn.signInSilently();
  }
}
