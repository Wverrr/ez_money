part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoryEvent {
  final bool isExpense;

  const GetAllCategoriesEvent(this.isExpense);

  @override
  List<Object> get props => [isExpense];
}

class GetCategoryEvent extends CategoryEvent {
  final int id;

  const GetCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InsertCategoryEvent extends CategoryEvent {
  final CategoryEntity category;
  final bool isExpense;

  const InsertCategoryEvent(this.category, this.isExpense);

  @override
  List<Object> get props => [category, isExpense];
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryEntity category;

  const UpdateCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;

  const DeleteCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetCategoriesByTypeEvent extends CategoryEvent {
  final int type;

  const GetCategoriesByTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}

// class ChangeCategoryTypeEvent extends CategoryEvent {
//   final bool isExpense;

//   const ChangeCategoryTypeEvent(this.isExpense);

//   @override
//   List<Object> get props => [isExpense];
// }   