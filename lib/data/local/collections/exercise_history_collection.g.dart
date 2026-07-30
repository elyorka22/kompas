// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_history_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseHistoryCollectionCollection on Isar {
  IsarCollection<ExerciseHistoryCollection> get exerciseHistoryCollections =>
      this.collection();
}

const ExerciseHistoryCollectionSchema = CollectionSchema(
  name: r'ExerciseHistoryCollection',
  id: 8624021802743752975,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'domainId': PropertySchema(
      id: 1,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'exerciseId': PropertySchema(
      id: 2,
      name: r'exerciseId',
      type: IsarType.string,
    ),
    r'mode': PropertySchema(
      id: 3,
      name: r'mode',
      type: IsarType.string,
    ),
    r'primarySkillId': PropertySchema(
      id: 4,
      name: r'primarySkillId',
      type: IsarType.string,
    ),
    r'sessionId': PropertySchema(
      id: 5,
      name: r'sessionId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    ),
    r'xpEarned': PropertySchema(
      id: 7,
      name: r'xpEarned',
      type: IsarType.long,
    )
  },
  estimateSize: _exerciseHistoryCollectionEstimateSize,
  serialize: _exerciseHistoryCollectionSerialize,
  deserialize: _exerciseHistoryCollectionDeserialize,
  deserializeProp: _exerciseHistoryCollectionDeserializeProp,
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
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'exerciseId': IndexSchema(
      id: -5431545612219001672,
      name: r'exerciseId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'exerciseId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'completedAt': IndexSchema(
      id: -3156591011457686752,
      name: r'completedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'completedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _exerciseHistoryCollectionGetId,
  getLinks: _exerciseHistoryCollectionGetLinks,
  attach: _exerciseHistoryCollectionAttach,
  version: '3.1.0+1',
);

int _exerciseHistoryCollectionEstimateSize(
  ExerciseHistoryCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.domainId.length * 3;
  bytesCount += 3 + object.exerciseId.length * 3;
  bytesCount += 3 + object.mode.length * 3;
  bytesCount += 3 + object.primarySkillId.length * 3;
  {
    final value = object.sessionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _exerciseHistoryCollectionSerialize(
  ExerciseHistoryCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeString(offsets[1], object.domainId);
  writer.writeString(offsets[2], object.exerciseId);
  writer.writeString(offsets[3], object.mode);
  writer.writeString(offsets[4], object.primarySkillId);
  writer.writeString(offsets[5], object.sessionId);
  writer.writeString(offsets[6], object.userId);
  writer.writeLong(offsets[7], object.xpEarned);
}

ExerciseHistoryCollection _exerciseHistoryCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseHistoryCollection();
  object.completedAt = reader.readDateTime(offsets[0]);
  object.domainId = reader.readString(offsets[1]);
  object.exerciseId = reader.readString(offsets[2]);
  object.id = id;
  object.mode = reader.readString(offsets[3]);
  object.primarySkillId = reader.readString(offsets[4]);
  object.sessionId = reader.readStringOrNull(offsets[5]);
  object.userId = reader.readString(offsets[6]);
  object.xpEarned = reader.readLong(offsets[7]);
  return object;
}

P _exerciseHistoryCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exerciseHistoryCollectionGetId(ExerciseHistoryCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _exerciseHistoryCollectionGetLinks(
    ExerciseHistoryCollection object) {
  return [];
}

void _exerciseHistoryCollectionAttach(
    IsarCollection<dynamic> col, Id id, ExerciseHistoryCollection object) {
  object.id = id;
}

extension ExerciseHistoryCollectionByIndex
    on IsarCollection<ExerciseHistoryCollection> {
  Future<ExerciseHistoryCollection?> getByDomainId(String domainId) {
    return getByIndex(r'domainId', [domainId]);
  }

  ExerciseHistoryCollection? getByDomainIdSync(String domainId) {
    return getByIndexSync(r'domainId', [domainId]);
  }

  Future<bool> deleteByDomainId(String domainId) {
    return deleteByIndex(r'domainId', [domainId]);
  }

  bool deleteByDomainIdSync(String domainId) {
    return deleteByIndexSync(r'domainId', [domainId]);
  }

  Future<List<ExerciseHistoryCollection?>> getAllByDomainId(
      List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'domainId', values);
  }

  List<ExerciseHistoryCollection?> getAllByDomainIdSync(
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

  Future<Id> putByDomainId(ExerciseHistoryCollection object) {
    return putByIndex(r'domainId', object);
  }

  Id putByDomainIdSync(ExerciseHistoryCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'domainId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDomainId(List<ExerciseHistoryCollection> objects) {
    return putAllByIndex(r'domainId', objects);
  }

  List<Id> putAllByDomainIdSync(List<ExerciseHistoryCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'domainId', objects, saveLinks: saveLinks);
  }
}

extension ExerciseHistoryCollectionQueryWhereSort on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QWhere> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhere> anyCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'completedAt'),
      );
    });
  }
}

