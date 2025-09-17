import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/presentation/bloc/category_bloc.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // BlocBuilder untuk ambil kategori dari CategoryBloc
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              final categories = state.categories;

              // kalau belum ada data
              if (categories.isEmpty) {
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
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedCategory,
                    hint: const Text("Pilih kategori"),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                    ),
                    items: categories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category.name,
                            child: Text(
                              category.name,
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              );
            } else if (state is CategoryLoadError) {
              return Text("Error: ${state.message}");
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
