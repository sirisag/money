// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monk_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonkProfileCollection on Isar {
  IsarCollection<MonkProfile> get monkProfiles => this.collection();
}

const MonkProfileSchema = CollectionSchema(
  name: r'MonkProfile',
  id: 2902152355260988989,
  properties: {
    r'contactInfo': PropertySchema(
      id: 0,
      name: r'contactInfo',
      type: IsarType.string,
    ),
    r'currentBalance': PropertySchema(
      id: 1,
      name: r'currentBalance',
      type: IsarType.long,
    ),
    r'monkPrimaryId': PropertySchema(
      id: 2,
      name: r'monkPrimaryId',
      type: IsarType.string,
    ),
    r'monkSecondaryId': PropertySchema(
      id: 3,
      name: r'monkSecondaryId',
      type: IsarType.string,
    ),
    r'nameOrTitle': PropertySchema(
      id: 4,
      name: r'nameOrTitle',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
      enumMap: _MonkProfilestatusEnumValueMap,
    )
  },
  estimateSize: _monkProfileEstimateSize,
  serialize: _monkProfileSerialize,
  deserialize: _monkProfileDeserialize,
  deserializeProp: _monkProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'monkPrimaryId': IndexSchema(
      id: -3863152760536671281,
      name: r'monkPrimaryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'monkPrimaryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'monkSecondaryId': IndexSchema(
      id: -9010629579488340994,
      name: r'monkSecondaryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'monkSecondaryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'appUser': LinkSchema(
      id: -7373767746251146062,
      name: r'appUser',
      target: r'AppUser',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _monkProfileGetId,
  getLinks: _monkProfileGetLinks,
  attach: _monkProfileAttach,
  version: '3.1.0+1',
);

int _monkProfileEstimateSize(
  MonkProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.contactInfo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.monkPrimaryId.length * 3;
  {
    final value = object.monkSecondaryId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nameOrTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.name.length * 3;
  return bytesCount;
}

void _monkProfileSerialize(
  MonkProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contactInfo);
  writer.writeLong(offsets[1], object.currentBalance);
  writer.writeString(offsets[2], object.monkPrimaryId);
  writer.writeString(offsets[3], object.monkSecondaryId);
  writer.writeString(offsets[4], object.nameOrTitle);
  writer.writeString(offsets[5], object.status.name);
}

MonkProfile _monkProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonkProfile();
  object.contactInfo = reader.readStringOrNull(offsets[0]);
  object.currentBalance = reader.readLong(offsets[1]);
  object.id = id;
  object.monkPrimaryId = reader.readString(offsets[2]);
  object.monkSecondaryId = reader.readStringOrNull(offsets[3]);
  object.nameOrTitle = reader.readStringOrNull(offsets[4]);
  object.status =
      _MonkProfilestatusValueEnumMap[reader.readStringOrNull(offsets[5])] ??
          MonkAccountStatus.active;
  return object;
}

P _monkProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_MonkProfilestatusValueEnumMap[reader.readStringOrNull(offset)] ??
          MonkAccountStatus.active) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MonkProfilestatusEnumValueMap = {
  r'active': r'active',
  r'moved': r'moved',
  r'resigned': r'resigned',
  r'unknown': r'unknown',
};
const _MonkProfilestatusValueEnumMap = {
  r'active': MonkAccountStatus.active,
  r'moved': MonkAccountStatus.moved,
  r'resigned': MonkAccountStatus.resigned,
  r'unknown': MonkAccountStatus.unknown,
};

Id _monkProfileGetId(MonkProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monkProfileGetLinks(MonkProfile object) {
  return [object.appUser];
}

void _monkProfileAttach(
    IsarCollection<dynamic> col, Id id, MonkProfile object) {
  object.id = id;
  object.appUser.attach(col, col.isar.collection<AppUser>(), r'appUser', id);
}

extension MonkProfileByIndex on IsarCollection<MonkProfile> {
  Future<MonkProfile?> getByMonkPrimaryId(String monkPrimaryId) {
    return getByIndex(r'monkPrimaryId', [monkPrimaryId]);
  }

  MonkProfile? getByMonkPrimaryIdSync(String monkPrimaryId) {
    return getByIndexSync(r'monkPrimaryId', [monkPrimaryId]);
  }

  Future<bool> deleteByMonkPrimaryId(String monkPrimaryId) {
    return deleteByIndex(r'monkPrimaryId', [monkPrimaryId]);
  }

  bool deleteByMonkPrimaryIdSync(String monkPrimaryId) {
    return deleteByIndexSync(r'monkPrimaryId', [monkPrimaryId]);
  }

  Future<List<MonkProfile?>> getAllByMonkPrimaryId(
      List<String> monkPrimaryIdValues) {
    final values = monkPrimaryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'monkPrimaryId', values);
  }

  List<MonkProfile?> getAllByMonkPrimaryIdSync(
      List<String> monkPrimaryIdValues) {
    final values = monkPrimaryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'monkPrimaryId', values);
  }

  Future<int> deleteAllByMonkPrimaryId(List<String> monkPrimaryIdValues) {
    final values = monkPrimaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'monkPrimaryId', values);
  }

  int deleteAllByMonkPrimaryIdSync(List<String> monkPrimaryIdValues) {
    final values = monkPrimaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'monkPrimaryId', values);
  }

  Future<Id> putByMonkPrimaryId(MonkProfile object) {
    return putByIndex(r'monkPrimaryId', object);
  }

  Id putByMonkPrimaryIdSync(MonkProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'monkPrimaryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMonkPrimaryId(List<MonkProfile> objects) {
    return putAllByIndex(r'monkPrimaryId', objects);
  }

  List<Id> putAllByMonkPrimaryIdSync(List<MonkProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'monkPrimaryId', objects, saveLinks: saveLinks);
  }

  Future<MonkProfile?> getByMonkSecondaryId(String? monkSecondaryId) {
    return getByIndex(r'monkSecondaryId', [monkSecondaryId]);
  }

  MonkProfile? getByMonkSecondaryIdSync(String? monkSecondaryId) {
    return getByIndexSync(r'monkSecondaryId', [monkSecondaryId]);
  }

  Future<bool> deleteByMonkSecondaryId(String? monkSecondaryId) {
    return deleteByIndex(r'monkSecondaryId', [monkSecondaryId]);
  }

  bool deleteByMonkSecondaryIdSync(String? monkSecondaryId) {
    return deleteByIndexSync(r'monkSecondaryId', [monkSecondaryId]);
  }

  Future<List<MonkProfile?>> getAllByMonkSecondaryId(
      List<String?> monkSecondaryIdValues) {
    final values = monkSecondaryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'monkSecondaryId', values);
  }

  List<MonkProfile?> getAllByMonkSecondaryIdSync(
      List<String?> monkSecondaryIdValues) {
    final values = monkSecondaryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'monkSecondaryId', values);
  }

  Future<int> deleteAllByMonkSecondaryId(List<String?> monkSecondaryIdValues) {
    final values = monkSecondaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'monkSecondaryId', values);
  }

  int deleteAllByMonkSecondaryIdSync(List<String?> monkSecondaryIdValues) {
    final values = monkSecondaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'monkSecondaryId', values);
  }

  Future<Id> putByMonkSecondaryId(MonkProfile object) {
    return putByIndex(r'monkSecondaryId', object);
  }

  Id putByMonkSecondaryIdSync(MonkProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'monkSecondaryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMonkSecondaryId(List<MonkProfile> objects) {
    return putAllByIndex(r'monkSecondaryId', objects);
  }

  List<Id> putAllByMonkSecondaryIdSync(List<MonkProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'monkSecondaryId', objects, saveLinks: saveLinks);
  }
}

