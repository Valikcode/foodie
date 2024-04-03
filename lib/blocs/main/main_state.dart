part of 'main_bloc.dart';

enum MainStateEnum { init, loading, loaded, error }

@immutable
class MainState extends Equatable {
  final MainStateEnum state;
  final int pageIndex;
  final LatLng phoneLocation;
  final String phoneLocationString;

  const MainState({
    this.state = MainStateEnum.init,
    this.pageIndex = 0,
    this.phoneLocation = const LatLng(0, 0),
    this.phoneLocationString = '',
  });

  MainState copyWith({
    MainStateEnum? state,
    int? pageIndex,
    LatLng? phoneLocation,
    String? phoneLocationString,
  }) =>
      MainState(
        state: state ?? this.state,
        pageIndex: pageIndex ?? this.pageIndex,
        phoneLocation: phoneLocation ?? this.phoneLocation,
        phoneLocationString: phoneLocationString ?? this.phoneLocationString,
      );

  @override
  List<Object> get props =>
      [state, pageIndex, phoneLocation, phoneLocationString];
}
