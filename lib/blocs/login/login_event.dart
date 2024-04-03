part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithGoogle extends LoginEvent {
  @override
  List<Object> get props => [];
}

class FetchUserInfo extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
