part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();  

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryEmpty extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryLoadError extends CategoryState {
  final String message;

  const CategoryLoadError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryActionSuccess extends CategoryState {
  final String message;

  const CategoryActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryActionError extends CategoryState {
  final String message;

  const CategoryActionError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryTypeChanged extends CategoryState {
  final bool isExpense;

  const CategoryTypeChanged(this.isExpense);

  @override
  List<Object> get props => [isExpense];
}
