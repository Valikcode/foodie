part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();
}

class InitMain extends MainEvent {
  @override
  List<Object> get props => [];
}

class GetLocation extends MainEvent {
  @override
  List<Object> get props => [];
}

class ChangePage extends MainEvent {
  final int newPageIndex;

  const ChangePage(this.newPageIndex);

  @override
  List<Object> get props => [newPageIndex];
}
