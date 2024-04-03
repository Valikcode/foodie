part of 'login_bloc.dart';

enum LoginStateEnum { init, loading, loaded, error }

class LoginState extends Equatable {
  final LoginStateEnum state;
  final String name;
  final String photoUrl;

  const LoginState({
    this.state = LoginStateEnum.init,
    this.name = '',
    this.photoUrl = '',
  });

  LoginState copyWith({
    LoginStateEnum? state,
    String? name,
    String? photoUrl,
  }) =>
      LoginState(
          state: state ?? this.state,
          name: name ?? this.name,
          photoUrl: photoUrl ?? this.photoUrl);

  @override
  List<Object> get props => [state, name, photoUrl];
}
