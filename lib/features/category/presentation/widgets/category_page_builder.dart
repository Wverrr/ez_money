import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';

class CategoryPageBuilder extends StatelessWidget {
  const CategoryPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryEmpty) {
          return const Center(child: Text('Tidak ada kategori'));
        } else if (state is CategoryLoaded) {
          print('Category Loaded: ${state.categories.length}');
          return ListView.separated(
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return ListTile(
                title: Text(category.name),
                leading: Icon(
                  category.type == 1
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: category.type == 1 ? Colors.green : Colors.red,
                ),
              );
            },
          );
        } else if (state is CategoryLoadError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Text('state tidak ditemukan');
      },
    );
  }
}
