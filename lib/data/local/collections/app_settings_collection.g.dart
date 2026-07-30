// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsCollectionCollection on Isar {
  IsarCollection<AppSettingsCollection> get appSettingsCollections =>
      this.collection();
}

const AppSettingsCollectionSchema = CollectionSchema(
  name: r'AppSettingsCollection',
  id: -1201272823460988305,
  properties: {
    r'autoSaveExpressions': PropertySchema(
      id: 0,
      name: r'autoSaveExpressions',
      type: IsarType.bool,
    ),
    r'dailyReminderEnabled': PropertySchema(
      id: 1,
      name: r'dailyReminderEnabled',
      type: IsarType.bool,
    ),
    r'dailyReminderHour': PropertySchema(
      id: 2,
      name: r'dailyReminderHour',
      type: IsarType.long,
    ),
    r'dailyReminderMinute': PropertySchema(
      id: 3,
      name: r'dailyReminderMinute',
      type: IsarType.long,
    ),
    r'domainId': PropertySchema(
      id: 4,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'hapticsEnabled': PropertySchema(
      id: 5,
      name: r'hapticsEnabled',
      type: IsarType.bool,
    ),
    r'interfaceLanguageCode': PropertySchema(
      id: 6,
      name: r'interfaceLanguageCode',
      type: IsarType.string,
    ),
    r'showCoachHints': PropertySchema(
      id: 7,
      name: r'showCoachHints',
      type: IsarType.bool,
    ),
    r'soundEnabled': PropertySchema(
      id: 8,
      name: r'soundEnabled',
      type: IsarType.bool,
    ),
    r'themePreference': PropertySchema(
      id: 9,
      name: r'themePreference',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _appSettingsCollectionEstimateSize,
  serialize: _appSettingsCollectionSerialize,
  deserialize: _appSettingsCollectionDeserialize,
  deserializeProp: _appSettingsCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'domainId': IndexSchema(
      id: -9138809277110658179,
      name: r'domainId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'domainId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsCollectionGetId,
  getLinks: _appSettingsCollectionGetLinks,
  attach: _appSettingsCollectionAttach,
  version: '3.1.0+1',
);

int _appSettingsCollectionEstimateSize(
  AppSettingsCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.domainId.length * 3;
  bytesCount += 3 + object.interfaceLanguageCode.length * 3;
  bytesCount += 3 + object.themePreference.length * 3;
  return bytesCount;
}

void _appSettingsCollectionSerialize(
  AppSettingsCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.autoSaveExpressions);
  writer.writeBool(offsets[1], object.dailyReminderEnabled);
  writer.writeLong(offsets[2], object.dailyReminderHour);
  writer.writeLong(offsets[3], object.dailyReminderMinute);
  writer.writeString(offsets[4], object.domainId);
  writer.writeBool(offsets[5], object.hapticsEnabled);
  writer.writeString(offsets[6], object.interfaceLanguageCode);
  writer.writeBool(offsets[7], object.showCoachHints);
  writer.writeBool(offsets[8], object.soundEnabled);
  writer.writeString(offsets[9], object.themePreference);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

AppSettingsCollection _appSettingsCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsCollection();
  object.autoSaveExpressions = reader.readBool(offsets[0]);
  object.dailyReminderEnabled = reader.readBool(offsets[1]);
  object.dailyReminderHour = reader.readLong(offsets[2]);
  object.dailyReminderMinute = reader.readLong(offsets[3]);
  object.domainId = reader.readString(offsets[4]);
  object.hapticsEnabled = reader.readBool(offsets[5]);
  object.id = id;
  object.interfaceLanguageCode = reader.readString(offsets[6]);
  object.showCoachHints = reader.readBool(offsets[7]);
  object.soundEnabled = reader.readBool(offsets[8]);
  object.themePreference = reader.readString(offsets[9]);
  object.updatedAt = reader.readDateTime(offsets[10]);
  return object;
}

P _appSettingsCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsCollectionGetId(AppSettingsCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsCollectionGetLinks(
    AppSettingsCollection object) {
  return [];
}

void _appSettingsCollectionAttach(
    IsarCollection<dynamic> col, Id id, AppSettingsCollection object) {
  object.id = id;
}

extension AppSettingsCollectionByIndex
    on IsarCollection<AppSettingsCollection> {
  Future<AppSettingsCollection?> getByDomainId(String domainId) {
    return getByIndex(r'domainId', [domainId]);
  }

  AppSettingsCollection? getByDomainIdSync(String domainId) {
    return getByIndexSync(r'domainId', [domainId]);
  }

  Future<bool> deleteByDomainId(String domainId) {
    return deleteByIndex(r'domainId', [domainId]);
  }

  bool deleteByDomainIdSync(String domainId) {
    return deleteByIndexSync(r'domainId', [domainId]);
  }

  Future<List<AppSettingsCollection?>> getAllByDomainId(
      List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'domainId', values);
  }

  List<AppSettingsCollection?> getAllByDomainIdSync(
      List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'domainId', values);
  }

  Future<int> deleteAllByDomainId(List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'domainId', values);
  }

  int deleteAllByDomainIdSync(List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'domainId', values);
  }

  Future<Id> putByDomainId(AppSettingsCollection object) {
    return putByIndex(r'domainId', object);
  }

  Id putByDomainIdSync(AppSettingsCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'domainId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDomainId(List<AppSettingsCollection> objects) {
    return putAllByIndex(r'domainId', objects);
  }

  List<Id> putAllByDomainIdSync(List<AppSettingsCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'domainId', objects, saveLinks: saveLinks);
  }
}

