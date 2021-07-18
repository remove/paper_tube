import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'friendDAO.g.dart';

class Friends extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();

  TextColumn get nickName => text()();

  IntColumn get gender => integer()();

  TextColumn get logo => text().nullable()();

  IntColumn get chatId => integer()();
}

class ChatRecords extends Table {
  IntColumn get chatId => integer()();

  BoolColumn get self => boolean()();

  TextColumn get content => text()();

  DateTimeColumn get time => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Friends, ChatRecords])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  Future<int> insertChatContent(ChatRecordsCompanion chatRecord) {
    return into(chatRecords).insert(chatRecord);
  }

  Future<List<ChatRecord>> get searchChatRecords =>
      (select(chatRecords)..where((tbl) => tbl.chatId.equals(10086))).get();

  @override
  int get schemaVersion => 1;
}
