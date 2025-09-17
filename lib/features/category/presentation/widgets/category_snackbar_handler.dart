import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';

class CategorySnackbarHandler extends StatelessWidget {
  final Widget child;

  const CategorySnackbarHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listenWhen: (previous, current) {
        return current is CategoryActionSuccess ||
            current is CategoryActionError;
      },
      listener: (context, state) {
        String message = '';

        if (state is CategoryActionSuccess) {
          message = state.message;
        } else if (state is CategoryActionError) {
          message = state.message;
        }

        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: child,
    );
  }
}
