part of 'info_screen_bloc.dart';

abstract class InfoScreenEvent extends Equatable {
  const InfoScreenEvent();
}

class InitInfoScreenEvent extends InfoScreenEvent {
  @override
  List<Object> get props => [];
}

class PageChanged extends InfoScreenEvent {
  final int selectedIndex;

  const PageChanged(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}
