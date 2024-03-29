// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_dao.dart';

// ignore_for_file: type=lint
class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nickNameMeta =
      const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
      'nick_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _friendRemarkMeta =
      const VerificationMeta('friendRemark');
  @override
  late final GeneratedColumn<String> friendRemark = GeneratedColumn<String>(
      'friend_remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [userId, nickName, avatarUrl, friendRemark];
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
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('friend_remark')) {
      context.handle(
          _friendRemarkMeta,
          friendRemark.isAcceptableOrUnknown(
              data['friend_remark']!, _friendRemarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Friend(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nickName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nick_name']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      friendRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_remark']),
    );
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(attachedDatabase, alias);
  }
}

class Friend extends DataClass implements Insertable<Friend> {
  final String? userId;
  final String? nickName;
  final String? avatarUrl;
  final String? friendRemark;
  const Friend({this.userId, this.nickName, this.avatarUrl, this.friendRemark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || nickName != null) {
      map['nick_name'] = Variable<String>(nickName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || friendRemark != null) {
      map['friend_remark'] = Variable<String>(friendRemark);
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
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      friendRemark: friendRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(friendRemark),
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Friend(
      userId: serializer.fromJson<String?>(json['userId']),
      nickName: serializer.fromJson<String?>(json['nickName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      friendRemark: serializer.fromJson<String?>(json['friendRemark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String?>(userId),
      'nickName': serializer.toJson<String?>(nickName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'friendRemark': serializer.toJson<String?>(friendRemark),
    };
  }

  Friend copyWith(
          {Value<String?> userId = const Value.absent(),
          Value<String?> nickName = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent(),
          Value<String?> friendRemark = const Value.absent()}) =>
      Friend(
        userId: userId.present ? userId.value : this.userId,
        nickName: nickName.present ? nickName.value : this.nickName,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        friendRemark:
            friendRemark.present ? friendRemark.value : this.friendRemark,
      );
  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('friendRemark: $friendRemark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, nickName, avatarUrl, friendRemark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.avatarUrl == this.avatarUrl &&
          other.friendRemark == this.friendRemark);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<String?> userId;
  final Value<String?> nickName;
  final Value<String?> avatarUrl;
  final Value<String?> friendRemark;
  final Value<int> rowid;
  const FriendsCompanion({
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.friendRemark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendsCompanion.insert({
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.friendRemark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<Friend> custom({
    Expression<String>? userId,
    Expression<String>? nickName,
    Expression<String>? avatarUrl,
    Expression<String>? friendRemark,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (friendRemark != null) 'friend_remark': friendRemark,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendsCompanion copyWith(
      {Value<String?>? userId,
      Value<String?>? nickName,
      Value<String?>? avatarUrl,
      Value<String?>? friendRemark,
      Value<int>? rowid}) {
    return FriendsCompanion(
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      friendRemark: friendRemark ?? this.friendRemark,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (friendRemark.present) {
      map['friend_remark'] = Variable<String>(friendRemark.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('friendRemark: $friendRemark, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageRecordsTable extends MessageRecords
    with TableInfo<$MessageRecordsTable, MessageRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _selfMeta = const VerificationMeta('self');
  @override
  late final GeneratedColumn<bool> self =
      GeneratedColumn<bool>('self', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("self" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [index, type, userId, self, content, time];
  @override
  String get aliasedName => _alias ?? 'message_records';
  @override
  String get actualTableName => 'message_records';
  @override
  VerificationContext validateIntegrity(Insertable<MessageRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  MessageRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageRecord(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      self: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}self'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $MessageRecordsTable createAlias(String alias) {
    return $MessageRecordsTable(attachedDatabase, alias);
  }
}

class MessageRecord extends DataClass implements Insertable<MessageRecord> {
  final int? index;
  final int type;
  final String userId;
  final bool self;
  final String content;
  final DateTime time;
  const MessageRecord(
      {this.index,
      required this.type,
      required this.userId,
      required this.self,
      required this.content,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    map['type'] = Variable<int>(type);
    map['user_id'] = Variable<String>(userId);
    map['self'] = Variable<bool>(self);
    map['content'] = Variable<String>(content);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  MessageRecordsCompanion toCompanion(bool nullToAbsent) {
    return MessageRecordsCompanion(
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
      type: Value(type),
      userId: Value(userId),
      self: Value(self),
      content: Value(content),
      time: Value(time),
    );
  }

  factory MessageRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageRecord(
      index: serializer.fromJson<int?>(json['index']),
      type: serializer.fromJson<int>(json['type']),
      userId: serializer.fromJson<String>(json['userId']),
      self: serializer.fromJson<bool>(json['self']),
      content: serializer.fromJson<String>(json['content']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int?>(index),
      'type': serializer.toJson<int>(type),
      'userId': serializer.toJson<String>(userId),
      'self': serializer.toJson<bool>(self),
      'content': serializer.toJson<String>(content),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  MessageRecord copyWith(
          {Value<int?> index = const Value.absent(),
          int? type,
          String? userId,
          bool? self,
          String? content,
          DateTime? time}) =>
      MessageRecord(
        index: index.present ? index.value : this.index,
        type: type ?? this.type,
        userId: userId ?? this.userId,
        self: self ?? this.self,
        content: content ?? this.content,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('MessageRecord(')
          ..write('index: $index, ')
          ..write('type: $type, ')
          ..write('userId: $userId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, type, userId, self, content, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageRecord &&
          other.index == this.index &&
          other.type == this.type &&
          other.userId == this.userId &&
          other.self == this.self &&
          other.content == this.content &&
          other.time == this.time);
}

class MessageRecordsCompanion extends UpdateCompanion<MessageRecord> {
  final Value<int?> index;
  final Value<int> type;
  final Value<String> userId;
  final Value<bool> self;
  final Value<String> content;
  final Value<DateTime> time;
  const MessageRecordsCompanion({
    this.index = const Value.absent(),
    this.type = const Value.absent(),
    this.userId = const Value.absent(),
    this.self = const Value.absent(),
    this.content = const Value.absent(),
    this.time = const Value.absent(),
  });
  MessageRecordsCompanion.insert({
    this.index = const Value.absent(),
    required int type,
    required String userId,
    required bool self,
    required String content,
    required DateTime time,
  })  : type = Value(type),
        userId = Value(userId),
        self = Value(self),
        content = Value(content),
        time = Value(time);
  static Insertable<MessageRecord> custom({
    Expression<int>? index,
    Expression<int>? type,
    Expression<String>? userId,
    Expression<bool>? self,
    Expression<String>? content,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (type != null) 'type': type,
      if (userId != null) 'user_id': userId,
      if (self != null) 'self': self,
      if (content != null) 'content': content,
      if (time != null) 'time': time,
    });
  }

  MessageRecordsCompanion copyWith(
      {Value<int?>? index,
      Value<int>? type,
      Value<String>? userId,
      Value<bool>? self,
      Value<String>? content,
      Value<DateTime>? time}) {
    return MessageRecordsCompanion(
      index: index ?? this.index,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      self: self ?? this.self,
      content: content ?? this.content,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
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
    return (StringBuffer('MessageRecordsCompanion(')
          ..write('index: $index, ')
          ..write('type: $type, ')
          ..write('userId: $userId, ')
          ..write('self: $self, ')
          ..write('content: $content, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $MessageResourcesTable extends MessageResources
    with TableInfo<$MessageResourcesTable, MessageResource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageResourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [index, source];
  @override
  String get aliasedName => _alias ?? 'message_resources';
  @override
  String get actualTableName => 'message_resources';
  @override
  VerificationContext validateIntegrity(Insertable<MessageResource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MessageResource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageResource(
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
    );
  }

  @override
  $MessageResourcesTable createAlias(String alias) {
    return $MessageResourcesTable(attachedDatabase, alias);
  }
}

class MessageResource extends DataClass implements Insertable<MessageResource> {
  final int index;
  final String source;
  const MessageResource({required this.index, required this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['index'] = Variable<int>(index);
    map['source'] = Variable<String>(source);
    return map;
  }

  MessageResourcesCompanion toCompanion(bool nullToAbsent) {
    return MessageResourcesCompanion(
      index: Value(index),
      source: Value(source),
    );
  }

  factory MessageResource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageResource(
      index: serializer.fromJson<int>(json['index']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int>(index),
      'source': serializer.toJson<String>(source),
    };
  }

  MessageResource copyWith({int? index, String? source}) => MessageResource(
        index: index ?? this.index,
        source: source ?? this.source,
      );
  @override
  String toString() {
    return (StringBuffer('MessageResource(')
          ..write('index: $index, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageResource &&
          other.index == this.index &&
          other.source == this.source);
}

class MessageResourcesCompanion extends UpdateCompanion<MessageResource> {
  final Value<int> index;
  final Value<String> source;
  final Value<int> rowid;
  const MessageResourcesCompanion({
    this.index = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageResourcesCompanion.insert({
    required int index,
    required String source,
    this.rowid = const Value.absent(),
  })  : index = Value(index),
        source = Value(source);
  static Insertable<MessageResource> custom({
    Expression<int>? index,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageResourcesCompanion copyWith(
      {Value<int>? index, Value<String>? source, Value<int>? rowid}) {
    return MessageResourcesCompanion(
      index: index ?? this.index,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageResourcesCompanion(')
          ..write('index: $index, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $MessageRecordsTable messageRecords = $MessageRecordsTable(this);
  late final $MessageResourcesTable messageResources =
      $MessageResourcesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [friends, messageRecords, messageResources];
}
