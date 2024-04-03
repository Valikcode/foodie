part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class InitSplash extends SplashEvent {
  @override
  List<Object?> get props => [];
}
