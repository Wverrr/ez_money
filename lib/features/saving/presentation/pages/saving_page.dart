import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/saving_bloc.dart';

class SavingPage extends StatelessWidget {
  
  const SavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Savings')),
      body: BlocBuilder<SavingBloc, SavingState>(
        builder: (context, state) {
          if (state is SavingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SavingLoaded) {
            if (state.savings.isEmpty) {
              return const Center(child: Text('No savings found.'));
            }
            return ListView.builder(
              itemCount: state.savings.length,
              itemBuilder: (context, index) {
                final saving = state.savings[index];
                return ListTile(
                  title: Text(saving.name),
                  subtitle: Text(
                    'Target: Rp ${saving.targetAmount}, Current: Rp ${saving.currentAmount}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          
                          context.pushNamed('saving_form_page', extra: saving);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<SavingBloc>().add(DeleteSavingEvent(saving.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is SavingError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('saving_form_page'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
