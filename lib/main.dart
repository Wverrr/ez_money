import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/constants/app_colors.dart';
import 'core/routes/router.dart';
import 'features/boarding/presentation/bloc/boarding_bloc.dart';
import 'features/category/presentation/bloc/category_bloc.dart';
import 'features/debt/presentation/bloc/debt_bloc.dart';
import 'features/estimation/presentation/bloc/estimation_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/saving/presentation/bloc/saving_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/transaction/presentation/bloc/transaction_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'injection.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDateFormatting('id_ID', null);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<CategoryBloc>()),
        BlocProvider(create: (context) => getIt<TransactionBloc>()),
        BlocProvider(create: (context) => getIt<DebtBloc>()),
        BlocProvider(create: (context) => getIt<SavingBloc>()),
        BlocProvider(create: (context) => getIt<EstimationBloc>()),
        BlocProvider(create: (context) => getIt<SplashBloc>()),
        BlocProvider(create: (context) => getIt<BoardingBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: MyRouter().router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          useMaterial3: true,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        title: 'EZ Money',
      ),
    );
  }
}
