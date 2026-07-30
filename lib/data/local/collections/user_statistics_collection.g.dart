// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserStatisticsCollectionCollection on Isar {
  IsarCollection<UserStatisticsCollection> get userStatisticsCollections =>
      this.collection();
}

const UserStatisticsCollectionSchema = CollectionSchema(
  name: r'UserStatisticsCollection',
  id: -233489998027290421,
  properties: {
    r'achievementsUnlocked': PropertySchema(
      id: 0,
      name: r'achievementsUnlocked',
      type: IsarType.long,
    ),
    r'completedSessions': PropertySchema(
      id: 1,
      name: r'completedSessions',
      type: IsarType.long,
    ),
    r'currentStreakDays': PropertySchema(
      id: 2,
      name: r'currentStreakDays',
      type: IsarType.long,
    ),
    r'domainId': PropertySchema(
      id: 3,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'expressionsMastered': PropertySchema(
      id: 4,
      name: r'expressionsMastered',
      type: IsarType.long,
    ),
    r'expressionsSaved': PropertySchema(
      id: 5,
      name: r'expressionsSaved',
      type: IsarType.long,
    ),
    r'lastPracticeAt': PropertySchema(
      id: 6,
      name: r'lastPracticeAt',
      type: IsarType.dateTime,
    ),
    r'longestStreakDays': PropertySchema(
      id: 7,
      name: r'longestStreakDays',
      type: IsarType.long,
    ),
    r'missionsCompleted': PropertySchema(
      id: 8,
      name: r'missionsCompleted',
      type: IsarType.long,
    ),
    r'skillsMastered': PropertySchema(
      id: 9,
      name: r'skillsMastered',
      type: IsarType.long,
    ),
    r'totalSessions': PropertySchema(
      id: 10,
      name: r'totalSessions',
      type: IsarType.long,
    ),
    r'totalSpeakingSeconds': PropertySchema(
      id: 11,
      name: r'totalSpeakingSeconds',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 13,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _userStatisticsCollectionEstimateSize,
  serialize: _userStatisticsCollectionSerialize,
  deserialize: _userStatisticsCollectionDeserialize,
  deserializeProp: _userStatisticsCollectionDeserializeProp,
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
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userStatisticsCollectionGetId,
  getLinks: _userStatisticsCollectionGetLinks,
  attach: _userStatisticsCollectionAttach,
  version: '3.1.0+1',
);

int _userStatisticsCollectionEstimateSize(
  UserStatisticsCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.domainId.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userStatisticsCollectionSerialize(
  UserStatisticsCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.achievementsUnlocked);
  writer.writeLong(offsets[1], object.completedSessions);
  writer.writeLong(offsets[2], object.currentStreakDays);
  writer.writeString(offsets[3], object.domainId);
  writer.writeLong(offsets[4], object.expressionsMastered);
  writer.writeLong(offsets[5], object.expressionsSaved);
  writer.writeDateTime(offsets[6], object.lastPracticeAt);
  writer.writeLong(offsets[7], object.longestStreakDays);
  writer.writeLong(offsets[8], object.missionsCompleted);
  writer.writeLong(offsets[9], object.skillsMastered);
  writer.writeLong(offsets[10], object.totalSessions);
  writer.writeLong(offsets[11], object.totalSpeakingSeconds);
  writer.writeDateTime(offsets[12], object.updatedAt);
  writer.writeString(offsets[13], object.userId);
}

UserStatisticsCollection _userStatisticsCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserStatisticsCollection();
  object.achievementsUnlocked = reader.readLong(offsets[0]);
  object.completedSessions = reader.readLong(offsets[1]);
  object.currentStreakDays = reader.readLong(offsets[2]);
  object.domainId = reader.readString(offsets[3]);
  object.expressionsMastered = reader.readLong(offsets[4]);
  object.expressionsSaved = reader.readLong(offsets[5]);
  object.id = id;
  object.lastPracticeAt = reader.readDateTimeOrNull(offsets[6]);
  object.longestStreakDays = reader.readLong(offsets[7]);
  object.missionsCompleted = reader.readLong(offsets[8]);
  object.skillsMastered = reader.readLong(offsets[9]);
  object.totalSessions = reader.readLong(offsets[10]);
  object.totalSpeakingSeconds = reader.readLong(offsets[11]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  object.userId = reader.readString(offsets[13]);
  return object;
}

P _userStatisticsCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userStatisticsCollectionGetId(UserStatisticsCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userStatisticsCollectionGetLinks(
    UserStatisticsCollection object) {
  return [];
}

void _userStatisticsCollectionAttach(
    IsarCollection<dynamic> col, Id id, UserStatisticsCollection object) {
  object.id = id;
}

extension UserStatisticsCollectionByIndex
    on IsarCollection<UserStatisticsCollection> {
  Future<UserStatisticsCollection?> getByDomainId(String domainId) {
    return getByIndex(r'domainId', [domainId]);
  }

  UserStatisticsCollection? getByDomainIdSync(String domainId) {
    return getByIndexSync(r'domainId', [domainId]);
  }

  Future<bool> deleteByDomainId(String domainId) {
    return deleteByIndex(r'domainId', [domainId]);
  }

  bool deleteByDomainIdSync(String domainId) {
    return deleteByIndexSync(r'domainId', [domainId]);
  }

  Future<List<UserStatisticsCollection?>> getAllByDomainId(
      List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'domainId', values);
  }

  List<UserStatisticsCollection?> getAllByDomainIdSync(
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

  Future<Id> putByDomainId(UserStatisticsCollection object) {
    return putByIndex(r'domainId', object);
  }

  Id putByDomainIdSync(UserStatisticsCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'domainId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDomainId(List<UserStatisticsCollection> objects) {
    return putAllByIndex(r'domainId', objects);
  }

  List<Id> putAllByDomainIdSync(List<UserStatisticsCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'domainId', objects, saveLinks: saveLinks);
  }

  Future<UserStatisticsCollection?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  UserStatisticsCollection? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<UserStatisticsCollection?>> getAllByUserId(
      List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<UserStatisticsCollection?> getAllByUserIdSync(
      List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(UserStatisticsCollection object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(UserStatisticsCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<UserStatisticsCollection> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<UserStatisticsCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension UserStatisticsCollectionQueryWhereSort on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QWhere> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserStatisticsCollectionQueryWhere on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QWhereClause> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> domainIdEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domainId',
        value: [domainId],
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> domainIdNotEqualTo(String domainId) {
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterWhereClause> userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserStatisticsCollectionQueryFilter on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QFilterCondition> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> achievementsUnlockedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementsUnlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> achievementsUnlockedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementsUnlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> achievementsUnlockedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementsUnlocked',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> achievementsUnlockedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementsUnlocked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> completedSessionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> completedSessionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> completedSessionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> completedSessionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedSessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> currentStreakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> currentStreakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> currentStreakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> currentStreakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsMasteredEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expressionsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsMasteredGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expressionsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsMasteredLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expressionsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsMasteredBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expressionsMastered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsSavedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expressionsSaved',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsSavedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expressionsSaved',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsSavedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expressionsSaved',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> expressionsSavedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expressionsSaved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPracticeAt',
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPracticeAt',
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPracticeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPracticeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPracticeAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> lastPracticeAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPracticeAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> longestStreakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> longestStreakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> longestStreakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> longestStreakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longestStreakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> missionsCompletedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missionsCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> missionsCompletedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'missionsCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> missionsCompletedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'missionsCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> missionsCompletedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'missionsCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> skillsMasteredEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skillsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> skillsMasteredGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'skillsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> skillsMasteredLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'skillsMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> skillsMasteredBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'skillsMastered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSessionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSessionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSessionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSessionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSpeakingSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSpeakingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSpeakingSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSpeakingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSpeakingSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSpeakingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> totalSpeakingSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSpeakingSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
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

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UserStatisticsCollectionQueryObject on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QFilterCondition> {}

extension UserStatisticsCollectionQueryLinks on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QFilterCondition> {}

extension UserStatisticsCollectionQuerySortBy on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QSortBy> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByAchievementsUnlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementsUnlocked', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByAchievementsUnlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementsUnlocked', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByCompletedSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedSessions', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByCompletedSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedSessions', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByCurrentStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByExpressionsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsMastered', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByExpressionsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsMastered', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByExpressionsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsSaved', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByExpressionsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsSaved', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByLastPracticeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPracticeAt', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByLastPracticeAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPracticeAt', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByLongestStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByMissionsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missionsCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByMissionsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missionsCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortBySkillsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skillsMastered', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortBySkillsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skillsMastered', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByTotalSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByTotalSpeakingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpeakingSeconds', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByTotalSpeakingSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpeakingSeconds', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserStatisticsCollectionQuerySortThenBy on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QSortThenBy> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByAchievementsUnlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementsUnlocked', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByAchievementsUnlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementsUnlocked', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByCompletedSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedSessions', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByCompletedSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedSessions', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByCurrentStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByExpressionsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsMastered', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByExpressionsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsMastered', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByExpressionsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsSaved', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByExpressionsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expressionsSaved', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByLastPracticeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPracticeAt', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByLastPracticeAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPracticeAt', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByLongestStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByMissionsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missionsCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByMissionsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missionsCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenBySkillsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skillsMastered', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenBySkillsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skillsMastered', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByTotalSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSessions', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByTotalSpeakingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpeakingSeconds', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByTotalSpeakingSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSpeakingSeconds', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserStatisticsCollectionQueryWhereDistinct on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QDistinct> {
  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByAchievementsUnlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementsUnlocked');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByCompletedSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedSessions');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreakDays');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByDomainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByExpressionsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expressionsMastered');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByExpressionsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expressionsSaved');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByLastPracticeAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPracticeAt');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longestStreakDays');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByMissionsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'missionsCompleted');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctBySkillsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skillsMastered');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByTotalSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSessions');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByTotalSpeakingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSpeakingSeconds');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<UserStatisticsCollection, UserStatisticsCollection, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserStatisticsCollectionQueryProperty on QueryBuilder<
    UserStatisticsCollection, UserStatisticsCollection, QQueryProperty> {
  QueryBuilder<UserStatisticsCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      achievementsUnlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementsUnlocked');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      completedSessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedSessions');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      currentStreakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreakDays');
    });
  }

  QueryBuilder<UserStatisticsCollection, String, QQueryOperations>
      domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      expressionsMasteredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expressionsMastered');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      expressionsSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expressionsSaved');
    });
  }

  QueryBuilder<UserStatisticsCollection, DateTime?, QQueryOperations>
      lastPracticeAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPracticeAt');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      longestStreakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longestStreakDays');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      missionsCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'missionsCompleted');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      skillsMasteredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skillsMastered');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      totalSessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSessions');
    });
  }

  QueryBuilder<UserStatisticsCollection, int, QQueryOperations>
      totalSpeakingSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSpeakingSeconds');
    });
  }

  QueryBuilder<UserStatisticsCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<UserStatisticsCollection, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
