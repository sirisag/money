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
    r'lastUpdatedAt': PropertySchema(
      id: 2,
      name: r'lastUpdatedAt',
      type: IsarType.dateTime,
    ),
    r'monkName': PropertySchema(
      id: 3,
      name: r'monkName',
      type: IsarType.string,
    ),
    r'monkPrimaryId': PropertySchema(
      id: 4,
      name: r'monkPrimaryId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.byte,
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
    )
  },
  links: {
    r'transactions': LinkSchema(
      id: 6707115295059319580,
      name: r'transactions',
      target: r'TransactionRecord',
      single: false,
      linkName: r'monk',
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
  {
    final value = object.monkName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.monkPrimaryId.length * 3;
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
  writer.writeDateTime(offsets[2], object.lastUpdatedAt);
  writer.writeString(offsets[3], object.monkName);
  writer.writeString(offsets[4], object.monkPrimaryId);
  writer.writeByte(offsets[5], object.status.index);
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
  object.lastUpdatedAt = reader.readDateTimeOrNull(offsets[2]);
  object.monkName = reader.readStringOrNull(offsets[3]);
  object.monkPrimaryId = reader.readString(offsets[4]);
  object.status =
      _MonkProfilestatusValueEnumMap[reader.readByteOrNull(offsets[5])] ??
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (_MonkProfilestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          MonkAccountStatus.active) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MonkProfilestatusEnumValueMap = {
  'active': 0,
  'moved': 1,
  'resigned': 2,
};
const _MonkProfilestatusValueEnumMap = {
  0: MonkAccountStatus.active,
  1: MonkAccountStatus.moved,
  2: MonkAccountStatus.resigned,
};

Id _monkProfileGetId(MonkProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monkProfileGetLinks(MonkProfile object) {
  return [object.transactions];
}

void _monkProfileAttach(
    IsarCollection<dynamic> col, Id id, MonkProfile object) {
  object.id = id;
  object.transactions.attach(
      col, col.isar.collection<TransactionRecord>(), r'transactions', id);
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
      lastUpdatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      lastUpdatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdatedAt',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      lastUpdatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      lastUpdatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      lastUpdatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      lastUpdatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'monkName',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'monkName',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> monkNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> monkNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monkName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monkName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> monkNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monkName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkName',
        value: '',
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      monkNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monkName',
        value: '',
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusEqualTo(
      MonkAccountStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      statusGreaterThan(
    MonkAccountStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusLessThan(
    MonkAccountStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> statusBetween(
    MonkAccountStatus lower,
    MonkAccountStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonkProfileQueryObject
    on QueryBuilder<MonkProfile, MonkProfile, QFilterCondition> {}

extension MonkProfileQueryLinks
    on QueryBuilder<MonkProfile, MonkProfile, QFilterCondition> {
  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition> transactions(
      FilterQuery<TransactionRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transactions');
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', length, true, length, true);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, true, 0, true);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, false, 999999, true);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, true, length, include);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', length, include, 999999, true);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterFilterCondition>
      transactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'transactions', lower, includeLower, upper, includeUpper);
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      sortByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByMonkName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkName', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> sortByMonkNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkName', Sort.desc);
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

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy>
      thenByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByMonkName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkName', Sort.asc);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QAfterSortBy> thenByMonkNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkName', Sort.desc);
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

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedAt');
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByMonkName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monkName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByMonkPrimaryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monkPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonkProfile, MonkProfile, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
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

  QueryBuilder<MonkProfile, DateTime?, QQueryOperations>
      lastUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedAt');
    });
  }

  QueryBuilder<MonkProfile, String?, QQueryOperations> monkNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monkName');
    });
  }

  QueryBuilder<MonkProfile, String, QQueryOperations> monkPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monkPrimaryId');
    });
  }

  QueryBuilder<MonkProfile, MonkAccountStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
