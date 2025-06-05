// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppUserCollection on Isar {
  IsarCollection<AppUser> get appUsers => this.collection();
}

const AppUserSchema = CollectionSchema(
  name: r'AppUser',
  id: 2120223346807520010,
  properties: {
    r'displayName': PropertySchema(
      id: 0,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'hashedPassword': PropertySchema(
      id: 1,
      name: r'hashedPassword',
      type: IsarType.string,
    ),
    r'primaryId': PropertySchema(
      id: 2,
      name: r'primaryId',
      type: IsarType.string,
    ),
    r'role': PropertySchema(
      id: 3,
      name: r'role',
      type: IsarType.byte,
      enumMap: _AppUserroleEnumValueMap,
    ),
    r'secondaryId': PropertySchema(
      id: 4,
      name: r'secondaryId',
      type: IsarType.string,
    )
  },
  estimateSize: _appUserEstimateSize,
  serialize: _appUserSerialize,
  deserialize: _appUserDeserialize,
  deserializeProp: _appUserDeserializeProp,
  idName: r'id',
  indexes: {
    r'primaryId': IndexSchema(
      id: -437909748968792282,
      name: r'primaryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'primaryId',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'secondaryId': IndexSchema(
      id: -5675229144349810013,
      name: r'secondaryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'secondaryId',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _appUserGetId,
  getLinks: _appUserGetLinks,
  attach: _appUserAttach,
  version: '3.1.0+1',
);

int _appUserEstimateSize(
  AppUser object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.hashedPassword;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.primaryId.length * 3;
  bytesCount += 3 + object.secondaryId.length * 3;
  return bytesCount;
}

void _appUserSerialize(
  AppUser object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayName);
  writer.writeString(offsets[1], object.hashedPassword);
  writer.writeString(offsets[2], object.primaryId);
  writer.writeByte(offsets[3], object.role.index);
  writer.writeString(offsets[4], object.secondaryId);
}

AppUser _appUserDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppUser();
  object.displayName = reader.readStringOrNull(offsets[0]);
  object.hashedPassword = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.primaryId = reader.readString(offsets[2]);
  object.role = _AppUserroleValueEnumMap[reader.readByteOrNull(offsets[3])] ??
      UserRole.treasurer;
  object.secondaryId = reader.readString(offsets[4]);
  return object;
}

P _appUserDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (_AppUserroleValueEnumMap[reader.readByteOrNull(offset)] ??
          UserRole.treasurer) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppUserroleEnumValueMap = {
  'treasurer': 0,
  'driver': 1,
  'monk': 2,
  'unknown': 3,
};
const _AppUserroleValueEnumMap = {
  0: UserRole.treasurer,
  1: UserRole.driver,
  2: UserRole.monk,
  3: UserRole.unknown,
};

Id _appUserGetId(AppUser object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appUserGetLinks(AppUser object) {
  return [];
}

void _appUserAttach(IsarCollection<dynamic> col, Id id, AppUser object) {
  object.id = id;
}

extension AppUserByIndex on IsarCollection<AppUser> {
  Future<AppUser?> getByPrimaryId(String primaryId) {
    return getByIndex(r'primaryId', [primaryId]);
  }

  AppUser? getByPrimaryIdSync(String primaryId) {
    return getByIndexSync(r'primaryId', [primaryId]);
  }

  Future<bool> deleteByPrimaryId(String primaryId) {
    return deleteByIndex(r'primaryId', [primaryId]);
  }

  bool deleteByPrimaryIdSync(String primaryId) {
    return deleteByIndexSync(r'primaryId', [primaryId]);
  }

  Future<List<AppUser?>> getAllByPrimaryId(List<String> primaryIdValues) {
    final values = primaryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'primaryId', values);
  }

  List<AppUser?> getAllByPrimaryIdSync(List<String> primaryIdValues) {
    final values = primaryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'primaryId', values);
  }

  Future<int> deleteAllByPrimaryId(List<String> primaryIdValues) {
    final values = primaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'primaryId', values);
  }

  int deleteAllByPrimaryIdSync(List<String> primaryIdValues) {
    final values = primaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'primaryId', values);
  }

  Future<Id> putByPrimaryId(AppUser object) {
    return putByIndex(r'primaryId', object);
  }

  Id putByPrimaryIdSync(AppUser object, {bool saveLinks = true}) {
    return putByIndexSync(r'primaryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPrimaryId(List<AppUser> objects) {
    return putAllByIndex(r'primaryId', objects);
  }

  List<Id> putAllByPrimaryIdSync(List<AppUser> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'primaryId', objects, saveLinks: saveLinks);
  }

  Future<AppUser?> getBySecondaryId(String secondaryId) {
    return getByIndex(r'secondaryId', [secondaryId]);
  }

  AppUser? getBySecondaryIdSync(String secondaryId) {
    return getByIndexSync(r'secondaryId', [secondaryId]);
  }

  Future<bool> deleteBySecondaryId(String secondaryId) {
    return deleteByIndex(r'secondaryId', [secondaryId]);
  }

  bool deleteBySecondaryIdSync(String secondaryId) {
    return deleteByIndexSync(r'secondaryId', [secondaryId]);
  }

  Future<List<AppUser?>> getAllBySecondaryId(List<String> secondaryIdValues) {
    final values = secondaryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'secondaryId', values);
  }

  List<AppUser?> getAllBySecondaryIdSync(List<String> secondaryIdValues) {
    final values = secondaryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'secondaryId', values);
  }

  Future<int> deleteAllBySecondaryId(List<String> secondaryIdValues) {
    final values = secondaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'secondaryId', values);
  }

  int deleteAllBySecondaryIdSync(List<String> secondaryIdValues) {
    final values = secondaryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'secondaryId', values);
  }

  Future<Id> putBySecondaryId(AppUser object) {
    return putByIndex(r'secondaryId', object);
  }

  Id putBySecondaryIdSync(AppUser object, {bool saveLinks = true}) {
    return putByIndexSync(r'secondaryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySecondaryId(List<AppUser> objects) {
    return putAllByIndex(r'secondaryId', objects);
  }

  List<Id> putAllBySecondaryIdSync(List<AppUser> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'secondaryId', objects, saveLinks: saveLinks);
  }
}

