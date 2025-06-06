// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDriverProfileCollection on Isar {
  IsarCollection<DriverProfile> get driverProfiles => this.collection();
}

const DriverProfileSchema = CollectionSchema(
  name: r'DriverProfile',
  id: -960497836012530099,
  properties: {
    r'contactInfo': PropertySchema(
      id: 0,
      name: r'contactInfo',
      type: IsarType.string,
    ),
    r'driverPrimaryId': PropertySchema(
      id: 1,
      name: r'driverPrimaryId',
      type: IsarType.string,
    ),
    r'lastTravelAdvanceUpdateAt': PropertySchema(
      id: 2,
      name: r'lastTravelAdvanceUpdateAt',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'travelAdvanceBalance': PropertySchema(
      id: 4,
      name: r'travelAdvanceBalance',
      type: IsarType.long,
    )
  },
  estimateSize: _driverProfileEstimateSize,
  serialize: _driverProfileSerialize,
  deserialize: _driverProfileDeserialize,
  deserializeProp: _driverProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'driverPrimaryId': IndexSchema(
      id: 4927258635052209721,
      name: r'driverPrimaryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'driverPrimaryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'appUser': LinkSchema(
      id: 6088598441456186751,
      name: r'appUser',
      target: r'AppUser',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _driverProfileGetId,
  getLinks: _driverProfileGetLinks,
  attach: _driverProfileAttach,
  version: '3.1.0+1',
);

int _driverProfileEstimateSize(
  DriverProfile object,
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
  bytesCount += 3 + object.driverPrimaryId.length * 3;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _driverProfileSerialize(
  DriverProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contactInfo);
  writer.writeString(offsets[1], object.driverPrimaryId);
  writer.writeDateTime(offsets[2], object.lastTravelAdvanceUpdateAt);
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.travelAdvanceBalance);
}

DriverProfile _driverProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DriverProfile();
  object.contactInfo = reader.readStringOrNull(offsets[0]);
  object.driverPrimaryId = reader.readString(offsets[1]);
  object.id = id;
  object.lastTravelAdvanceUpdateAt = reader.readDateTimeOrNull(offsets[2]);
  object.name = reader.readStringOrNull(offsets[3]);
  object.travelAdvanceBalance = reader.readLong(offsets[4]);
  return object;
}

P _driverProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _driverProfileGetId(DriverProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _driverProfileGetLinks(DriverProfile object) {
  return [object.appUser];
}

void _driverProfileAttach(
    IsarCollection<dynamic> col, Id id, DriverProfile object) {
  object.id = id;
  object.appUser.attach(col, col.isar.collection<AppUser>(), r'appUser', id);
}

extension DriverProfileByIndex on IsarCollection<DriverProfile> {
  Future<DriverProfile?> getByDriverPrimaryId(String driverPrimaryId) {
    return getByIndex(r'driverPrimaryId', [driverPrimaryId]);
  }

  DriverProfile? getByDriverPrimaryIdSync(String driverPrimaryId) {
    return getByIndexSync(r'driverPrimaryId', [driverPrimaryId]);
  }

  Future<bool> deleteByDriverPrimaryId(String driverPrimaryId) {
    return deleteByIndex(r'driverPrimaryId', [driverPrimaryId]);
  }

  bool deleteByDriverPrimaryIdSync(String driverPrimaryId) {
    return deleteByIndexSync(r'driverPrimaryId', [driverPrimaryId]);
  }

  Future<List<DriverProfile?>> getAllByDriverPrimaryId(
      List<String> driverPrimaryIdValues) {
    final values = driverPrimaryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'driverPrimaryId', values);
  }

  List<DriverProfile?> getAllByDriverPrimaryIdSync(
      List<String> driverPrimaryIdValues) {
    final values = driverPrimaryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'driverPrimaryId', values);
  }

  Future<int> deleteAllByDriverPrimaryId(List<String> driverPrimaryIdValues) {
    final values = driverPrimaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'driverPrimaryId', values);
  }

  int deleteAllByDriverPrimaryIdSync(List<String> driverPrimaryIdValues) {
    final values = driverPrimaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'driverPrimaryId', values);
  }

  Future<Id> putByDriverPrimaryId(DriverProfile object) {
    return putByIndex(r'driverPrimaryId', object);
  }

  Id putByDriverPrimaryIdSync(DriverProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'driverPrimaryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDriverPrimaryId(List<DriverProfile> objects) {
    return putAllByIndex(r'driverPrimaryId', objects);
  }

  List<Id> putAllByDriverPrimaryIdSync(List<DriverProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'driverPrimaryId', objects, saveLinks: saveLinks);
  }
}

