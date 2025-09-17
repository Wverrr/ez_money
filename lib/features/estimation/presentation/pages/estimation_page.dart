import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/estimation_entity.dart'; // Pastikan import entity ini
import '../../domain/entities/train_record_entity.dart';
import '../bloc/estimation_bloc.dart';
import '../widgets/estimation_card.dart';
import '../widgets/estimation_header.dart';

class EstimationPage extends StatelessWidget {
  const EstimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimasi'),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      // 1. Gunakan BlocBuilder untuk membuat UI reaktif terhadap state
      body: BlocBuilder<EstimationBloc, EstimationState>(
        builder: (context, state) {
          // Tampilkan loading indicator saat proses berlangsung
          if (state is EstimationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tampilkan UI utama jika state berhasil dimuat (EstimationLoaded)
          if (state is EstimationLoaded) {
            return _buildLoadedBody(context, state);
          }
          
          // Tampilkan pesan error jika terjadi kesalahan
          if (state is EstimationError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Terjadi Kesalahan: ${state.message}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Sediakan tombol untuk mencoba train lagi jika terjadi error
                    _buildTrainButton(context),
                  ],
                ),
              ),
            );
          }

          // Tampilan awal (Initial State) sebelum ada aksi
          return _buildInitialBody(context);
        },
      ),
    );
  }

  // Widget untuk tampilan awal atau jika belum ada data
  Widget _buildInitialBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.insights, size: 60, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text(
              'Latih Model Terlebih Dahulu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Latih model dengan data transaksi Anda untuk mendapatkan estimasi pengeluaran.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTrainButton(context),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan body utama setelah data estimasi berhasil didapat
  Widget _buildLoadedBody(BuildContext context, EstimationLoaded state) {
    // 2. Gunakan SingleChildScrollView untuk mengatasi overflow
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EstimationHeader(),
            const SizedBox(height: 16),
            // 3. Ambil data estimasi & analisis dari state BLoC
            EstimationCard(
              estimatedExpense: state.estimation.estimatedExpense,
              analysis: state.estimation.analysis,
            ),
            const SizedBox(height: 24),
            const Text(
              "Aksi Lanjutan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 4. Perbaiki tombol-tombol
            _buildTrainButton(context), // Tombol untuk Train
            const SizedBox(height: 8),
            _buildEstimateButton(context), // Tombol untuk Estimate
          ],
        ),
      ),
    );
  }

  // Widget terpisah untuk tombol Train
  Widget _buildTrainButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<EstimationBloc>().add(
          TrainEstimationEvent(
            // Data training ini sebaiknya diambil dari database/sumber lain
            // Untuk sekarang kita gunakan data dummy sesuai kode Anda
            TrainRequestEntity(
              userId: 1,
              data: [
                TrainRecordEntity(
                  income: 5000000, basicNeeds: 2000000, secondaryNeeds: 1000000,
                  debts: 500000, savings: 500000, totalExpense: 3500000,
                ),
                TrainRecordEntity(
                  income: 5200000, basicNeeds: 2100000, secondaryNeeds: 1200000,
                  debts: 400000, savings: 600000, totalExpense: 3700000,
                ),
              ],
            ),
          ),
        );
      },
      icon: const Icon(Icons.model_training),
      label: const Text("Latih Ulang Model"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  // Widget terpisah untuk tombol Estimate
  Widget _buildEstimateButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Event untuk meminta estimasi baru
        // Data input ini nantinya bisa diambil dari form/input user
        context.read<EstimationBloc>().add(
          EstimateExpenseEvent(
            EstimationRequestEntity(
              userId: 1,
              income: 5500000,
              basicNeeds: 2200000,
              secondaryNeeds: 1100000,
              debts: 450000,
              savings: 700000,
            ),
          ),
        );
      },
      icon: const Icon(Icons.calculate),
      label: const Text("Buat Estimasi Baru"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }
}