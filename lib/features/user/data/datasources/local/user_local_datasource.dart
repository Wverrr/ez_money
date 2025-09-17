import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/database/database.dart';
import '../../models/user_model.dart';

abstract class UserLocalDatasource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUser(int id);
  Future<int> insertUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(int id);

  Future<void> saveLastActiveUser(int userId);
  Future<int?> getLastActiveUser();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final AppDb database;
  final SharedPreferences sharedPreferences;

  UserLocalDatasourceImpl(this.database, this.sharedPreferences);

  @override
  Future<List<UserModel>> getAllUsers() async {
    final users = await database.select(database.users).get();
    return users.map((user) => UserModel.fromDb(user)).toList();
  }

  @override
  Future<UserModel> getUser(int id) async {
    final user = await (database.select(database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    return UserModel.fromDb(user);
  }

  @override
  Future<int> insertUser(UserModel user) async {
    final id = await database.into(database.users).insert(user.toCompanion(isInsert: true));
    return id;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await (database.update(database.users)
          ..where((tbl) => tbl.id.equals(user.id!)))
        .write(user.toCompanion());
  }

  @override
  Future<void> deleteUser(int id) async {
    await (database.delete(database.users)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
  
  @override
  Future<void> saveLastActiveUser(int userId) async {
    await sharedPreferences.setInt('last_active_user', userId);
  }


  @override
  Future<int?> getLastActiveUser() async {
    return sharedPreferences.getInt('last_active_user');
  }
}