extension DriverProfileQueryWhereSort
    on QueryBuilder<DriverProfile, DriverProfile, QWhere> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DriverProfileQueryWhere
    on QueryBuilder<DriverProfile, DriverProfile, QWhereClause> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause> idBetween(
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause>
      driverPrimaryIdEqualTo(String driverPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'driverPrimaryId',
        value: [driverPrimaryId],
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterWhereClause>
      driverPrimaryIdNotEqualTo(String driverPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'driverPrimaryId',
              lower: [],
              upper: [driverPrimaryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'driverPrimaryId',
              lower: [driverPrimaryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'driverPrimaryId',
              lower: [driverPrimaryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'driverPrimaryId',
              lower: [],
              upper: [driverPrimaryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DriverProfileQueryFilter
    on QueryBuilder<DriverProfile, DriverProfile, QFilterCondition> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contactInfo',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contactInfo',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      contactInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'driverPrimaryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'driverPrimaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      driverPrimaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTravelAdvanceUpdateAt',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTravelAdvanceUpdateAt',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTravelAdvanceUpdateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTravelAdvanceUpdateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTravelAdvanceUpdateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      lastTravelAdvanceUpdateAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTravelAdvanceUpdateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      travelAdvanceBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'travelAdvanceBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      travelAdvanceBalanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'travelAdvanceBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      travelAdvanceBalanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'travelAdvanceBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      travelAdvanceBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'travelAdvanceBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DriverProfileQueryObject
    on QueryBuilder<DriverProfile, DriverProfile, QFilterCondition> {}

extension DriverProfileQueryLinks
    on QueryBuilder<DriverProfile, DriverProfile, QFilterCondition> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition> appUser(
      FilterQuery<AppUser> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'appUser');
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterFilterCondition>
      appUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'appUser', 0, true, 0, true);
    });
  }
}

extension DriverProfileQuerySortBy
    on QueryBuilder<DriverProfile, DriverProfile, QSortBy> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> sortByContactInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByContactInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByLastTravelAdvanceUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTravelAdvanceUpdateAt', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByLastTravelAdvanceUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTravelAdvanceUpdateAt', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByTravelAdvanceBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'travelAdvanceBalance', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      sortByTravelAdvanceBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'travelAdvanceBalance', Sort.desc);
    });
  }
}

extension DriverProfileQuerySortThenBy
    on QueryBuilder<DriverProfile, DriverProfile, QSortThenBy> {
  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> thenByContactInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByContactInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactInfo', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByLastTravelAdvanceUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTravelAdvanceUpdateAt', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByLastTravelAdvanceUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTravelAdvanceUpdateAt', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByTravelAdvanceBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'travelAdvanceBalance', Sort.asc);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QAfterSortBy>
      thenByTravelAdvanceBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'travelAdvanceBalance', Sort.desc);
    });
  }
}

extension DriverProfileQueryWhereDistinct
    on QueryBuilder<DriverProfile, DriverProfile, QDistinct> {
  QueryBuilder<DriverProfile, DriverProfile, QDistinct> distinctByContactInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactInfo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QDistinct>
      distinctByDriverPrimaryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QDistinct>
      distinctByLastTravelAdvanceUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTravelAdvanceUpdateAt');
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverProfile, DriverProfile, QDistinct>
      distinctByTravelAdvanceBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'travelAdvanceBalance');
    });
  }
}

extension DriverProfileQueryProperty
    on QueryBuilder<DriverProfile, DriverProfile, QQueryProperty> {
  QueryBuilder<DriverProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DriverProfile, String?, QQueryOperations> contactInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactInfo');
    });
  }

  QueryBuilder<DriverProfile, String, QQueryOperations>
      driverPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverPrimaryId');
    });
  }

  QueryBuilder<DriverProfile, DateTime?, QQueryOperations>
      lastTravelAdvanceUpdateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTravelAdvanceUpdateAt');
    });
  }

  QueryBuilder<DriverProfile, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DriverProfile, int, QQueryOperations>
      travelAdvanceBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'travelAdvanceBalance');
    });
  }
}