extension AppSettingsCollectionQueryWhereSort
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QWhere> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsCollectionQueryWhere on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QWhereClause> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      domainIdEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domainId',
        value: [domainId],
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      domainIdNotEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domainId',
              lower: [],
              upper: [domainId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domainId',
              lower: [domainId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domainId',
              lower: [domainId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domainId',
              lower: [],
              upper: [domainId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AppSettingsCollectionQueryFilter on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> autoSaveExpressionsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoSaveExpressions',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyReminderHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderMinuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyReminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderMinuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyReminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyReminderMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> dailyReminderMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyReminderMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'domainId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      domainIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      domainIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domainId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> hapticsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hapticsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interfaceLanguageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      interfaceLanguageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interfaceLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      interfaceLanguageCodeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interfaceLanguageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interfaceLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> interfaceLanguageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interfaceLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> showCoachHintsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showCoachHints',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> soundEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themePreference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      themePreferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themePreference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      themePreferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themePreference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themePreference',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themePreferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themePreference',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsCollectionQueryObject on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQueryLinks on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQuerySortBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByAutoSaveExpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoSaveExpressions', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByAutoSaveExpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoSaveExpressions', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderHour', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderHour', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderMinute', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDailyReminderMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderMinute', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByHapticsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByHapticsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByInterfaceLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interfaceLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByInterfaceLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interfaceLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByShowCoachHints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showCoachHints', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByShowCoachHintsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showCoachHints', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByThemePreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themePreference', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByThemePreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themePreference', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQuerySortThenBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortThenBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByAutoSaveExpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoSaveExpressions', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByAutoSaveExpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoSaveExpressions', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderHour', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderHour', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderMinute', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDailyReminderMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyReminderMinute', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByHapticsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByHapticsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByInterfaceLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interfaceLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByInterfaceLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interfaceLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByShowCoachHints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showCoachHints', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByShowCoachHintsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showCoachHints', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByThemePreference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themePreference', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByThemePreferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themePreference', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQueryWhereDistinct
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByAutoSaveExpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoSaveExpressions');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByDailyReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyReminderEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByDailyReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyReminderHour');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByDailyReminderMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyReminderMinute');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByDomainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByHapticsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hapticsEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByInterfaceLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interfaceLanguageCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByShowCoachHints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showCoachHints');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByThemePreference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themePreference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension AppSettingsCollectionQueryProperty on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QQueryProperty> {
  QueryBuilder<AppSettingsCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      autoSaveExpressionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoSaveExpressions');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      dailyReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyReminderEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, int, QQueryOperations>
      dailyReminderHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyReminderHour');
    });
  }

  QueryBuilder<AppSettingsCollection, int, QQueryOperations>
      dailyReminderMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyReminderMinute');
    });
  }

  QueryBuilder<AppSettingsCollection, String, QQueryOperations>
      domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      hapticsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hapticsEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, String, QQueryOperations>
      interfaceLanguageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interfaceLanguageCode');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      showCoachHintsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showCoachHints');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      soundEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, String, QQueryOperations>
      themePreferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themePreference');
    });
  }

  QueryBuilder<AppSettingsCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
