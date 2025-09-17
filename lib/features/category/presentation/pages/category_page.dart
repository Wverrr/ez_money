import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';
import '../widgets/category_add_dialog.dart';
import '../widgets/category_page_builder.dart';
import '../widgets/category_snackbar_handler.dart';
import '../widgets/category_type_switch.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategorySnackbarHandler(
      child: Scaffold(
        appBar: AppBar(title: const Text('Kategori List')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [CategoryTypeSwitch()]),
              const SizedBox(height: 10),
              Expanded(child: CategoryPageBuilder()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final blocState = context.read<CategoryBloc>().state;
            final isExpense =
                blocState is CategoryLoaded
                    ? blocState.categories.first.type == 2
                    : false;
            showAddCategoryDialog(context, isExpense);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
