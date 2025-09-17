import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/boarding/presentation/pages/boarding_page.dart';
import '../../features/category/presentation/pages/category_page.dart';
import '../../features/debt/domain/entities/debt_entity.dart';
import '../../features/debt/presentation/pages/debt_page.dart';
import '../../features/debt/presentation/widgets/debt_form_page.dart';
import '../../features/estimation/presentation/pages/estimation_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/saving/domain/entities/saving_entity.dart';
import '../../features/saving/presentation/pages/saving_page.dart';
import '../../features/saving/presentation/widgets/saving_form.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/statistic/presentation/pages/statistic_page.dart';
import '../../features/transaction/presentation/pages/add_transaction_page.dart';
import '../../features/transaction/presentation/pages/transaction_page.dart';
import '../widget/bottom_nav_bar.dart';

class MyRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/boarding',
        name: 'boarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return BottomNavWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
            routes: [
              GoRoute(
                path: 'category_page', 
                name: 'category_page',
                builder: (context, state) => const CategoryPage(),
              ),
              GoRoute(
                path: 'transaction_page',
                name: 'transaction_page',
                builder: (context, state) => const TransactionPage(),
                routes: [
                  GoRoute(
                    path: 'insert_form',
                    name: 'transaction_insert_form',
                    builder: (context, state) => const AddTransactionPage(),
                  ),
                ],
              ),
              GoRoute(
                path: 'debt_page',
                name: 'debt_page',
                builder: (context, state) => const DebtPage(),
                routes: [
                  GoRoute(
                    path: 'form',
                    name: 'debt_form_page',
                    builder: (context, state) =>
                        DebtFormPage(debt: state.extra as DebtEntity?),
                  ),
                ],
              ),
              GoRoute(
                path: 'saving_page',
                name: 'saving_page',
                builder: (context, state) => const SavingPage(),
                routes: [
                  GoRoute(
                    path: 'form',
                    name: 'saving_form_page',
                    builder: (context, state) =>
                        SavingFormPage(saving: state.extra as SavingEntity?),
                  ),
                ],
              ),
              GoRoute(
                path: 'estimation_page',
                name: 'estimation_page',
                builder: (context, state) => const EstimationPage(),
              ),
            ],
          ),

          GoRoute(
            path: '/statistic',
            name: 'statistic',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: StatisticPage()),
          ),

          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfilePage()),
            routes: [
              GoRoute(
                path: 'setting',
                name: 'setting_page',
                builder: (context, state) => const Placeholder(),
              ),
              GoRoute(
                path: 'account',
                name: 'account_page',
                builder: (context, state) => const Placeholder(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
