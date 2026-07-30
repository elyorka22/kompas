// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserCollectionCollection on Isar {
  IsarCollection<UserCollection> get userCollections => this.collection();
}

const UserCollectionSchema = CollectionSchema(
  name: r'UserCollection',
  id: 1551134645489327298,
  properties: {
    r'avatarSeed': PropertySchema(
      id: 0,
      name: r'avatarSeed',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dailySpeakingGoalMinutes': PropertySchema(
      id: 2,
      name: r'dailySpeakingGoalMinutes',
      type: IsarType.long,
    ),
    r'displayName': PropertySchema(
      id: 3,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'domainId': PropertySchema(
      id: 4,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'learningGoal': PropertySchema(
      id: 5,
      name: r'learningGoal',
      type: IsarType.string,
    ),
    r'nativeLanguageCode': PropertySchema(
      id: 6,
      name: r'nativeLanguageCode',
      type: IsarType.string,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 7,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'targetLanguageCode': PropertySchema(
      id: 8,
      name: r'targetLanguageCode',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _userCollectionEstimateSize,
  serialize: _userCollectionSerialize,
  deserialize: _userCollectionDeserialize,
  deserializeProp: _userCollectionDeserializeProp,
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
  getId: _userCollectionGetId,
  getLinks: _userCollectionGetLinks,
  attach: _userCollectionAttach,
  version: '3.1.0+1',
);

int _userCollectionEstimateSize(
  UserCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.avatarSeed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.domainId.length * 3;
  {
    final value = object.learningGoal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nativeLanguageCode.length * 3;
  bytesCount += 3 + object.targetLanguageCode.length * 3;
  return bytesCount;
}

void _userCollectionSerialize(
  UserCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarSeed);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.dailySpeakingGoalMinutes);
  writer.writeString(offsets[3], object.displayName);
  writer.writeString(offsets[4], object.domainId);
  writer.writeString(offsets[5], object.learningGoal);
  writer.writeString(offsets[6], object.nativeLanguageCode);
  writer.writeBool(offsets[7], object.onboardingCompleted);
  writer.writeString(offsets[8], object.targetLanguageCode);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

UserCollection _userCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserCollection();
  object.avatarSeed = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.dailySpeakingGoalMinutes = reader.readLong(offsets[2]);
  object.displayName = reader.readString(offsets[3]);
  object.domainId = reader.readString(offsets[4]);
  object.id = id;
  object.learningGoal = reader.readStringOrNull(offsets[5]);
  object.nativeLanguageCode = reader.readString(offsets[6]);
  object.onboardingCompleted = reader.readBool(offsets[7]);
  object.targetLanguageCode = reader.readString(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  return object;
}

P _userCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userCollectionGetId(UserCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userCollectionGetLinks(UserCollection object) {
  return [];
}

void _userCollectionAttach(
    IsarCollection<dynamic> col, Id id, UserCollection object) {
  object.id = id;
}

extension UserCollectionByIndex on IsarCollection<UserCollection> {
  Future<UserCollection?> getByDomainId(String domainId) {
    return getByIndex(r'domainId', [domainId]);
  }

  UserCollection? getByDomainIdSync(String domainId) {
    return getByIndexSync(r'domainId', [domainId]);
  }

  Future<bool> deleteByDomainId(String domainId) {
    return deleteByIndex(r'domainId', [domainId]);
  }

  bool deleteByDomainIdSync(String domainId) {
    return deleteByIndexSync(r'domainId', [domainId]);
  }

  Future<List<UserCollection?>> getAllByDomainId(List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'domainId', values);
  }

  List<UserCollection?> getAllByDomainIdSync(List<String> domainIdValues) {
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

  Future<Id> putByDomainId(UserCollection object) {
    return putByIndex(r'domainId', object);
  }

  Id putByDomainIdSync(UserCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'domainId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDomainId(List<UserCollection> objects) {
    return putAllByIndex(r'domainId', objects);
  }

  List<Id> putAllByDomainIdSync(List<UserCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'domainId', objects, saveLinks: saveLinks);
  }
}

extension UserCollectionQueryWhereSort
    on QueryBuilder<UserCollection, UserCollection, QWhere> {
  QueryBuilder<UserCollection, UserCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserCollectionQueryWhere
    on QueryBuilder<UserCollection, UserCollection, QWhereClause> {
  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
      domainIdEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domainId',
        value: [domainId],
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterWhereClause>
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

extension UserCollectionQueryFilter
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {
  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarSeed',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarSeed',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarSeed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarSeed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarSeed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarSeed',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      avatarSeedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarSeed',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dailySpeakingGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailySpeakingGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dailySpeakingGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailySpeakingGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dailySpeakingGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailySpeakingGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      dailySpeakingGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailySpeakingGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdEqualTo(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdGreaterThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdLessThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdBetween(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdStartsWith(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdEndsWith(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domainId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'learningGoal',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'learningGoal',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'learningGoal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'learningGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'learningGoal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'learningGoal',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      learningGoalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'learningGoal',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nativeLanguageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nativeLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nativeLanguageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nativeLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      nativeLanguageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nativeLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetLanguageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetLanguageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetLanguageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      targetLanguageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetLanguageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>
      updatedAtBetween(
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

extension UserCollectionQueryObject
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {}

extension UserCollectionQueryLinks
    on QueryBuilder<UserCollection, UserCollection, QFilterCondition> {}

extension UserCollectionQuerySortBy
    on QueryBuilder<UserCollection, UserCollection, QSortBy> {
  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarSeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarSeed', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByAvatarSeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarSeed', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDailySpeakingGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailySpeakingGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDailySpeakingGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailySpeakingGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLearningGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'learningGoal', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByLearningGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'learningGoal', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNativeLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nativeLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByNativeLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nativeLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByTargetLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByTargetLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension UserCollectionQuerySortThenBy
    on QueryBuilder<UserCollection, UserCollection, QSortThenBy> {
  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarSeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarSeed', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByAvatarSeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarSeed', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDailySpeakingGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailySpeakingGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDailySpeakingGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailySpeakingGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLearningGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'learningGoal', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByLearningGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'learningGoal', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNativeLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nativeLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByNativeLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nativeLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByTargetLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLanguageCode', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByTargetLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLanguageCode', Sort.desc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension UserCollectionQueryWhereDistinct
    on QueryBuilder<UserCollection, UserCollection, QDistinct> {
  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByAvatarSeed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarSeed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByDailySpeakingGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailySpeakingGoalMinutes');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct> distinctByDomainId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByLearningGoal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'learningGoal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByNativeLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nativeLanguageCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByTargetLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetLanguageCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCollection, UserCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension UserCollectionQueryProperty
    on QueryBuilder<UserCollection, UserCollection, QQueryProperty> {
  QueryBuilder<UserCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations> avatarSeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarSeed');
    });
  }

  QueryBuilder<UserCollection, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<UserCollection, int, QQueryOperations>
      dailySpeakingGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailySpeakingGoalMinutes');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations> domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<UserCollection, String?, QQueryOperations>
      learningGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'learningGoal');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations>
      nativeLanguageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nativeLanguageCode');
    });
  }

  QueryBuilder<UserCollection, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserCollection, String, QQueryOperations>
      targetLanguageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetLanguageCode');
    });
  }

  QueryBuilder<UserCollection, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
