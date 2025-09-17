import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';

class CategoryTypeSwitch extends StatefulWidget {
  const CategoryTypeSwitch({super.key});

  @override
  State<CategoryTypeSwitch> createState() => _CategoryTypeSwitchState();
}

class _CategoryTypeSwitchState extends State<CategoryTypeSwitch> {
  int selectedType = 1;

  @override
  Widget build(BuildContext context) {

    return Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ChoiceChip(
              label: const Text("INCOME"),
              selected: selectedType == 1,
              onSelected: (_) {
                setState(() {
                  selectedType = 1;
                });
                context.read<CategoryBloc>().add(GetAllCategoriesEvent(false));
              },
              selectedColor: Colors.green.shade100,
              labelStyle: TextStyle(
                color: selectedType == 1 ? Colors.green : Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              label: const Text("EXPENSE"),
              selected: selectedType == 2,
              onSelected: (_) {
                setState(() {
                  selectedType = 2;
                });
                context.read<CategoryBloc>().add(GetAllCategoriesEvent(true));
              },
              selectedColor: Colors.red.shade100,
              labelStyle: TextStyle(
                color: selectedType == 2 ? Colors.red : Colors.black,
              ),
            ),
          ],
        );
  }
}

