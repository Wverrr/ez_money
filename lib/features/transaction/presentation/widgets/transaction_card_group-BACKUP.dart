import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionCardGroup extends StatelessWidget {
  final String date;
  final List<TransactionEntity> transactions;

  const TransactionCardGroup({
    super.key,
    required this.date,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color:AppColors.surface,
            border: Border.all(color:AppColors.primary),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color:Colors.grey.withOpacity(0.2), blurRadius: 6)],
          ),
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          child: Column(
            children: transactions.map((tx) => _buildTransaction(tx)).toList(),
          ),
        ),
        Positioned(
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: const BoxDecoration(
              color:AppColors.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            child: Text(date, style: const TextStyle(color:AppColors.surface, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildTransaction(TransactionEntity tx) {
    Color bgColor;
    switch (tx.type) {
      case 1:
        bgColor =AppColors.income;
        break;
      case 2:
        bgColor =AppColors.expense;
        break;
      case 3:
        bgColor =AppColors.saving;
        break;
      case 4:
        bgColor =AppColors.debt;
        break;
      default:
        bgColor =AppColors.onSurface;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.description ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Rp. ${tx.amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00"),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
