import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/saving_entity.dart';
import '../bloc/saving_bloc.dart';

class SavingFormPage extends StatefulWidget {
  final SavingEntity? saving;

  const SavingFormPage({super.key, this.saving});

  @override
  State<SavingFormPage> createState() => _SavingFormPageState();
}

class _SavingFormPageState extends State<SavingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();
  final _currentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.saving != null) {
      _nameController.text = widget.saving!.name;
      _targetController.text = widget.saving!.targetAmount.toString();
      _currentController.text = widget.saving!.currentAmount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.saving != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Saving' : 'Add Saving')),
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
                controller: _targetController,
                decoration: const InputDecoration(labelText: 'Target Amount'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _currentController,
                decoration: const InputDecoration(labelText: 'Current Amount'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final now = DateTime.now();
                    final saving = SavingEntity(
                      id: widget.saving?.id ?? 0,
                      userId: 1, // ganti jika user login diterapkan
                      name: _nameController.text,
                      targetAmount: double.tryParse(_targetController.text) ?? 0,
                      currentAmount: double.tryParse(_currentController.text) ?? 0,
                      status: widget.saving?.status ?? 1,
                      createdAt: widget.saving?.createdAt ?? now,
                      updatedAt: now,
                    );

                    final bloc = context.read<SavingBloc>();
                    if (isEdit) {
                      bloc.add(UpdateSavingEvent(saving));
                    } else {
                      bloc.add(InsertSavingEvent(saving));
                    }
                    context.pop(); // Kembali ke daftar
                  }
                },
                child: Text(isEdit ? 'Update' : 'Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
