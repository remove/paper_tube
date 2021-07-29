import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'friend_dao.g.dart';

class Friends extends Table {
  TextColumn get userId => text().nullable()();

  TextColumn get nickName => text().nullable()();

  IntColumn get gender => integer().nullable()();

  TextColumn get logo => text().nullable()();
}

class MessageRecords extends Table {
  TextColumn get userId => text().nullable()();

  BoolColumn get self => boolean()();

  TextColumn get content => text().nullable()();

  DateTimeColumn get time => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Friends, MessageRecords])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  void delDatabase() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    file.delete();
  }

  Future<int> insertChatContent(MessageRecord msgRC) {
    return into(messageRecords).insert(msgRC);
  }

  Future<int> insertFriends(FriendsCompanion friendsCompanion) {
    return into(friends).insert(friendsCompanion);
  }

  Future<List<Friend>> getFriendInfo(String userId) {
    return (select(friends)..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Future<List<MessageRecord>> getChatContent(String userId) {
    return (select(messageRecords)
          ..where(
            (tbl) => tbl.userId.equals(userId),
          ))
        .get();
  }

  @override
  int get schemaVersion => 1;
}
