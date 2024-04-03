part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class InitCategoryPage extends CategoryEvent {
  final String selectedCategoryAlias;

  const InitCategoryPage(this.selectedCategoryAlias);

  @override
  List<Object?> get props => [selectedCategoryAlias];
}

class InitAttributePage extends CategoryEvent {
  final String selectedAttributeAlias;

  const InitAttributePage(this.selectedAttributeAlias);

  @override
  List<Object?> get props => [selectedAttributeAlias];
}

class FetchNewAttributePage extends CategoryEvent {
  final String selectedAttributeAlias;

  const FetchNewAttributePage(this.selectedAttributeAlias);

  @override
  List<Object?> get props => [selectedAttributeAlias];
}

class FetchNewPage extends CategoryEvent {
  final String selectedCategoryAlias;

  const FetchNewPage(this.selectedCategoryAlias);
  @override
  List<Object?> get props => [selectedCategoryAlias];
}
