import '../../../../../core/database/database.dart';
import '../../models/saving_model.dart';

abstract class SavingLocalDatasource {
  Future<List<SavingModel>> getAllSavings();
  Future<SavingModel> getSaving(int id);
  Future<void> insertSaving(SavingModel saving);
  Future<void> updateSaving(SavingModel saving);
  Future<void> deleteSaving(int id);
}

class SavingLocalDatasourceImpl implements SavingLocalDatasource {
  final AppDb database;

  SavingLocalDatasourceImpl(this.database);
  
  @override
  Future<List<SavingModel>> getAllSavings() async {
    final savings = await database.select(database.savings).get();
    return savings.map((saving) => SavingModel.fromDb(saving)).toList();
  }
  
  @override
  Future<SavingModel> getSaving(int id) async {
    final saving = await (database.select(database.savings)
      ..where((tbl) => tbl.id.equals(id))).getSingle();
    return SavingModel.fromDb(saving);
  }
  
  @override
  Future<void> insertSaving(SavingModel saving) async{
    await database.into(database.savings).insert(saving.toCompanion(isInsert: true));
  }
  
  @override
  Future<void> updateSaving(SavingModel saving) async{
   await (database.update(database.savings)
         ..where((tbl) => tbl.id.equals(saving.id)))
       .write(saving.toCompanion());
  }
  
  @override
  Future<void> deleteSaving(int id) async{
    await (database.delete(database.savings)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  

}