// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CharacterData extends DataClass implements Insertable<CharacterData> {
  final String id;
  final String name;
  final String description;
  final String thumbnailUrl;
  CharacterData(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnailUrl});
  factory CharacterData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CharacterData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      thumbnailUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_url'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    return map;
  }

  CharacterCompanion toCompanion(bool nullToAbsent) {
    return CharacterCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      thumbnailUrl: Value(thumbnailUrl),
    );
  }

  factory CharacterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CharacterData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      thumbnailUrl: serializer.fromJson<String>(json['thumbnailUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'thumbnailUrl': serializer.toJson<String>(thumbnailUrl),
    };
  }

  CharacterData copyWith(
          {String? id,
          String? name,
          String? description,
          String? thumbnailUrl}) =>
      CharacterData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );
  @override
  String toString() {
    return (StringBuffer('CharacterData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode, $mrjc(description.hashCode, thumbnailUrl.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.thumbnailUrl == this.thumbnailUrl);
}

class CharacterCompanion extends UpdateCompanion<CharacterData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> thumbnailUrl;
  const CharacterCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
  });
  CharacterCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String thumbnailUrl,
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        thumbnailUrl = Value(thumbnailUrl);
  static Insertable<CharacterData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? thumbnailUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
    });
  }

  CharacterCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String>? thumbnailUrl}) {
    return CharacterCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl')
          ..write(')'))
        .toString();
  }
}

class $CharacterTable extends Character
    with TableInfo<$CharacterTable, CharacterData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CharacterTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  late final GeneratedColumn<String?> thumbnailUrl = GeneratedColumn<String?>(
      'thumbnail_url', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, description, thumbnailUrl];
  @override
  String get aliasedName => _alias ?? 'character';
  @override
  String get actualTableName => 'character';
  @override
  VerificationContext validateIntegrity(Insertable<CharacterData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    } else if (isInserting) {
      context.missing(_thumbnailUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CharacterData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CharacterTable createAlias(String alias) {
    return $CharacterTable(_db, alias);
  }
}

class Serie extends DataClass implements Insertable<Serie> {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  Serie(
      {required this.id,
      required this.title,
      required this.description,
      required this.thumbnailUrl});
  factory Serie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Serie(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      thumbnailUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_url'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    return map;
  }

  SeriesCompanion toCompanion(bool nullToAbsent) {
    return SeriesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      thumbnailUrl: Value(thumbnailUrl),
    );
  }

  factory Serie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Serie(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      thumbnailUrl: serializer.fromJson<String>(json['thumbnailUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'thumbnailUrl': serializer.toJson<String>(thumbnailUrl),
    };
  }

  Serie copyWith(
          {String? id,
          String? title,
          String? description,
          String? thumbnailUrl}) =>
      Serie(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );
  @override
  String toString() {
    return (StringBuffer('Serie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode, $mrjc(description.hashCode, thumbnailUrl.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Serie &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.thumbnailUrl == this.thumbnailUrl);
}

class SeriesCompanion extends UpdateCompanion<Serie> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> thumbnailUrl;
  const SeriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
  });
  SeriesCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String thumbnailUrl,
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        thumbnailUrl = Value(thumbnailUrl);
  static Insertable<Serie> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? thumbnailUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
    });
  }

  SeriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? thumbnailUrl}) {
    return SeriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl')
          ..write(')'))
        .toString();
  }
}

class $SeriesTable extends Series with TableInfo<$SeriesTable, Serie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SeriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  late final GeneratedColumn<String?> thumbnailUrl = GeneratedColumn<String?>(
      'thumbnail_url', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, description, thumbnailUrl];
  @override
  String get aliasedName => _alias ?? 'series';
  @override
  String get actualTableName => 'series';
  @override
  VerificationContext validateIntegrity(Insertable<Serie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    } else if (isInserting) {
      context.missing(_thumbnailUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Serie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Serie.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SeriesTable createAlias(String alias) {
    return $SeriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CharacterTable character = $CharacterTable(this);
  late final $SeriesTable series = $SeriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [character, series];
}
