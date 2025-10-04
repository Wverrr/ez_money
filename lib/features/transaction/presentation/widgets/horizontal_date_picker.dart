import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';

class HorizontalDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;

  const HorizontalDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  final ScrollController _scrollController = ScrollController();
  final List<DateTime> _dates = List.generate(
    61,
    (index) =>
        DateTime.now().subtract(const Duration(days: 30)).add(Duration(days: index)),
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollToToday();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToToday() {
    const double itemWidth = 82.0;
    const int todayIndex = 30;
    final screenWidth = MediaQuery.of(context).size.width;
    final scrollPosition =
        (todayIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
    _scrollController.jumpTo(scrollPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tanggal',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat.yMMMM('id_ID').format(widget.initialDate),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              final date = _dates[index];
              final isSelected = _isSameDay(widget.initialDate, date);
              return _buildDateItem(date, isSelected);
            },
          ),
        ),
      ],
    );
  }

  bool _isSameDay(DateTime dateA, DateTime dateB) {
    return dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
  }

  Widget _buildDateItem(DateTime date, bool isSelected) {
    final isToday = _isSameDay(date, DateTime.now());

    return GestureDetector(
      onTap: () => widget.onDateChanged(date),
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.E('id_ID').format(date),
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            if (isToday)
              Container(
                height: 14,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Hari Ini',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.primary : Colors.white,
                  ),
                ),
              )
            else
              const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}