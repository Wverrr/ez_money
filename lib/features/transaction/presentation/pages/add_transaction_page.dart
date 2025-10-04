import 'package:flutter/material.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/category_dropdown.dart';
import '../widgets/horizontal_date_picker.dart';
import '../widgets/transaction_type_switch.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int _selectedType = 1;
  DateTime _selectedDate = DateTime.now();
  CategoryEntity? _selectedCategory;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah harus diisi dengan benar.')),
      );
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kategori harus dipilih.')));
      return;
    }

    final newTransaction = TransactionEntity(
      userId: 1,
      amount: amount,
      categoryId: _selectedCategory!.id,
      date: _selectedDate,
      description: _descriptionController.text.trim(),
      type: _selectedType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    context.read<TransactionBloc>().add(InsertTransactionEvent(newTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TransactionActionSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transaksi berhasil disimpan!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        } else if (state is TransactionActionError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TransactionTypeSwitch(
                  onTypeChanged: (type) {
                    setState(() {
                      _selectedType = type;

                      _selectedCategory = null;
                    });

                    context.read<CategoryBloc>().add(
                      GetCategoriesByTypeEvent(type),
                    );
                  },
                ),
                const SizedBox(height: 24),
                HorizontalDatePicker(
                  initialDate: _selectedDate,
                  onDateChanged: (date) => setState(() => _selectedDate = date),
                ),
                const SizedBox(height: 24),
                CategoryDropdown(
                  value: _selectedCategory,
                  onChanged: (category) =>
                      setState(() => _selectedCategory = category),
                ),
                const SizedBox(height: 16),
                _buildAmountField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: _saveTransaction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'SIMPAN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Tambah Transaksi',
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: AppColors.surface),
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: 'Jumlah',

        labelStyle: TextStyle(color: Colors.grey.shade600),

        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),

        prefixText: 'Rp ',
        prefixStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        hintText: '0',
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 3,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: 'Deskripsi',
        labelStyle: TextStyle(color: Colors.grey.shade600),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        hintText: 'Beli kopi susu...',
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
