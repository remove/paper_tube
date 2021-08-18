import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'friend_dao.g.dart';

class Friends extends Table {
  TextColumn get userId => text().nullable()();

  TextColumn get nickName => text().nullable()();

  TextColumn get avatarUrl => text().nullable()();

  TextColumn get friendRemark => text().nullable()();
}

class MessageRecords extends Table {
  IntColumn get index => integer().autoIncrement().nullable()();

  IntColumn get type => integer()();

  TextColumn get userId => text()();

  BoolColumn get self => boolean()();

  TextColumn get content => text()();

  DateTimeColumn get time => dateTime()();
}

class MessageResources extends Table {
  IntColumn get index => integer()();

  TextColumn get source => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Friends, MessageRecords, MessageResources])
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

  Future<int> insertMessageResource(MessageResource msgRsc) {
    return into(messageResources).insert(msgRsc);
  }

  Future<List<MessageResource>> getMessageResource(int index) {
    var one = select(messageResources);
    var two = one..where((tbl) => tbl.index.equals(index));
    return two.get();
  }

  Future<List<Friend>> getFriendInfo(String userId) {
    return (select(friends)..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Future<List<MessageRecord>> getHistoryRecords(
      String userId, int limit, int offset) {
    return (select(messageRecords)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.index)])
          ..limit(limit, offset: offset))
        .get();
  }

  @override
  int get schemaVersion => 1;
}
