import 'package:flutter/material.dart';

class EstimationCategoryList extends StatelessWidget {
  const EstimationCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = [
      {'name': 'Makan', 'amount': 850000},
      {'name': 'Transportasi', 'amount': 400000},
      {'name': 'Hiburan', 'amount': 300000},
    ];

    return ListView.separated(
      itemCount: dummyData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = dummyData[index];
        return ListTile(
          tileColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(item['name'].toString()),
          trailing: Text("Rp ${item['amount']}"),
        );
      },
    );
  }
}
