import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.account_balance_wallet_outlined, 'title': 'Akun & Dompet'},
      {'icon': Icons.category_outlined, 'title': 'Kategori Transaksi'},
      {'icon': Icons.download_outlined, 'title': 'Ekspor Data'},
      {'icon': Icons.settings_outlined, 'title': 'Pengaturan'},
      {'icon': Icons.info_outline, 'title': 'Tentang Aplikasi'},
      {'icon': Icons.logout, 'title': 'Keluar'},
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary),
      body: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: AppColors.primary,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ahmad Rhesa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text('Ganti Akun'),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return _buildMenuTile(
                      icon: item['icon'],
                      title: item['title'],
                      onTap: () {
                        // Logika navigasi untuk setiap menu
                        print('${item['title']} ditekan');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget helper untuk membuat satu baris menu
  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
