// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendDAO.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Friend extends DataClass implements Insertable<Friend> {
  final String? userId;
  final String? nickName;
  final int? gender;
  final String? logo;
  Friend({this.userId, this.nickName, this.gender, this.logo});
  factory Friend.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Friend(
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      nickName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nick_name']),
      gender: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      logo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}logo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    if (!nullToAbsent || nickName != null) {
      map['nick_name'] = Variable<String?>(nickName);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int?>(gender);
    }
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String?>(logo);
    }
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nickName: nickName == null && nullToAbsent
          ? const Value.absent()
          : Value(nickName),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Friend(
      userId: serializer.fromJson<String?>(json['userId']),
      nickName: serializer.fromJson<String?>(json['nickName']),
      gender: serializer.fromJson<int?>(json['gender']),
      logo: serializer.fromJson<String?>(json['logo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String?>(userId),
      'nickName': serializer.toJson<String?>(nickName),
      'gender': serializer.toJson<int?>(gender),
      'logo': serializer.toJson<String?>(logo),
    };
  }

  Friend copyWith(
          {String? userId, String? nickName, int? gender, String? logo}) =>
      Friend(
        userId: userId ?? this.userId,
        nickName: nickName ?? this.nickName,
        gender: gender ?? this.gender,
        logo: logo ?? this.logo,
      );
  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('gender: $gender, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(userId.hashCode,
      $mrjc(nickName.hashCode, $mrjc(gender.hashCode, logo.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.gender == this.gender &&
          other.logo == this.logo);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<String?> userId;
  final Value<String?> nickName;
  final Value<int?> gender;
  final Value<String?> logo;
  const FriendsCompanion({
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.gender = const Value.absent(),
    this.logo = const Value.absent(),
  });
  FriendsCompanion.insert({
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.gender = const Value.absent(),
    this.logo = const Value.absent(),
  });
  static Insertable<Friend> custom({
    Expression<String?>? userId,
    Expression<String?>? nickName,
    Expression<int?>? gender,
    Expression<String?>? logo,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (gender != null) 'gender': gender,
      if (logo != null) 'logo': logo,
    });
  }

  FriendsCompanion copyWith(
      {Value<String?>? userId,
      Value<String?>? nickName,
      Value<int?>? gender,
      Value<String?>? logo}) {
    return FriendsCompanion(
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      gender: gender ?? this.gender,
      logo: logo ?? this.logo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String?>(nickName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int?>(gender.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String?>(logo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('gender: $gender, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }
}

class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FriendsTable(this._db, [this._alias]);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nickNameMeta = const VerificationMeta('nickName');
  late final GeneratedColumn<String?> nickName = GeneratedColumn<String?>(
      'nick_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<int?> gender = GeneratedColumn<int?>(
      'gender', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _logoMeta = const VerificationMeta('logo');
  late final GeneratedColumn<String?> logo = GeneratedColumn<String?>(
      'logo', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [userId, nickName, gender, logo];
  @override
  String get aliasedName => _alias ?? 'friends';
  @override
  String get actualTableName => 'friends';
  @override
  VerificationContext validateIntegrity(Insertable<Friend> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
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

class MessageRecord extends DataClass implements Insertable<MessageRecord> {
  final String? userId;
  final bool self;
  final String? content;
  final DateTime time;
  MessageRecord(
      {this.userId, required this.self, this.content, required this.time});
  factory MessageRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MessageRecord(
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      self: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}self'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    map['self'] = Variable<bool>(self);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  MessageRecordsCompanion toCompanion(bool nullToAbsent) {
    return MessageRecordsCompanion(
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      self: Value(self),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      time: Value(time),
    );
  }

  factory MessageRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MessageRecord(
      userId: serializer.fromJson<String?>(json['userId']),
      self: serializer.fromJson<bool>(json['self']),
      content: serializer.fromJson<String?>(json['content']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String?>(userId),
      'self': serializer.toJson<bool>(self),
      'content': serializer.toJson<String?>(content),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  MessageRecord copyWith(
          {String? userId, bool? self, String? content, DateTime? time}) =>
      MessageRecord(
        userId: userId ?? this.userId,
        self: self ?? this.self,
        content: content ?? this.content,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('MessageRecord(')
          ..write('userId: $userId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(userId.hashCode,
      $mrjc(self.hashCode, $mrjc(content.hashCode, time.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageRecord &&
          other.userId == this.userId &&
          other.self == this.self &&
          other.content == this.content &&
          other.time == this.time);
}

class MessageRecordsCompanion extends UpdateCompanion<MessageRecord> {
  final Value<String?> userId;
  final Value<bool> self;
  final Value<String?> content;
  final Value<DateTime> time;
  const MessageRecordsCompanion({
    this.userId = const Value.absent(),
    this.self = const Value.absent(),
    this.content = const Value.absent(),
    this.time = const Value.absent(),
  });
  MessageRecordsCompanion.insert({
    this.userId = const Value.absent(),
    required bool self,
    this.content = const Value.absent(),
    required DateTime time,
  })  : self = Value(self),
        time = Value(time);
  static Insertable<MessageRecord> custom({
    Expression<String?>? userId,
    Expression<bool>? self,
    Expression<String?>? content,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (self != null) 'self': self,
      if (content != null) 'content': content,
      if (time != null) 'time': time,
    });
  }

  MessageRecordsCompanion copyWith(
      {Value<String?>? userId,
      Value<bool>? self,
      Value<String?>? content,
      Value<DateTime>? time}) {
    return MessageRecordsCompanion(
      userId: userId ?? this.userId,
      self: self ?? this.self,
      content: content ?? this.content,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    if (self.present) {
      map['self'] = Variable<bool>(self.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageRecordsCompanion(')
          ..write('userId: $userId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $MessageRecordsTable extends MessageRecords
    with TableInfo<$MessageRecordsTable, MessageRecord> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MessageRecordsTable(this._db, [this._alias]);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _selfMeta = const VerificationMeta('self');
  late final GeneratedColumn<bool?> self = GeneratedColumn<bool?>(
      'self', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (self IN (0, 1))');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [userId, self, content, time];
  @override
  String get aliasedName => _alias ?? 'message_records';
  @override
  String get actualTableName => 'message_records';
  @override
  VerificationContext validateIntegrity(Insertable<MessageRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
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
  MessageRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MessageRecord.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MessageRecordsTable createAlias(String alias) {
    return $MessageRecordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $MessageRecordsTable messageRecords = $MessageRecordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [friends, messageRecords];
}