extension MonkProfileQueryWhereSort
    on QueryBuilder<MonkProfile, MonkProfile, QWhere> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonkProfileQueryWhere
    on QueryBuilder<MonkProfile, MonkProfile, QWhereClause> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause> idBetween(
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkPrimaryIdEqualTo(String monkPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monkPrimaryId',
        value: [monkPrimaryId],
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkPrimaryIdNotEqualTo(String monkPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkPrimaryId',
              lower: [],
              upper: [monkPrimaryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkPrimaryId',
              lower: [monkPrimaryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkPrimaryId',
              lower: [monkPrimaryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkPrimaryId',
              lower: [],
              upper: [monkPrimaryId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkSecondaryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monkSecondaryId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkSecondaryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'monkSecondaryId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkSecondaryIdEqualTo(String? monkSecondaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monkSecondaryId',
        value: [monkSecondaryId],
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterWhereClause>
      monkSecondaryIdNotEqualTo(String? monkSecondaryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkSecondaryId',
              lower: [],
              upper: [monkSecondaryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkSecondaryId',
              lower: [monkSecondaryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkSecondaryId',
              lower: [monkSecondaryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monkSecondaryId',
              lower: [],
              upper: [monkSecondaryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MonkProfileQueryFilter
    on QueryBuilder<MonkProfile, MonkProfile, QFilterCondition> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contactInfo',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contactInfo',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      contactInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      currentBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      currentBalanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      currentBalanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      currentBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monkPrimaryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monkPrimaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkPrimaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monkPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monkSecondaryId',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monkSecondaryId',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monkSecondaryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monkSecondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monkSecondaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkSecondaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkSecondaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monkSecondaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameOrTitle',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameOrTitle',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameOrTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameOrTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameOrTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameOrTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      nameOrTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameOrTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusEqualTo(
    MonkAccountStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      statusGreaterThan(
    MonkAccountStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusLessThan(
    MonkAccountStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusBetween(
    MonkAccountStatus lower,
    MonkAccountStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }
}

extension MonkProfileQueryObject
    on QueryBuilder<MonkProfile, MonkProfile, QFilterCondition> {}

extension MonkProfileQueryLinks
    on QueryBuilder<MonkProfile, MonkProfile, QFilterCondition> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> appUser(
      FilterQuery<AppUser> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'appUser');
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      appUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'appUser', 0, true, 0, true);
    });
  }
}

extension MonkProfileQuerySortBy
    on QueryBuilder<MonkProfile, MonkProfile, QSortBy> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByContactInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByContactInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentBalance', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      sortByCurrentBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentBalance', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByMonkPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      sortByMonkPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByMonkSecondaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkSecondaryId', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      sortByMonkSecondaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkSecondaryId', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByNameOrTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameOrTitle', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByNameOrTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameOrTitle', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension MonkProfileQuerySortThenBy
    on QueryBuilder<MonkProfile, MonkProfile, QSortThenBy> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByContactInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByContactInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentBalance', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      thenByCurrentBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentBalance', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByMonkPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      thenByMonkPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByMonkSecondaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkSecondaryId', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      thenByMonkSecondaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkSecondaryId', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByNameOrTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameOrTitle', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByNameOrTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameOrTitle', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension MonkProfileQueryWhereDistinct
    on QueryBuilder<MonkProfile, MonkProfile, QDistinct> {
  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByContactInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactInfo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByCurrentBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentBalance');
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByMonkPrimaryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monkPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByMonkSecondaryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monkSecondaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByNameOrTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameOrTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension MonkProfileQueryProperty
    on QueryBuilder<MonkProfile, MonkProfile, QQueryProperty> {
  QueryBuilder<MonkProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonkProfile, String?, QQueryOperations> contactInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactInfo');
    });
  }

  QueryBuilder<MonkProfile, int, QQueryOperations> currentBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentBalance');
    });
  }

  QueryBuilder<MonkProfile, String, QQueryOperations> monkPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monkPrimaryId');
    });
  }

  QueryBuilder<MonkProfile, String?, QQueryOperations>
      monkSecondaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monkSecondaryId');
    });
  }

  QueryBuilder<MonkProfile, String?, QQueryOperations> nameOrTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameOrTitle');
    });
  }

  QueryBuilder<MonkProfile, MonkAccountStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
