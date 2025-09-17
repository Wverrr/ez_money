
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/database/database.dart';
import 'features/boarding/presentation/bloc/boarding_bloc.dart';
import 'features/category/data/datasources/local/category_local_datasource.dart';
import 'features/category/data/repositories/category_repository_impl.dart';
import 'features/category/domain/repositories/category_repository.dart';
import 'features/category/domain/usecases/delete_category.dart';
import 'features/category/domain/usecases/get_all_categories.dart';
import 'features/category/domain/usecases/get_category.dart';
import 'features/category/domain/usecases/get_category_by_type.dart';
import 'features/category/domain/usecases/insert_category.dart';
import 'features/category/domain/usecases/insert_default_category.dart';
import 'features/category/domain/usecases/update_category.dart';
import 'features/category/presentation/bloc/category_bloc.dart';
import 'features/debt/data/datasources/local/debt_local_datasource.dart';
import 'features/debt/data/repositories/debt_repository_impl.dart';
import 'features/debt/domain/repositories/debt_repository.dart';
import 'features/debt/domain/usecases/delete_debt.dart';
import 'features/debt/domain/usecases/get_all_debts.dart';
import 'features/debt/domain/usecases/get_debt.dart';
import 'features/debt/domain/usecases/insert_debt.dart';
import 'features/debt/domain/usecases/update_debt.dart';
import 'features/debt/presentation/bloc/debt_bloc.dart';
import 'features/estimation/data/datasources/remote/estimation_remote_datasource.dart';
import 'features/estimation/data/repositories/estimation_repository_impl.dart';
import 'features/estimation/domain/repositories/estimation_repository.dart';
import 'features/estimation/domain/usecases/estimate_expense.dart';
import 'features/estimation/domain/usecases/train_model.dart';
import 'features/estimation/presentation/bloc/estimation_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/saving/data/datasources/local/saving_local_datasource.dart';
import 'features/saving/data/repositories/saving_repository_impl.dart';
import 'features/saving/domain/repositories/saving_repository.dart';
import 'features/saving/domain/usecases/delete_saving.dart';
import 'features/saving/domain/usecases/get_all_savings.dart';
import 'features/saving/domain/usecases/get_saving.dart';
import 'features/saving/domain/usecases/insert_saving.dart';
import 'features/saving/domain/usecases/update_saving.dart';
import 'features/saving/presentation/bloc/saving_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/transaction/data/datasources/local/transaction_local_datasource.dart';
import 'features/transaction/data/repositories/transaction_repository_impl.dart';
import 'features/transaction/domain/repositories/transaction_repository.dart';
import 'features/transaction/domain/usecases/delete_transaction.dart';
import 'features/transaction/domain/usecases/get_all_transactions.dart';
import 'features/transaction/domain/usecases/get_transaction.dart';
import 'features/transaction/domain/usecases/insert_transaction.dart';
import 'features/transaction/domain/usecases/update_transaction.dart';
import 'features/transaction/presentation/bloc/transaction_bloc.dart';
import 'features/user/data/datasources/local/user_local_datasource.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_active_user.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/domain/usecases/insert_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  //Database
  final db = AppDb();
  getIt.registerSingleton<AppDb>(db);

  // FEATURE - SPLASH
  // Bloc
  getIt.registerFactory(
    () => SplashBloc(
      getIt<SharedPreferences>(),
      getIt<InsertDefaultCategory>(),
    ),
  );

  // Usecases
  getIt.registerLazySingleton(
    () => InsertDefaultCategory(getIt<CategoryRepository>()),
  );

  // FEATURE - HOME
  // Bloc
  getIt.registerFactory(
    () => HomeBloc(
      getIt<GetUser>(),
      getIt<GetLastActiveUser>(),
    ),
  );


