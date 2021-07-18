// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendDAO.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Friend extends DataClass implements Insertable<Friend> {
  final int id;
  final int userId;
  final String nickName;
  final int gender;
  final String? logo;
  final int chatId;
  Friend(
      {required this.id,
      required this.userId,
      required this.nickName,
      required this.gender,
      this.logo,
      required this.chatId});
  factory Friend.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Friend(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      nickName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nick_name'])!,
      gender: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender'])!,
      logo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}logo']),
      chatId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}chat_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['nick_name'] = Variable<String>(nickName);
    map['gender'] = Variable<int>(gender);
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String?>(logo);
    }
    map['chat_id'] = Variable<int>(chatId);
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      id: Value(id),
      userId: Value(userId),
      nickName: Value(nickName),
      gender: Value(gender),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
      chatId: Value(chatId),
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Friend(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      nickName: serializer.fromJson<String>(json['nickName']),
      gender: serializer.fromJson<int>(json['gender']),
      logo: serializer.fromJson<String?>(json['logo']),
      chatId: serializer.fromJson<int>(json['chatId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'nickName': serializer.toJson<String>(nickName),
      'gender': serializer.toJson<int>(gender),
      'logo': serializer.toJson<String?>(logo),
      'chatId': serializer.toJson<int>(chatId),
    };
  }

  Friend copyWith(
          {int? id,
          int? userId,
          String? nickName,
          int? gender,
          String? logo,
          int? chatId}) =>
      Friend(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        nickName: nickName ?? this.nickName,
        gender: gender ?? this.gender,
        logo: logo ?? this.logo,
        chatId: chatId ?? this.chatId,
      );
  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('gender: $gender, ')
          ..write('logo: $logo, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(nickName.hashCode,
              $mrjc(gender.hashCode, $mrjc(logo.hashCode, chatId.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.gender == this.gender &&
          other.logo == this.logo &&
          other.chatId == this.chatId);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> nickName;
  final Value<int> gender;
  final Value<String?> logo;
  final Value<int> chatId;
  const FriendsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.gender = const Value.absent(),
    this.logo = const Value.absent(),
    this.chatId = const Value.absent(),
  });
  FriendsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String nickName,
    required int gender,
    this.logo = const Value.absent(),
    required int chatId,
  })  : userId = Value(userId),
        nickName = Value(nickName),
        gender = Value(gender),
        chatId = Value(chatId);
  static Insertable<Friend> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? nickName,
    Expression<int>? gender,
    Expression<String?>? logo,
    Expression<int>? chatId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (gender != null) 'gender': gender,
      if (logo != null) 'logo': logo,
      if (chatId != null) 'chat_id': chatId,
    });
  }

  FriendsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? nickName,
      Value<int>? gender,
      Value<String?>? logo,
      Value<int>? chatId}) {
    return FriendsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      gender: gender ?? this.gender,
      logo: logo ?? this.logo,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String?>(logo.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('gender: $gender, ')
          ..write('logo: $logo, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }
}

class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FriendsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _nickNameMeta = const VerificationMeta('nickName');
  late final GeneratedColumn<String?> nickName = GeneratedColumn<String?>(
      'nick_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<int?> gender = GeneratedColumn<int?>(
      'gender', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _logoMeta = const VerificationMeta('logo');
  late final GeneratedColumn<String?> logo = GeneratedColumn<String?>(
      'logo', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  late final GeneratedColumn<int?> chatId = GeneratedColumn<int?>(
      'chat_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, nickName, gender, logo, chatId];
  @override
  String get aliasedName => _alias ?? 'friends';
  @override
  String get actualTableName => 'friends';
  @override
  VerificationContext validateIntegrity(Insertable<Friend> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    } else if (isInserting) {
      context.missing(_nickNameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Friend.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(_db, alias);
  }
}

class ChatRecord extends DataClass implements Insertable<ChatRecord> {
  final int chatId;
  final bool self;
  final String content;
  final DateTime time;
  ChatRecord(
      {required this.chatId,
      required this.self,
      required this.content,
      required this.time});
  factory ChatRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ChatRecord(
      chatId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}chat_id'])!,
      self: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}self'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['self'] = Variable<bool>(self);
    map['content'] = Variable<String>(content);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  ChatRecordsCompanion toCompanion(bool nullToAbsent) {
    return ChatRecordsCompanion(
      chatId: Value(chatId),
      self: Value(self),
      content: Value(content),
      time: Value(time),
    );
  }

  factory ChatRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ChatRecord(
      chatId: serializer.fromJson<int>(json['chatId']),
      self: serializer.fromJson<bool>(json['self']),
      content: serializer.fromJson<String>(json['content']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'self': serializer.toJson<bool>(self),
      'content': serializer.toJson<String>(content),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  ChatRecord copyWith(
          {int? chatId, bool? self, String? content, DateTime? time}) =>
      ChatRecord(
        chatId: chatId ?? this.chatId,
        self: self ?? this.self,
        content: content ?? this.content,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('ChatRecord(')
          ..write('chatId: $chatId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(chatId.hashCode,
      $mrjc(self.hashCode, $mrjc(content.hashCode, time.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRecord &&
          other.chatId == this.chatId &&
          other.self == this.self &&
          other.content == this.content &&
          other.time == this.time);
}

class ChatRecordsCompanion extends UpdateCompanion<ChatRecord> {
  final Value<int> chatId;
  final Value<bool> self;
  final Value<String> content;
  final Value<DateTime> time;
  const ChatRecordsCompanion({
    this.chatId = const Value.absent(),
    this.self = const Value.absent(),
    this.content = const Value.absent(),
    this.time = const Value.absent(),
  });
  ChatRecordsCompanion.insert({
    required int chatId,
    required bool self,
    required String content,
    required DateTime time,
  })  : chatId = Value(chatId),
        self = Value(self),
        content = Value(content),
        time = Value(time);
  static Insertable<ChatRecord> custom({
    Expression<int>? chatId,
    Expression<bool>? self,
    Expression<String>? content,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (self != null) 'self': self,
      if (content != null) 'content': content,
      if (time != null) 'time': time,
    });
  }

  ChatRecordsCompanion copyWith(
      {Value<int>? chatId,
      Value<bool>? self,
      Value<String>? content,
      Value<DateTime>? time}) {
    return ChatRecordsCompanion(
      chatId: chatId ?? this.chatId,
      self: self ?? this.self,
      content: content ?? this.content,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (self.present) {
      map['self'] = Variable<bool>(self.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatRecordsCompanion(')
          ..write('chatId: $chatId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $ChatRecordsTable extends ChatRecords
    with TableInfo<$ChatRecordsTable, ChatRecord> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ChatRecordsTable(this._db, [this._alias]);
  final VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  late final GeneratedColumn<int?> chatId = GeneratedColumn<int?>(
      'chat_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _selfMeta = const VerificationMeta('self');
  late final GeneratedColumn<bool?> self = GeneratedColumn<bool?>(
      'self', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (self IN (0, 1))');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [chatId, self, content, time];
  @override
  String get aliasedName => _alias ?? 'chat_records';
  @override
  String get actualTableName => 'chat_records';
  @override
  VerificationContext validateIntegrity(Insertable<ChatRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('self')) {
      context.handle(
          _selfMeta, self.isAcceptableOrUnknown(data['self']!, _selfMeta));
    } else if (isInserting) {
      context.missing(_selfMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ChatRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ChatRecord.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChatRecordsTable createAlias(String alias) {
    return $ChatRecordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $ChatRecordsTable chatRecords = $ChatRecordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [friends, chatRecords];
}
