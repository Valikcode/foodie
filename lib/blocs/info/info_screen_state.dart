part of 'info_screen_bloc.dart';

enum InfoScreenEnum { init, loading, loaded, error }

class InfoScreenState extends Equatable {
  final InfoScreenEnum state;
  final int selectedIndex;

  const InfoScreenState({
    this.state = InfoScreenEnum.init,
    this.selectedIndex = 0,
  });

  InfoScreenState copyWith({
    InfoScreenEnum? state,
    int? selectedIndex,
  }) =>
      InfoScreenState(
        state: state ?? this.state,
        selectedIndex: selectedIndex ?? this.selectedIndex,
      );

  @override
  List<Object> get props => [selectedIndex];
}
