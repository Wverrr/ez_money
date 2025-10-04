import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../../../core/constants/app_colors.dart';

class TransactionListTile extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionListTile({super.key, required this.transactions});

  IconData _getIconForType(int type) {
    switch (type) {
      case 1:
        return Icons.arrow_downward_rounded;
      case 2:
        return Icons.arrow_upward_rounded;
      case 3:
        return Icons.savings_rounded;
      case 4:
        return Icons.receipt_long_rounded;
      default:
        return Icons.question_mark_rounded;
    }
  }

  Color _getAmountColor(int type) {
    return type == 1 ? AppColors.income : AppColors.expense;
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final amountColor = _getAmountColor(transaction.type);

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: amountColor.withOpacity(0.2),
            foregroundColor: amountColor,
            child: Icon(_getIconForType(transaction.type)),
          ),
          title: Text(
            transaction.description ?? 'Tanpa Deskripsi',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat('d MMM yyyy', 'id_ID').format(transaction.date),
          ),
          trailing: Text(
            currencyFormatter.format(transaction.amount),
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          onTap: () {
            // call
          },
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
    );
  }
}
