import 'package:paper_tube/models/dao/friendDAO.dart';

///Get the database of the singleton schema
class GetDatabase {
  static final GetDatabase _myTestDatabase = GetDatabase._internal();

  final _myDatabase = MyDatabase();

  MyDatabase get myDatabase => _myDatabase;

  factory GetDatabase() {
    return _myTestDatabase;
  }

  GetDatabase._internal();
}