// FEATURE - USER
  // Datasource
  getIt.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasourceImpl(getIt<AppDb>(), getIt<SharedPreferences>()),
  );

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserLocalDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton(
    () => GetUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => InsertUser(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetLastActiveUser(getIt<UserRepository>()),
  );

  // Bloc
  getIt.registerFactory(
    () => UserBloc(
      getIt<GetUser>(),
      getIt<InsertUser>(),
    ),
  );

  // FEATURE - CATEGORY
  // Datasource
  getIt.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(getIt<AppDb>()),
  );

  // Repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryLocalDataSource>()),
  );

  // Usecases
  getIt.registerLazySingleton(
    () => GetAllCategories(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(() => GetCategory(getIt<CategoryRepository>()));
  getIt.registerLazySingleton(
    () => InsertCategory(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateCategory(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCategory(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetCategoriesByType(getIt<CategoryRepository>()),
  );

  // Bloc
  getIt.registerFactory(
    () => CategoryBloc(
      getIt<GetAllCategories>(),
      getIt<GetCategory>(),
      getIt<InsertCategory>(),
      getIt<UpdateCategory>(),
      getIt<DeleteCategory>(),
      getIt<GetCategoriesByType>(),
    ),
  );

  // FEATURE - TRANSACTION
  // Datasource
  getIt.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(getIt<AppDb>()),
  );

  // Repository
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionLocalDataSource>()),
  );

  // Usecases
  getIt.registerLazySingleton(
    () => GetAllTransactions(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton(
    () => InsertTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteTransaction(getIt<TransactionRepository>()),
  );

  // Bloc
  getIt.registerFactory(
    () => TransactionBloc(
      getIt<GetAllTransactions>(),
      getIt<GetTransaction>(),
      getIt<InsertTransaction>(),
      getIt<UpdateTransaction>(),
      getIt<DeleteTransaction>(),
    ),
  );

  // FEATURE - DEBT
  // Datasource
  getIt.registerLazySingleton<DebtLocalDataSource>(
    () => DebtLocalDataSourceImpl(getIt<AppDb>()),
  );

  // Repository
  getIt.registerLazySingleton<DebtRepository>(
    () => DebtRepositoryImpl(getIt<DebtLocalDataSource>()),
  );

  // Usecases
  getIt.registerLazySingleton(() => GetAllDebts(getIt<DebtRepository>()));
  getIt.registerLazySingleton(() => GetDebt(getIt<DebtRepository>()));
  getIt.registerLazySingleton(() => InsertDebt(getIt<DebtRepository>()));
  getIt.registerLazySingleton(() => UpdateDebt(getIt<DebtRepository>()));
  getIt.registerLazySingleton(() => DeleteDebt(getIt<DebtRepository>()));

  // Bloc
  getIt.registerFactory(
    () => DebtBloc(
      getIt<GetAllDebts>(),
      getIt<GetDebt>(),
      getIt<InsertDebt>(),
      getIt<UpdateDebt>(),
      getIt<DeleteDebt>(),
    ),
  );

  // FEATURE - SAVING
  // Datasource
  getIt.registerLazySingleton<SavingLocalDatasource>(
    () => SavingLocalDatasourceImpl(getIt<AppDb>()),
  );

  // Repository
  getIt.registerLazySingleton<SavingRepository>(
    () => SavingRepositoryImpl(getIt<SavingLocalDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton(() => GetAllSavings(getIt<SavingRepository>()));
  getIt.registerLazySingleton(() => GetSaving(getIt<SavingRepository>()));
  getIt.registerLazySingleton(() => InsertSaving(getIt<SavingRepository>()));
  getIt.registerLazySingleton(() => UpdateSaving(getIt<SavingRepository>()));
  getIt.registerLazySingleton(() => DeleteSaving(getIt<SavingRepository>()));

  // Bloc
  getIt.registerFactory(
    () => SavingBloc(
      getIt<GetAllSavings>(),
      getIt<GetSaving>(),
      getIt<InsertSaving>(),
      getIt<UpdateSaving>(),
      getIt<DeleteSaving>(),
    ),
  );

  // FEATURE - ESTIMATION
  // HTTP Client
  final client = http.Client();
  getIt.registerSingleton<http.Client>(client);

  // Datasource
  getIt.registerLazySingleton<EstimationRemoteDataSource>(
    () => EstimationRemoteDataSourceImpl(
      getIt<http.Client>(),
      baseUrl: "http://10.0.2.2:8000", // Untuk Android Emulator
    ),
  );

  // Repository
  getIt.registerLazySingleton<EstimationRepository>(
    () => EstimationRepositoryImpl(getIt<EstimationRemoteDataSource>()),
  );

  // Usecases
  getIt.registerLazySingleton(() => TrainRecord(getIt<EstimationRepository>()));
  getIt.registerLazySingleton(() => EstimateExpense(getIt<EstimationRepository>()));

  // Bloc
  getIt.registerFactory(
    () => EstimationBloc(
      trains: getIt<TrainRecord>(),
      estimate: getIt<EstimateExpense>(),
    ),
  );

  // FEATURE - ONBOARDING
  // Bloc
  getIt.registerFactory(
    () => BoardingBloc(
      getIt<InsertUser>(),
    ),
  );

}
