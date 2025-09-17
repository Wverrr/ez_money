import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EstimationHeader extends StatelessWidget {
  const EstimationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Estimasi Bulan ...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _infoCard("Pengeluaran", "Rp 2.800.000", AppColors.expense),
            const SizedBox(width: 16),
            _infoCard("Pemasukan", "Rp 3.500.000", AppColors.income),
          ],
        ),
      ],
    );
  }

  Widget _infoCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(0.1),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
