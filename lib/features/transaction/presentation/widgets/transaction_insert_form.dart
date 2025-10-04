import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/category_dropdown.dart';
import '../widgets/horizontal_date_picker.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({super.key});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _selectedType = 1;
  CategoryEntity? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(const GetCategoriesByTypeEvent(1));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text);
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kategori wajib dipilih.')),
        );
        return;
      }

      final tx = TransactionEntity(
        userId: 1,
        amount: amount!,
        categoryId: _selectedCategory!.id!,
        type: _selectedType,
        date: _selectedDate,
        description: _descriptionController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      context.read<TransactionBloc>().add(InsertTransactionEvent(tx));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TransactionActionSuccess) {
          context.pop();
          context.pop();
        } else if (state is TransactionActionError) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Tambah Transaksi')),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<int>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Transaksi',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Pemasukan')),
                    DropdownMenuItem(value: 2, child: Text('Pengeluaran')),
                    DropdownMenuItem(value: 3, child: Text('Tabungan')),
                    DropdownMenuItem(value: 4, child: Text('Utang')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedType = value;
                      _selectedCategory = null;
                    });
                    context.read<CategoryBloc>().add(GetCategoriesByTypeEvent(value));
                  },
                ),
                const SizedBox(height: 24),
                HorizontalDatePicker(
                  initialDate: _selectedDate,
                  onDateChanged: (newDate) => setState(() => _selectedDate = newDate),
                ),
                const SizedBox(height: 24),
                CategoryDropdown(
                  value: _selectedCategory,
                  onChanged: (newCategory) => setState(() => _selectedCategory = newCategory),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah',
                    prefixText: 'Rp ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah wajib diisi.';
                    }
                    if (double.tryParse(value) == null || double.parse(value) <= 0) {
                      return 'Masukkan jumlah yang valid.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi (Opsional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _saveTransaction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text('SIMPAN TRANSAKSI'),
          ),
        ),
      ),
    );
  }
}