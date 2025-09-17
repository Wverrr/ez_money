import 'package:flutter/material.dart';

class EstimationChart extends StatelessWidget {
  const EstimationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text("Chart Placeholder"),
      ),
    );
  }
}
