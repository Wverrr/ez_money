import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
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
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: AppColors.primary,
            ),
            Column(
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TransactionList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Text(
              'Hai, ${state.user.name}',
              style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.bold),
            );
          }
          return Text(
            'Hai, User',
            style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.bold),
          );
        },
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


