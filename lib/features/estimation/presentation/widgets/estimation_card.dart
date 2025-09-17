import 'package:flutter/material.dart';

class EstimationCard extends StatelessWidget {
  final double estimatedExpense;
  final Map<String, dynamic> analysis;

  const EstimationCard({
    super.key,
    required this.estimatedExpense,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hasil Estimasi",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Total Pengeluaran: Rp ${estimatedExpense.toStringAsFixed(0)}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text("Analisis:", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...analysis.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(child: Text("${e.key}: ${e.value}")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
