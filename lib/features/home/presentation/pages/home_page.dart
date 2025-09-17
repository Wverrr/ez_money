import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/balance_header.dart';
import '../widgets/menu_grid.dart';
import '../widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BalanceHeader(),
            SizedBox(height: 16),
            MenuGrid(),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Transaction History",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 8),
            TransactionList(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        'Hai, Rhesa',
        style: TextStyle(
          color: AppColors.surface,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: AppColors.surface),
          onPressed: () {},
        ),
      ],
    );
  }
}