extension AppUserQueryWhereSort on QueryBuilder<AppUser, AppUser, QWhere> {
  QueryBuilder<AppUser, AppUser, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppUserQueryWhere on QueryBuilder<AppUser, AppUser, QWhereClause> {
  QueryBuilder<AppUser, AppUser, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> idBetween(
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

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> primaryIdEqualTo(
      String primaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'primaryId',
        value: [primaryId],
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> primaryIdNotEqualTo(
      String primaryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryId',
              lower: [],
              upper: [primaryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryId',
              lower: [primaryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryId',
              lower: [primaryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryId',
              lower: [],
              upper: [primaryId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> secondaryIdEqualTo(
      String secondaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'secondaryId',
        value: [secondaryId],
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterWhereClause> secondaryIdNotEqualTo(
      String secondaryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'secondaryId',
              lower: [],
              upper: [secondaryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'secondaryId',
              lower: [secondaryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'secondaryId',
              lower: [secondaryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'secondaryId',
              lower: [],
              upper: [secondaryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AppUserQueryFilter
    on QueryBuilder<AppUser, AppUser, QFilterCondition> {
  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameEqualTo(
    String? value, {
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameGreaterThan(
    String? value, {
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameLessThan(
    String? value, {
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameStartsWith(
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameEndsWith(
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hashedPassword',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      hashedPasswordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hashedPassword',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      hashedPasswordGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashedPassword',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      hashedPasswordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hashedPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> hashedPasswordMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hashedPassword',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      hashedPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashedPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      hashedPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hashedPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> primaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> roleEqualTo(
      UserRole value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> roleGreaterThan(
    UserRole value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> roleLessThan(
    UserRole value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> roleBetween(
    UserRole lower,
    UserRole upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secondaryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'secondaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'secondaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition> secondaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secondaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterFilterCondition>
      secondaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'secondaryId',
        value: '',
      ));
    });
  }
}

extension AppUserQueryObject
    on QueryBuilder<AppUser, AppUser, QFilterCondition> {}

extension AppUserQueryLinks
    on QueryBuilder<AppUser, AppUser, QFilterCondition> {}

extension AppUserQuerySortBy on QueryBuilder<AppUser, AppUser, QSortBy> {
  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByHashedPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashedPassword', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByHashedPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashedPassword', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryId', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryId', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortBySecondaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryId', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> sortBySecondaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryId', Sort.desc);
    });
  }
}

extension AppUserQuerySortThenBy
    on QueryBuilder<AppUser, AppUser, QSortThenBy> {
  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByHashedPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashedPassword', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByHashedPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashedPassword', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryId', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryId', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenBySecondaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryId', Sort.asc);
    });
  }

  QueryBuilder<AppUser, AppUser, QAfterSortBy> thenBySecondaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryId', Sort.desc);
    });
  }
}

extension AppUserQueryWhereDistinct
    on QueryBuilder<AppUser, AppUser, QDistinct> {
  QueryBuilder<AppUser, AppUser, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppUser, AppUser, QDistinct> distinctByHashedPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashedPassword',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppUser, AppUser, QDistinct> distinctByPrimaryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppUser, AppUser, QDistinct> distinctByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role');
    });
  }

  QueryBuilder<AppUser, AppUser, QDistinct> distinctBySecondaryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryId', caseSensitive: caseSensitive);
    });
  }
}

extension AppUserQueryProperty
    on QueryBuilder<AppUser, AppUser, QQueryProperty> {
  QueryBuilder<AppUser, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppUser, String?, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<AppUser, String?, QQueryOperations> hashedPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashedPassword');
    });
  }

  QueryBuilder<AppUser, String, QQueryOperations> primaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryId');
    });
  }

  QueryBuilder<AppUser, UserRole, QQueryOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<AppUser, String, QQueryOperations> secondaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryId');
    });
  }
}
