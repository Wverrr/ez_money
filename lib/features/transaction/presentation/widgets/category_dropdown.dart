import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/bloc/category_bloc.dart';

class CategoryDropdown extends StatelessWidget {

  final CategoryEntity? value;
  final Function(CategoryEntity?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoryLoaded) {
              if (state.categories.isEmpty) {
                return const Text("Tidak ada kategori tersedia");
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CategoryEntity>(
                    isExpanded: true,

                    value: value,
                    hint: const Text("Pilih kategori"),
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
                    items: state.categories.map((category) {
                      return DropdownMenuItem<CategoryEntity>(
                        value: category,
                        child: Text(category.name, style: const TextStyle(color: AppColors.textPrimary)),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}