import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class GetEstimationPage extends StatelessWidget {
  const GetEstimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estimasi"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          TextField(
            
          )
        ],
      ),
    );
  }
}