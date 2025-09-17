import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/bloc/category_bloc.dart';
import '../../../debt/domain/entities/debt_entity.dart';
import '../../../debt/presentation/bloc/debt_bloc.dart';
import '../../../saving/domain/entities/saving_entity.dart';
import '../../../saving/presentation/bloc/saving_bloc.dart';
import '../../domain/entities/transaction_entity.dart';
import '../bloc/transaction_bloc.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({super.key});

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _selectedType = 1; // Default: income
  CategoryEntity? _selectedCategory;
  DebtEntity? _selectedDebt;
  SavingEntity? _selectedSaving;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Ambil kategori sesuai tipe
    context.read<CategoryBloc>().add(GetAllCategoriesEvent(false));
    context.read<DebtBloc>().add(GetAllDebtsEvent());
    context.read<SavingBloc>().add(GetAllSavingsEvent());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isExpense = _selectedType == 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nominal
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),

              const SizedBox(height: 16),

              // Deskripsi
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),

              const SizedBox(height: 16),

              // Jenis transaksi
              DropdownButtonFormField<int>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Jenis'),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Pemasukan')),
                  DropdownMenuItem(value: 2, child: Text('Pengeluaran')),
                  DropdownMenuItem(value: 3, child: Text('Tabungan')),
                  DropdownMenuItem(value: 4, child: Text('Utang')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _selectedCategory = null;
                    context.read<CategoryBloc>().add(
                      GetAllCategoriesEvent(_selectedType == 2),
                    );
                  });
                },
              ),

              const SizedBox(height: 16),

              // Pilih kategori
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoaded) {
                    final categories = state.categories;
                    if (categories.isEmpty) {
                      return const Text('Kategori belum tersedia');
                    }
                    return DropdownButtonFormField<CategoryEntity>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Kategori'),
                      items:
                          categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat.name),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() => _selectedCategory = value);
                      },
                      validator: (value) {
                        if (_selectedType == 1 || _selectedType == 2) {
                          return value == null ? 'Pilih kategori' : null;
                        }
                        return null;
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              if (_selectedType == 3)
                BlocBuilder<SavingBloc, SavingState>(
                  builder: (context, state) {
                    if (state is SavingLoaded) {
                      return DropdownButtonFormField<SavingEntity>(
                        value: _selectedSaving,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Tabungan',
                        ),
                        items:
                            state.savings.map((s) {
                              return DropdownMenuItem(
                                value: s,
                                child: Text(s.name),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedSaving = value);
                        },
                        validator:
                            (value) =>
                                value == null ? 'Wajib pilih tabungan' : null,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

              if (_selectedType == 4)
                BlocBuilder<DebtBloc, DebtState>(
                  builder: (context, state) {
                    if (state is DebtLoaded) {
                      return DropdownButtonFormField<DebtEntity>(
                        value: _selectedDebt,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Utang',
                        ),
                        items:
                            state.debts.map((d) {
                              return DropdownMenuItem(
                                value: d,
                                child: Text(d.name),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedDebt = value);
                        },
                        validator:
                            (value) =>
                                value == null ? 'Wajib pilih utang' : null,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

              const SizedBox(height: 16),

              // Tanggal
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Tanggal: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedType == 3 && _selectedSaving == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pilih tabungan')),
                      );
                      return;
                    }
                    if (_selectedType == 4 && _selectedDebt == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pilih utang')),
                      );
                      return;
                    }

                    final tx = TransactionEntity(
                      id: 0,
                      userId: 1,
                      categoryId:
                          _selectedType <= 2 ? _selectedCategory?.id : null,
                      savingsId:
                          _selectedType == 3 ? _selectedSaving?.id : null,
                      debtId: _selectedType == 4 ? _selectedDebt?.id : null,
                      amount: double.parse(_amountController.text),
                      type: _selectedType,
                      description: _descriptionController.text,
                      date: _selectedDate,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    context.read<TransactionBloc>().add(
                      InsertTransactionEvent(tx),
                    );
                    context.read<TransactionBloc>().add(
                      GetAllTransactionsEvent(),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
