import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../bloc/boarding_bloc.dart';
import '../widgets/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Kelola Keuanganmu dengan Mudah',
      'description':
          'Catat pemasukan, pengeluaran, tabungan, dan utang dalam satu aplikasi.',
      'image': 'assets/images/onboarding1.jpg',
    },
    {
      'title': 'Statistik dan Estimasi Otomatis',
      'description':
          'Dapatkan grafik dan estimasi keuangan bulanan berdasarkan kebiasaan kamu.',
      'image': 'assets/images/onboarding2.jpg',
    },
    {
      'title': 'Tambahkan Akun',
      'description':
          'Masukkan nama akun dan saldo awal untuk memulai perjalanan finansialmu.',
      'image': 'assets/images/onboarding3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<BoardingBloc, BoardingState>(
      listener: (context, state) {
        if (state is BoardingSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Akun berhasil dibuat!")),
          );
          context.pushReplacementNamed('home');
          context.read<HomeBloc>().add(LoadHomeEvent(state.user.id!));
        } else if (state is BoardingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  if (index == 2) {
                    return _buildUserForm(page);
                  }
                  return OnboardingContent(
                    imagePath: page['image']!,
                    title: page['title']!,
                    description: page['description']!,
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: AppColors.primary,
                      elevation: 5,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    if (_currentIndex < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final name = _nameController.text.trim();
      final balance = double.tryParse(_balanceController.text) ?? 0;

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nama akun tidak boleh kosong")),
        );
        return;
      }

      final user = UserEntity(
        id: 1,
        name: name,
        balance: balance,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      context.read<BoardingBloc>().add(OnBoardingSaveButtonPressed(user));
      context.read<HomeBloc>().add(LoadHomeEvent(user.id!));
    }
  }

  Widget _buildUserForm(Map<String, String> page) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambahkan Akun",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Masukkan nama akun dan saldo awal untuk memulai perjalanan finansialmu.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.onSurface,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: AppColors.onSurface),
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: AppColors.onSurface),
                          labelText: "Nama Akun",
                          floatingLabelStyle: const TextStyle(color: AppColors.primary),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.onSurface),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _balanceController,
                        style: const TextStyle(color: AppColors.onSurface),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: AppColors.primary),
                          labelText: "Saldo Awal",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.onSurface),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
