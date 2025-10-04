import 'package:flutter/material.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';

class TransactionTypeSwitch extends StatefulWidget {
  final Function(int) onTypeChanged;

  const TransactionTypeSwitch({super.key, required this.onTypeChanged});

  @override
  State<TransactionTypeSwitch> createState() => _TransactionTypeSwitchState();
}

class _TransactionTypeSwitchState extends State<TransactionTypeSwitch> {
  int _selectedTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final types = ['Pemasukan', 'Pengeluaran', 'Tabungan', 'Hutang'];

    return Wrap(
      spacing: 8,
      children: List.generate(types.length, (index) {
        final isSelected = _selectedTypeIndex == index;

        return ChoiceChip(
          label: Text(types[index]),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedTypeIndex = index;
            });

            widget.onTypeChanged(index + 1);

            context.read<CategoryBloc>().add(
              GetCategoriesByTypeEvent(index + 1),
            );
          },
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.primary.withOpacity(0.1),
        );
      }),
    );
  }
}
