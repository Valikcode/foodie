part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitHomePage extends HomeEvent {
  @override
  List<Object> get props => [];
}

class SwipeHotAndNew extends HomeEvent {
  final int newIndex;

  const SwipeHotAndNew(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

class EmptySearchList extends HomeEvent {
  const EmptySearchList();

  @override
  List<Object?> get props => [];
}
