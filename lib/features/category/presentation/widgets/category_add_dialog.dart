
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../bloc/category_bloc.dart';

Future<void> showAddCategoryDialog(BuildContext context, bool isExpense) async {
  final nameController = TextEditingController();
  bool tempIsExpense = isExpense;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Tambah Kategori"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Kategori'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Expense?"),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Switch(
                      value: tempIsExpense,
                      onChanged: (val) => setState(() => tempIsExpense = val),
                    );
                  },
                )
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newCategory = CategoryEntity(
                id: 0,
                name: nameController.text,
                type: tempIsExpense ? 2 : 1,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              context.read<CategoryBloc>().add(
                    InsertCategoryEvent(newCategory, isExpense), 
                  );
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          )
        ],
      );
    },
  );
}
