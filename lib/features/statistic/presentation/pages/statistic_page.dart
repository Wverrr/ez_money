import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  String _selectedMonth = 'Jul';
  int _selectedYear = 2025;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("qweqwe"),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: AppColors.primary,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildHeader(),
                    Column(
                      children: [
                        _buildFilter(),
                        const SizedBox(height: 24),
                        const ReportCharts(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.file_upload),
                    title: const Text('Import Data'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Tambahkan aksi import data di sini
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text('Cetak Laporan'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Tambahkan aksi cetak laporan di sini
                    },
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik',
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Lihat semua statistik Anda di sini!",
          style: TextStyle(
            color: AppColors.surface.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildFilter() {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown atau tombol untuk tahun
            DropdownButton<int>(
              value: _selectedYear,
              isExpanded: true,
              underline: const SizedBox(),
              items: [2023, 2024, 2025, 2026]
                  .map(
                    (year) =>
                        DropdownMenuItem(value: year, child: Text('$year')),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedYear = value;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            // Filter bulan
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'Mei',
                      'Jun',
                      'Jul',
                      'Agu',
                      'Sep',
                      'Okt',
                      'Nov',
                      'Des',
                    ].map((month) {
                      final isSelected = _selectedMonth == month;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedMonth = month;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.surface,
                            foregroundColor: isSelected
                                ? AppColors.surface
                                : Colors.black,
                            elevation: isSelected ? 2 : 0,
                            side: isSelected
                                ? BorderSide.none
                                : BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(month),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget yang berisi semua chart laporan
class ReportCharts extends StatelessWidget {
  const ReportCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChartCard(
          title: 'Arus Kas',
          chart: MonthlyCashFlowChart(income: 8500000, expense: 6250000),
        ),
        const SizedBox(height: 24),
        ChartCard(
          title: 'Rincian Pengeluaran',
          chart: ExpenseByCategoryChart(
            categoryData: const {
              'Makanan': 45,
              'Transportasi': 20,
              'Hiburan': 15,
              'Tagihan': 10,
              'Lainnya': 10,
            },
          ),
        ),
      ],
    );
  }
}

// --- SEMUA WIDGET CHART DARI FILE SEBELUMNYA DILETAKKAN DI SINI ---

class ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartCard({super.key, required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(height: 200, child: chart),
        ],
      ),
    );
  }
}

// ✅ DIPERBAIKI: Widget ini sekarang menampilkan Line Chart
class MonthlyCashFlowChart extends StatelessWidget {
  final double income;
  final double expense;

  const MonthlyCashFlowChart({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk tren mingguan dalam sebulan
    final incomeSpots = [
      const FlSpot(0, 1.5), // Minggu 1: 1.5 jt
      const FlSpot(1, 4.5), // Minggu 2: 4.5 jt (misal: gaji)
      const FlSpot(2, 1.0), // Minggu 3: 1.0 jt
      const FlSpot(3, 1.5), // Minggu 4: 1.5 jt
    ];

    final expenseSpots = [
      const FlSpot(0, 1.2), // Minggu 1: 1.2 jt
      const FlSpot(1, 2.5), // Minggu 2: 2.5 jt
      const FlSpot(2, 1.0), // Minggu 3: 1.0 jt
      const FlSpot(3, 1.55), // Minggu 4: 1.55 jt
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.1), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                final labels = ['Mg 1', 'Mg 2', 'Mg 3', 'Mg 4'];
                if (value.toInt() < labels.length) {
                  return Text(labels[value.toInt()], style: style);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}jt',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 3,
        minY: 0,
        maxY: 6, // Atur sesuai data tertinggi
        lineBarsData: [
          // Garis Pemasukan
          LineChartBarData(
            spots: incomeSpots,
            isCurved: true,
            color: AppColors.income,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.income.withOpacity(0.3),
            ),
          ),
          // Garis Pengeluaran
          LineChartBarData(
            spots: expenseSpots,
            isCurved: true,
            color: AppColors.expense,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.expense.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseByCategoryChart extends StatefulWidget {
  final Map<String, double> categoryData;

  const ExpenseByCategoryChart({super.key, required this.categoryData});

  @override
  State<ExpenseByCategoryChart> createState() => _ExpenseByCategoryChartState();
}

class _ExpenseByCategoryChartState extends State<ExpenseByCategoryChart> {
  int touchedIndex = -1;

  final List<Color> _categoryColors = [
    Colors.blue.shade400,
    Colors.yellow.shade700,
    Colors.pink.shade400,
    Colors.purple.shade400,
    Colors.teal.shade400,
    Colors.orange.shade400,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: _buildPieChartSections(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.categoryData.length, (index) {
              return _buildIndicator(
                color: _categoryColors[index % _categoryColors.length],
                text: widget.categoryData.keys.elementAt(index),
              );
            }),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return List.generate(widget.categoryData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final entry = widget.categoryData.entries.elementAt(i);

      return PieChartSectionData(
        color: _categoryColors[i % _categoryColors.length],
        value: entry.value,
        title: '${entry.value.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black26, blurRadius: 2)],
        ),
      );
    });
  }

  Widget _buildIndicator({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
