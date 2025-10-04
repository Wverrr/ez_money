
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/transaction_card_group-BACKUP.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionLoaded) {
            final grouped = _groupByDate(state.transactions);
            return ListView(
              padding: const EdgeInsets.all(12),
              children: grouped.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TransactionCardGroup(
                    date: entry.key,
                    transactions: entry.value,
                  ),
                );
              }).toList(),
            );
          }

          return const Center(child: Text("Terjadi kesalahan."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('transaction_insert_form');

                  context.read<CategoryBloc>().add(GetCategoriesByTypeEvent(1));
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 1,
      shadowColor: Colors.black12,
      title: const Text(
        "Transaksi",
        style: TextStyle(color: AppColors.surface),
      ),
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.surface),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: AppColors.surface),
          onPressed: () {},
        ),
      ],
    );
  }

  Map<String, List<TransactionEntity>> _groupByDate(
    List<TransactionEntity> transactions,
  ) {
    final Map<String, List<TransactionEntity>> map = {};
    for (final tx in transactions) {
      final date =
          "${tx.date.day.toString().padLeft(2, '0')}/${tx.date.month.toString().padLeft(2, '0')}/${tx.date.year}";
      map.putIfAbsent(date, () => []).add(tx);
    }
    return map;
  }
}
