part of 'splash_bloc.dart';

enum SplashStateEnum { init, loading, loaded, error }

enum SplashRedirectEnum { firstTime, loggedIn, notLoggedIn }

@immutable
class SplashState extends Equatable {
  final SplashStateEnum state;
  final SplashRedirectEnum redirect;

  const SplashState({
    this.state = SplashStateEnum.init,
    this.redirect = SplashRedirectEnum.firstTime,
  });

  SplashState copyWith({
    SplashStateEnum? state,
    SplashRedirectEnum? redirect,
  }) =>
      SplashState(
        state: state ?? this.state,
        redirect: redirect ?? this.redirect,
      );

  @override
  List<Object?> get props => [state];
}