extension ExerciseHistoryCollectionQueryWhere on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QWhereClause> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> domainIdEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domainId',
        value: [domainId],
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> exerciseIdEqualTo(String exerciseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'exerciseId',
        value: [exerciseId],
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> exerciseIdNotEqualTo(String exerciseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exerciseId',
              lower: [],
              upper: [exerciseId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exerciseId',
              lower: [exerciseId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exerciseId',
              lower: [exerciseId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exerciseId',
              lower: [],
              upper: [exerciseId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> completedAtEqualTo(DateTime completedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'completedAt',
        value: [completedAt],
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> completedAtNotEqualTo(DateTime completedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [],
              upper: [completedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [completedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [completedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [],
              upper: [completedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> completedAtGreaterThan(
    DateTime completedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [completedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> completedAtLessThan(
    DateTime completedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [],
        upper: [completedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterWhereClause> completedAtBetween(
    DateTime lowerCompletedAt,
    DateTime upperCompletedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [lowerCompletedAt],
        includeLower: includeLower,
        upper: [upperCompletedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExerciseHistoryCollectionQueryFilter on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QFilterCondition> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> completedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> completedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      exerciseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      exerciseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> exerciseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      modeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      modeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mode',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> modeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mode',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primarySkillId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      primarySkillIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primarySkillId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      primarySkillIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primarySkillId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primarySkillId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> primarySkillIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primarySkillId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      sessionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
          QAfterFilterCondition>
      sessionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sessionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> sessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
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

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> xpEarnedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> xpEarnedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> xpEarnedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterFilterCondition> xpEarnedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xpEarned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExerciseHistoryCollectionQueryObject on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QFilterCondition> {}

extension ExerciseHistoryCollectionQueryLinks on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QFilterCondition> {}

extension ExerciseHistoryCollectionQuerySortBy on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QSortBy> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByPrimarySkillId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primarySkillId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByPrimarySkillIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primarySkillId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> sortByXpEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.desc);
    });
  }
}

extension ExerciseHistoryCollectionQuerySortThenBy on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QSortThenBy> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByPrimarySkillId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primarySkillId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByPrimarySkillIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primarySkillId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.asc);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection,
      QAfterSortBy> thenByXpEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.desc);
    });
  }
}

extension ExerciseHistoryCollectionQueryWhereDistinct on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct> {
  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByDomainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByExerciseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByPrimarySkillId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primarySkillId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExerciseHistoryCollection, ExerciseHistoryCollection, QDistinct>
      distinctByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xpEarned');
    });
  }
}

extension ExerciseHistoryCollectionQueryProperty on QueryBuilder<
    ExerciseHistoryCollection, ExerciseHistoryCollection, QQueryProperty> {
  QueryBuilder<ExerciseHistoryCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, DateTime, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String, QQueryOperations>
      domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String, QQueryOperations>
      exerciseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseId');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String, QQueryOperations>
      modeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mode');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String, QQueryOperations>
      primarySkillIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primarySkillId');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String?, QQueryOperations>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionId');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<ExerciseHistoryCollection, int, QQueryOperations>
      xpEarnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xpEarned');
    });
  }
}
