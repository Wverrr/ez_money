import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Center(
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(32, 40, 32, 80),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, -16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    )),
                const SizedBox(height: 16),
                Text(description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.onSurface,
                      height: 1.5,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
