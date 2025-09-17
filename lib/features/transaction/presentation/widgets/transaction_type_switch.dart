
import 'package:flutter/material.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';

class TransactionTypeSwitch extends StatefulWidget {
  const TransactionTypeSwitch({super.key});

  @override
  State<TransactionTypeSwitch> createState() => _TransactionTypeSwitchState();
}

class _TransactionTypeSwitchState extends State<TransactionTypeSwitch> {
  TransactionType _selectedType = TransactionType.pemasukan;

  @override
  Widget build(BuildContext context) {
    final types = {
      TransactionType.pemasukan: 'Pemasukan',
      TransactionType.pengeluaran: 'Pengeluaran',
      TransactionType.tabungan: 'Tabungan',
      TransactionType.hutang: 'Hutang',
    };

    return Wrap(
      spacing: 8,
      children: types.entries.map((entry) {
        final type = entry.key;
        final label = entry.value;
        final isSelected = _selectedType == type;

        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedType = type;
            });
            context.read<TransactionBloc>().add(ChangeTransactionTypeEvent(_selectedType));
            context.read<CategoryBloc>().add(GetCategoriesByTypeEvent(_selectedType.index + 1));
          },
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.primary.withOpacity(0.1),
        );
      }).toList(),
    );
  }
}
