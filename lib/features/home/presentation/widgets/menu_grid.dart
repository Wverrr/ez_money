import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../../debt/presentation/bloc/debt_bloc.dart';
import '../../../saving/presentation/bloc/saving_bloc.dart';
import '../../../transaction/presentation/bloc/transaction_bloc.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Transaksi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Catat keuanganmu",
                        style: TextStyle(fontSize: 12, color: AppColors.onSurface),
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: AppColors.surface),
                      onPressed: () {
                        // context.pushNamed('add_transaction_page');
                        // context.read<TransactionBloc>().add(GetAllTransactionsEvent());
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
                children: [
                _buildMenuItem(
                  icon: Icons.category,
                  label: 'Kategori',
                  onTap: () {
                  context.pushNamed('category_page');
                  context.read<CategoryBloc>().add(
                    GetAllCategoriesEvent(false),
                  );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.swap_horiz,
                  label: 'Transaksi',
                  onTap: () {
                  context.pushNamed('transaction_page');
                  context.read<TransactionBloc>().add(
                    GetAllTransactionsEvent(),
                  );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.account_balance,
                  label: 'Hutang',
                  onTap: () {
                  context.pushNamed('debt_page');
                  context.read<DebtBloc>().add(GetAllDebtsEvent());
                  },
                ),
                _buildMenuItem(
                  icon: Icons.savings,
                  label: 'Tabungan',
                  onTap: () {
                  context.pushNamed('saving_page');
                  context.read<SavingBloc>().add(GetAllSavingsEvent());
                  },
                ),
                _buildMenuItem(
                    icon: Icons.calculate,
                  label: 'Estimasi',
                  onTap: () {
                  context.pushNamed('estimation_page');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.more_horiz,
                  label: 'More',
                  onTap: () {
                  // context.pushNamed('more_page');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(onTap: onTap, child: Icon(icon, color: AppColors.primary)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
