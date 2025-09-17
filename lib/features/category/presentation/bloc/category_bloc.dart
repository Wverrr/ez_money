import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_category_by_type.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/delete_category.dart';
import '../../domain/usecases/get_all_categories.dart';
import '../../domain/usecases/get_category.dart';
import '../../domain/usecases/insert_category.dart';
import '../../domain/usecases/update_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories getAllCategories;
  final GetCategory getCategory;
  final InsertCategory insertCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;
  final GetCategoriesByType getCategoriesByType;

  CategoryBloc(
    this.getAllCategories,
    this.getCategory,
    this.insertCategory,
    this.updateCategory,
    this.deleteCategory,
    this.getCategoriesByType,
  ) : super(CategoryLoading()) {
    on<GetAllCategoriesEvent>(_onGetAllCategoriesEvent);
    on<GetCategoryEvent>(_onGetCategoryEvent);
    on<InsertCategoryEvent>(_onInsertCategoryEvent);
    on<UpdateCategoryEvent>(_onUpdateCategoryEvent);
    on<DeleteCategoryEvent>(_onDeleteCategoryEvent);
    on<GetCategoriesByTypeEvent>(_onGetCategoriesByTypeEvent);
    // on<ChangeCategoryTypeEvent>(_onCategoryTypeChangedEvent);
  }

  Future<void> _onGetAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final result = await getAllCategories.execute();

    result.fold((failure) => emit(CategoryLoadError(failure.message)), (
      categories,
    ) {
      // print('Categories: $categories');
      final filteredCategories =
          categories
              .where((category) => category.type == (event.isExpense ? 2 : 1))
              .toList();
      if (filteredCategories.isEmpty) {
        emit(CategoryEmpty());
      } else {
        emit(CategoryLoaded(filteredCategories));
      }
    });
  }

  Future<void> _onGetCategoryEvent(
    GetCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await getCategory.execute(event.id);
    result.fold(
      (failure) => emit(CategoryLoadError(failure.message)),
      (category) => emit(CategoryLoaded([category])),
    );
  }

  Future<void> _onInsertCategoryEvent(
    InsertCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await insertCategory.execute(event.category);

    result.fold(
      (failure) => emit(CategoryActionError(failure.message)), 
      (_) {
        emit(CategoryActionSuccess('Berhasil menambah kategori'));
        add(GetAllCategoriesEvent(false));
      }
    );
  }

  Future<void> _onUpdateCategoryEvent(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await updateCategory.execute(event.category);
  }

  Future<void> _onDeleteCategoryEvent(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await deleteCategory.execute(event.id);
  }

  Future<void> _onGetCategoriesByTypeEvent(
    GetCategoriesByTypeEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final result = await getCategoriesByType.execute(event.type);

    result.fold((failure) => emit(CategoryLoadError(failure.message)), (
      categories,
    ) {
      if (categories.isEmpty) {
        emit(CategoryEmpty());
      } else {
        emit(CategoryLoaded(categories));
      }
    });
  }
  // Future<void> _onCategoryTypeChangedEvent(
  //   ChangeCategoryTypeEvent event,
  //   Emitter<CategoryState> emit,
  // ) async {
  //   if (state is CategoryLoaded) {
  //     final currentState = state as CategoryLoaded;
  //     emit(CategoryLoaded(currentState.categories));
  //   }
  // }
}
