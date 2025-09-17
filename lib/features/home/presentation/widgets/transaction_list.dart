import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.surface,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.monetization_on),
            title: Text("Transaction Title ${index + 1}"),
            subtitle: Text("Transaction Description ${index + 1}"),
            trailing: Text("Rp. ${100000 * (index + 1)}"),
          ),
        );
      },
    );
  }
}
