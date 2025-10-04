import 'package:flutter/material.dart';
import '../widgets/transaction_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../bloc/transaction_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late int _selectedYear;
  late int _selectedMonth;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedYear = now.year;
    _selectedMonth = now.month;
    _fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<TransactionBloc>().add(
      GetAllTransactionsEvent(
        year: _selectedYear,
        month: _selectedMonth,
        searchQuery: _searchController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterControls(),
          const Divider(height: 1, color: Colors.black12),
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TransactionLoaded) {
                  if (state.transactions.isEmpty) {
                    return const Center(
                      child: Text("Tidak ada transaksi ditemukan."),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionListTile(
                        transaction: state.transactions[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                  );
                }
                if (state is TransactionLoadError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('transaction_insert_form');
          context.read<CategoryBloc>().add(const GetCategoriesByTypeEvent(1));
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.surface),
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: AppColors.surface),
              decoration: const InputDecoration(
                hintText: 'Cari...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _fetchData(),
            )
          : const Text("Transaksi", style: TextStyle(color: AppColors.surface)),
      actions: [
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: AppColors.surface,
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                _fetchData();
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildFilterControls() {
    final months = List.generate(
      12,
      (i) => DateFormat('MMM', 'id_ID').format(DateTime(0, i + 1)),
    );
    final years = List.generate(DateTime.now().year - 2019, (i) => 2020 + i);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tahun",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<int>(
                value: _selectedYear,
                items: years
                    .map(
                      (y) =>
                          DropdownMenuItem(value: y, child: Text(y.toString())),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedYear = val);
                    _fetchData();
                  }
                },
                underline: const SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              itemBuilder: (context, index) {
                final month = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(months[index]),
                    selected: month == _selectedMonth,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedMonth = month);
                        _fetchData();
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: month == _selectedMonth
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
