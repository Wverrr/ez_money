import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/debt_entity.dart';
import '../bloc/debt_bloc.dart';

class DebtFormPage extends StatefulWidget {
  final DebtEntity? debt;

  const DebtFormPage({super.key, this.debt});

  @override
  State<DebtFormPage> createState() => _DebtFormPageState();
}

class _DebtFormPageState extends State<DebtFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _totalController = TextEditingController();
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.debt != null) {
      _nameController.text = widget.debt!.name;
      _totalController.text = widget.debt!.totalAmount.toString();
      _dueDate = widget.debt!.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.debt != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Debt' : 'Add Debt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _totalController,
                decoration: const InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(_dueDate != null
                      ? 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}'
                      : 'Select Due Date'),
                  const Spacer(),
                  TextButton(
                    child: const Text('Pick Date'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _dueDate = picked;
                        });
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Update' : 'Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _dueDate != null) {
                    final debt = DebtEntity(
                      id: widget.debt?.id ?? 0,
                      userId: 1, // Gantilah dengan userId yang valid
                      name: _nameController.text,
                      totalAmount: double.parse(_totalController.text),
                      paidAmount: widget.debt?.paidAmount ?? 0,
                      dueDate: _dueDate!,
                      status: widget.debt?.status ?? 1,
                      createdAt: widget.debt?.createdAt ?? DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    final bloc = context.read<DebtBloc>();
                    if (isEdit) {
                      bloc.add(UpdateDebtEvent(debt));
                    } else {
                      bloc.add(InsertDebtEvent(debt));
                    }
                    context.pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
