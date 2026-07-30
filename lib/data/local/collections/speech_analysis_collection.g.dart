// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_analysis_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSpeechAnalysisCollectionCollection on Isar {
  IsarCollection<SpeechAnalysisCollection> get speechAnalysisCollections =>
      this.collection();
}

const SpeechAnalysisCollectionSchema = CollectionSchema(
  name: r'SpeechAnalysisCollection',
  id: -3493312815952884197,
  properties: {
    r'audioPath': PropertySchema(
      id: 0,
      name: r'audioPath',
      type: IsarType.string,
    ),
    r'averageAmplitude': PropertySchema(
      id: 1,
      name: r'averageAmplitude',
      type: IsarType.double,
    ),
    r'clarityScore': PropertySchema(
      id: 2,
      name: r'clarityScore',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'domainId': PropertySchema(
      id: 4,
      name: r'domainId',
      type: IsarType.string,
    ),
    r'durationMs': PropertySchema(
      id: 5,
      name: r'durationMs',
      type: IsarType.long,
    ),
    r'estimatedWords': PropertySchema(
      id: 6,
      name: r'estimatedWords',
      type: IsarType.long,
    ),
    r'fluencyScore': PropertySchema(
      id: 7,
      name: r'fluencyScore',
      type: IsarType.double,
    ),
    r'messageId': PropertySchema(
      id: 8,
      name: r'messageId',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 9,
      name: r'notes',
      type: IsarType.stringList,
    ),
    r'paceWordsPerMinute': PropertySchema(
      id: 10,
      name: r'paceWordsPerMinute',
      type: IsarType.double,
    ),
    r'pauseCount': PropertySchema(
      id: 11,
      name: r'pauseCount',
      type: IsarType.long,
    ),
    r'qualityBand': PropertySchema(
      id: 12,
      name: r'qualityBand',
      type: IsarType.string,
    ),
    r'sessionId': PropertySchema(
      id: 13,
      name: r'sessionId',
      type: IsarType.string,
    ),
    r'speakingRatio': PropertySchema(
      id: 14,
      name: r'speakingRatio',
      type: IsarType.double,
    ),
    r'userId': PropertySchema(
      id: 15,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _speechAnalysisCollectionEstimateSize,
  serialize: _speechAnalysisCollectionSerialize,
  deserialize: _speechAnalysisCollectionDeserialize,
  deserializeProp: _speechAnalysisCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _speechAnalysisCollectionGetId,
  getLinks: _speechAnalysisCollectionGetLinks,
  attach: _speechAnalysisCollectionAttach,
  version: '3.1.0+1',
);

int _speechAnalysisCollectionEstimateSize(
  SpeechAnalysisCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audioPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.domainId.length * 3;
  {
    final value = object.messageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.notes.length * 3;
  {
    for (var i = 0; i < object.notes.length; i++) {
      final value = object.notes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.qualityBand.length * 3;
  {
    final value = object.sessionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _speechAnalysisCollectionSerialize(
  SpeechAnalysisCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioPath);
  writer.writeDouble(offsets[1], object.averageAmplitude);
  writer.writeDouble(offsets[2], object.clarityScore);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.domainId);
  writer.writeLong(offsets[5], object.durationMs);
  writer.writeLong(offsets[6], object.estimatedWords);
  writer.writeDouble(offsets[7], object.fluencyScore);
  writer.writeString(offsets[8], object.messageId);
  writer.writeStringList(offsets[9], object.notes);
  writer.writeDouble(offsets[10], object.paceWordsPerMinute);
  writer.writeLong(offsets[11], object.pauseCount);
  writer.writeString(offsets[12], object.qualityBand);
  writer.writeString(offsets[13], object.sessionId);
  writer.writeDouble(offsets[14], object.speakingRatio);
  writer.writeString(offsets[15], object.userId);
}

SpeechAnalysisCollection _speechAnalysisCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SpeechAnalysisCollection();
  object.audioPath = reader.readStringOrNull(offsets[0]);
  object.averageAmplitude = reader.readDouble(offsets[1]);
  object.clarityScore = reader.readDouble(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.domainId = reader.readString(offsets[4]);
  object.durationMs = reader.readLong(offsets[5]);
  object.estimatedWords = reader.readLong(offsets[6]);
  object.fluencyScore = reader.readDouble(offsets[7]);
  object.id = id;
  object.messageId = reader.readStringOrNull(offsets[8]);
  object.notes = reader.readStringList(offsets[9]) ?? [];
  object.paceWordsPerMinute = reader.readDouble(offsets[10]);
  object.pauseCount = reader.readLong(offsets[11]);
  object.qualityBand = reader.readString(offsets[12]);
  object.sessionId = reader.readStringOrNull(offsets[13]);
  object.speakingRatio = reader.readDouble(offsets[14]);
  object.userId = reader.readString(offsets[15]);
  return object;
}

P _speechAnalysisCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _speechAnalysisCollectionGetId(SpeechAnalysisCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _speechAnalysisCollectionGetLinks(
    SpeechAnalysisCollection object) {
  return [];
}

void _speechAnalysisCollectionAttach(
    IsarCollection<dynamic> col, Id id, SpeechAnalysisCollection object) {
  object.id = id;
}

extension SpeechAnalysisCollectionByIndex
    on IsarCollection<SpeechAnalysisCollection> {
  Future<SpeechAnalysisCollection?> getByDomainId(String domainId) {
    return getByIndex(r'domainId', [domainId]);
  }

  SpeechAnalysisCollection? getByDomainIdSync(String domainId) {
    return getByIndexSync(r'domainId', [domainId]);
  }

  Future<bool> deleteByDomainId(String domainId) {
    return deleteByIndex(r'domainId', [domainId]);
  }

  bool deleteByDomainIdSync(String domainId) {
    return deleteByIndexSync(r'domainId', [domainId]);
  }

  Future<List<SpeechAnalysisCollection?>> getAllByDomainId(
      List<String> domainIdValues) {
    final values = domainIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'domainId', values);
  }

  List<SpeechAnalysisCollection?> getAllByDomainIdSync(
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

  Future<Id> putByDomainId(SpeechAnalysisCollection object) {
    return putByIndex(r'domainId', object);
  }

  Id putByDomainIdSync(SpeechAnalysisCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'domainId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDomainId(List<SpeechAnalysisCollection> objects) {
    return putAllByIndex(r'domainId', objects);
  }

  List<Id> putAllByDomainIdSync(List<SpeechAnalysisCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'domainId', objects, saveLinks: saveLinks);
  }
}

extension SpeechAnalysisCollectionQueryWhereSort on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QWhere> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SpeechAnalysisCollectionQueryWhere on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QWhereClause> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterWhereClause> domainIdEqualTo(String domainId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domainId',
        value: [domainId],
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

extension SpeechAnalysisCollectionQueryFilter on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QFilterCondition> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioPath',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioPath',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      audioPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      audioPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> audioPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> averageAmplitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageAmplitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> averageAmplitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageAmplitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> averageAmplitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageAmplitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> averageAmplitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageAmplitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> clarityScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clarityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> clarityScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clarityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> clarityScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clarityScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> clarityScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clarityScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> domainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> domainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domainId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> durationMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> durationMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> durationMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> durationMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> estimatedWordsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimatedWords',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> estimatedWordsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimatedWords',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> estimatedWordsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimatedWords',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> estimatedWordsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimatedWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> fluencyScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fluencyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> fluencyScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fluencyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> fluencyScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fluencyScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> fluencyScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fluencyScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageId',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      notesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      notesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> notesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> paceWordsPerMinuteEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paceWordsPerMinute',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> paceWordsPerMinuteGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paceWordsPerMinute',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> paceWordsPerMinuteLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paceWordsPerMinute',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> paceWordsPerMinuteBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paceWordsPerMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> pauseCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> pauseCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> pauseCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> pauseCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pauseCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualityBand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      qualityBandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qualityBand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
          QAfterFilterCondition>
      qualityBandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qualityBand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityBand',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> qualityBandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qualityBand',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> sessionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> sessionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> sessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> sessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> speakingRatioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speakingRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> speakingRatioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speakingRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> speakingRatioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speakingRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> speakingRatioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speakingRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
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

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension SpeechAnalysisCollectionQueryObject on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QFilterCondition> {}

extension SpeechAnalysisCollectionQueryLinks on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QFilterCondition> {}

extension SpeechAnalysisCollectionQuerySortBy on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QSortBy> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByAverageAmplitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageAmplitude', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByAverageAmplitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageAmplitude', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByClarityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clarityScore', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByClarityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clarityScore', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByEstimatedWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedWords', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByEstimatedWordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedWords', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByFluencyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyScore', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByFluencyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyScore', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByPaceWordsPerMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceWordsPerMinute', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByPaceWordsPerMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceWordsPerMinute', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByPauseCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByQualityBand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityBand', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByQualityBandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityBand', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortBySpeakingRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakingRatio', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortBySpeakingRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakingRatio', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SpeechAnalysisCollectionQuerySortThenBy on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QSortThenBy> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByAverageAmplitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageAmplitude', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByAverageAmplitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageAmplitude', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByClarityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clarityScore', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByClarityScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clarityScore', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByDomainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByDomainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domainId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByEstimatedWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedWords', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByEstimatedWordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedWords', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByFluencyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyScore', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByFluencyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyScore', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByPaceWordsPerMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceWordsPerMinute', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByPaceWordsPerMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceWordsPerMinute', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByPauseCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByQualityBand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityBand', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByQualityBandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityBand', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenBySpeakingRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakingRatio', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenBySpeakingRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakingRatio', Sort.desc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SpeechAnalysisCollectionQueryWhereDistinct on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct> {
  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByAudioPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByAverageAmplitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageAmplitude');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByClarityScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clarityScore');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByDomainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMs');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByEstimatedWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedWords');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByFluencyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fluencyScore');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByPaceWordsPerMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paceWordsPerMinute');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pauseCount');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByQualityBand({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityBand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctBySpeakingRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speakingRatio');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, SpeechAnalysisCollection, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension SpeechAnalysisCollectionQueryProperty on QueryBuilder<
    SpeechAnalysisCollection, SpeechAnalysisCollection, QQueryProperty> {
  QueryBuilder<SpeechAnalysisCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String?, QQueryOperations>
      audioPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioPath');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, double, QQueryOperations>
      averageAmplitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageAmplitude');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, double, QQueryOperations>
      clarityScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clarityScore');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String, QQueryOperations>
      domainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domainId');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, int, QQueryOperations>
      durationMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMs');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, int, QQueryOperations>
      estimatedWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedWords');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, double, QQueryOperations>
      fluencyScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fluencyScore');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String?, QQueryOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, List<String>, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, double, QQueryOperations>
      paceWordsPerMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paceWordsPerMinute');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, int, QQueryOperations>
      pauseCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pauseCount');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String, QQueryOperations>
      qualityBandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityBand');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String?, QQueryOperations>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionId');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, double, QQueryOperations>
      speakingRatioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speakingRatio');
    });
  }

  QueryBuilder<SpeechAnalysisCollection, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
