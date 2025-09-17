import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/debt_bloc.dart';

class DebtPage extends StatelessWidget {
  const DebtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debts')),
      body: BlocBuilder<DebtBloc, DebtState>(
        builder: (context, state) {
          if (state is DebtLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DebtLoaded) {
            if (state.debts.isEmpty) {
              return const Center(child: Text('No debts found.'));
            }
            return ListView.builder(
              itemCount: state.debts.length,
              itemBuilder: (context, index) {
                final debt = state.debts[index];
                return ListTile(
                  title: Text(debt.name),
                  subtitle: Text('Total: Rp ${debt.totalAmount}, Paid: Rp ${debt.paidAmount}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.pushNamed('debt_form_page', extra: debt);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<DebtBloc>().add(DeleteDebtEvent(debt.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is DebtError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('debt_form_page'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
