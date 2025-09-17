import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';

// container biru untuk background
// Container(
//           width: double.infinity,
//           height: 150,
//           color: AppColors.primary,
//         ),

class BalanceHeader extends StatelessWidget {
  const BalanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBalanceBuilder(),
        const Text(
          "Your Total Balance",
          style: TextStyle(fontSize: 16, color: AppColors.surface),
        ),
        const SizedBox(height: 8),
        _buildBudgetCard(),
      ],
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildBalanceBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Text("Loading...");
        }
        if (state is HomeLoading) {
          return const CircularProgressIndicator();
        } else if (state is HomeLoaded) {
          final balance = state.user.balance;
          final parts = balance.toString().padLeft(3, '0').split('.');
          final main = parts[0];
          final decimal = parts.length > 1 ? parts[1] : '00';

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Rp. $main, 1231231323",
                style: const TextStyle(
                  fontSize: 32,
                  color: AppColors.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                decimal,
                style: const TextStyle(fontSize: 20, color: AppColors.surface),
              ),
            ],
          );
        } else if (state is HomeError) {
          return Text(
            "Error: ${state.message}",
            style: const TextStyle(color: AppColors.error),
          );
          // return Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //       "Rp. 0,",
          //       style: const TextStyle(
          //         fontSize: 32,
          //         color: AppColors.primary,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text(
          //       "99",
          //       style: const TextStyle(fontSize: 20, color: AppColors.primary),
          //     ),
          //   ],
          // );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildBudgetCard() {
    return Card(
      elevation: 4,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("January Budget", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Rp. 1.000.000 / Rp. 10.000.000",
                  style: TextStyle(fontSize: 16),
                ),
                Text("10%", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.1,
              backgroundColor: AppColors.background,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text(
                  "Daily Budget - Rp. 100.000",
                  style: TextStyle(fontSize: 12),
                ),
                Spacer(),
                Text("28 Days Left", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
