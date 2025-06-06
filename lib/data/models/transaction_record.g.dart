// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionRecordCollection on Isar {
  IsarCollection<TransactionRecord> get transactionRecords => this.collection();
}

const TransactionRecordSchema = CollectionSchema(
  name: r'TransactionRecord',
  id: 5251947889243599499,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'driverCovered': PropertySchema(
      id: 3,
      name: r'driverCovered',
      type: IsarType.bool,
    ),
    r'driverPrimaryId': PropertySchema(
      id: 4,
      name: r'driverPrimaryId',
      type: IsarType.string,
    ),
    r'monkPrimaryId': PropertySchema(
      id: 5,
      name: r'monkPrimaryId',
      type: IsarType.string,
    ),
    r'processedByUserId': PropertySchema(
      id: 6,
      name: r'processedByUserId',
      type: IsarType.string,
    ),
    r'processedByUserRole': PropertySchema(
      id: 7,
      name: r'processedByUserRole',
      type: IsarType.byte,
      enumMap: _TransactionRecordprocessedByUserRoleEnumValueMap,
    ),
    r'source': PropertySchema(
      id: 8,
      name: r'source',
      type: IsarType.byte,
      enumMap: _TransactionRecordsourceEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _TransactionRecordtypeEnumValueMap,
    )
  },
  estimateSize: _transactionRecordEstimateSize,
  serialize: _transactionRecordSerialize,
  deserialize: _transactionRecordDeserialize,
  deserializeProp: _transactionRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'monkPrimaryId': IndexSchema(
      id: -3863152760536671281,
      name: r'monkPrimaryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'monkPrimaryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'driverPrimaryId': IndexSchema(
      id: 4927258635052209721,
      name: r'driverPrimaryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'driverPrimaryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'dateTime': IndexSchema(
      id: -138851979697481250,
      name: r'dateTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'monk': LinkSchema(
      id: 6979319918827620255,
      name: r'monk',
      target: r'MonkProfile',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transactionRecordGetId,
  getLinks: _transactionRecordGetLinks,
  attach: _transactionRecordAttach,
  version: '3.1.0+1',
);

int _transactionRecordEstimateSize(
  TransactionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.driverPrimaryId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.monkPrimaryId.length * 3;
  {
    final value = object.processedByUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transactionRecordSerialize(
  TransactionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeString(offsets[2], object.description);
  writer.writeBool(offsets[3], object.driverCovered);
  writer.writeString(offsets[4], object.driverPrimaryId);
  writer.writeString(offsets[5], object.monkPrimaryId);
  writer.writeString(offsets[6], object.processedByUserId);
  writer.writeByte(offsets[7], object.processedByUserRole.index);
  writer.writeByte(offsets[8], object.source.index);
  writer.writeByte(offsets[9], object.type.index);
}

TransactionRecord _transactionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionRecord();
  object.amount = reader.readLong(offsets[0]);
  object.dateTime = reader.readDateTime(offsets[1]);
  object.description = reader.readStringOrNull(offsets[2]);
  object.driverCovered = reader.readBool(offsets[3]);
  object.driverPrimaryId = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.monkPrimaryId = reader.readString(offsets[5]);
  object.processedByUserId = reader.readStringOrNull(offsets[6]);
  object.processedByUserRole =
      _TransactionRecordprocessedByUserRoleValueEnumMap[
              reader.readByteOrNull(offsets[7])] ??
          UserRole.treasurer;
  object.source =
      _TransactionRecordsourceValueEnumMap[reader.readByteOrNull(offsets[8])] ??
          TransactionSource.directTreasurer;
  object.type =
      _TransactionRecordtypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
          TransactionType.deposit;
  return object;
}

P _transactionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_TransactionRecordprocessedByUserRoleValueEnumMap[
              reader.readByteOrNull(offset)] ??
          UserRole.treasurer) as P;
    case 8:
      return (_TransactionRecordsourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransactionSource.directTreasurer) as P;
    case 9:
      return (_TransactionRecordtypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransactionType.deposit) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransactionRecordprocessedByUserRoleEnumValueMap = {
  'treasurer': 0,
  'driver': 1,
  'monk': 2,
  'unknown': 3,
};
const _TransactionRecordprocessedByUserRoleValueEnumMap = {
  0: UserRole.treasurer,
  1: UserRole.driver,
  2: UserRole.monk,
  3: UserRole.unknown,
};
const _TransactionRecordsourceEnumValueMap = {
  'directTreasurer': 0,
  'driverCollection': 1,
  'driverWithdrawal': 2,
  'notSpecified': 3,
  'unknown': 4,
};
const _TransactionRecordsourceValueEnumMap = {
  0: TransactionSource.directTreasurer,
  1: TransactionSource.driverCollection,
  2: TransactionSource.driverWithdrawal,
  3: TransactionSource.notSpecified,
  4: TransactionSource.unknown,
};
const _TransactionRecordtypeEnumValueMap = {
  'deposit': 0,
  'withdrawal': 1,
  'unknown': 2,
};
const _TransactionRecordtypeValueEnumMap = {
  0: TransactionType.deposit,
  1: TransactionType.withdrawal,
  2: TransactionType.unknown,
};

Id _transactionRecordGetId(TransactionRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transactionRecordGetLinks(
    TransactionRecord object) {
  return [object.monk];
}

void _transactionRecordAttach(
    IsarCollection<dynamic> col, Id id, TransactionRecord object) {
  object.id = id;
  object.monk.attach(col, col.isar.collection<MonkProfile>(), r'monk', id);
}

extension TransactionRecordQueryWhereSort
    on QueryBuilder<TransactionRecord, TransactionRecord, QWhere> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhere>
      anyDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateTime'),
      );
    });
  }
}

extension TransactionRecordQueryWhere
    on QueryBuilder<TransactionRecord, TransactionRecord, QWhereClause> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      monkPrimaryIdEqualTo(String monkPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monkPrimaryId',
        value: [monkPrimaryId],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      driverPrimaryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'driverPrimaryId',
        value: [null],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      driverPrimaryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'driverPrimaryId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      driverPrimaryIdEqualTo(String? driverPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'driverPrimaryId',
        value: [driverPrimaryId],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      driverPrimaryIdNotEqualTo(String? driverPrimaryId) {
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      dateTimeEqualTo(DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [dateTime],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      dateTimeNotEqualTo(DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [dateTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [],
        upper: [dateTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterWhereClause>
      dateTimeBetween(
    DateTime lowerDateTime,
    DateTime upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [lowerDateTime],
        includeLower: includeLower,
        upper: [upperDateTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionRecordQueryFilter
    on QueryBuilder<TransactionRecord, TransactionRecord, QFilterCondition> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverCoveredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverCovered',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'driverPrimaryId',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'driverPrimaryId',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdEqualTo(
    String? value, {
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdGreaterThan(
    String? value, {
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdLessThan(
    String? value, {
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'driverPrimaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      driverPrimaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
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

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monkPrimaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monkPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monkPrimaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monkPrimaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monkPrimaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monkPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monkPrimaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monkPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'processedByUserId',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'processedByUserId',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'processedByUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'processedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'processedByUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processedByUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'processedByUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserRoleEqualTo(UserRole value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processedByUserRole',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserRoleGreaterThan(
    UserRole value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'processedByUserRole',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserRoleLessThan(
    UserRole value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'processedByUserRole',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      processedByUserRoleBetween(
    UserRole lower,
    UserRole upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'processedByUserRole',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      sourceEqualTo(TransactionSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      sourceGreaterThan(
    TransactionSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      sourceLessThan(
    TransactionSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      sourceBetween(
    TransactionSource lower,
    TransactionSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      typeEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      typeGreaterThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      typeLessThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      typeBetween(
    TransactionType lower,
    TransactionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionRecordQueryObject
    on QueryBuilder<TransactionRecord, TransactionRecord, QFilterCondition> {}

extension TransactionRecordQueryLinks
    on QueryBuilder<TransactionRecord, TransactionRecord, QFilterCondition> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monk(FilterQuery<MonkProfile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'monk');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterFilterCondition>
      monkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'monk', 0, true, 0, true);
    });
  }
}

extension TransactionRecordQuerySortBy
    on QueryBuilder<TransactionRecord, TransactionRecord, QSortBy> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDriverCovered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverCovered', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDriverCoveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverCovered', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByMonkPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByMonkPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByProcessedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByProcessedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByProcessedByUserRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserRole', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByProcessedByUserRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserRole', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TransactionRecordQuerySortThenBy
    on QueryBuilder<TransactionRecord, TransactionRecord, QSortThenBy> {
  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDriverCovered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverCovered', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDriverCoveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverCovered', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByMonkPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByMonkPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monkPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByProcessedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserId', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByProcessedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserId', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByProcessedByUserRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserRole', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByProcessedByUserRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByUserRole', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TransactionRecordQueryWhereDistinct
    on QueryBuilder<TransactionRecord, TransactionRecord, QDistinct> {
  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByDriverCovered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverCovered');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByDriverPrimaryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByMonkPrimaryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monkPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByProcessedByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'processedByUserId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByProcessedByUserRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'processedByUserRole');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source');
    });
  }

  QueryBuilder<TransactionRecord, TransactionRecord, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension TransactionRecordQueryProperty
    on QueryBuilder<TransactionRecord, TransactionRecord, QQueryProperty> {
  QueryBuilder<TransactionRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionRecord, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TransactionRecord, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<TransactionRecord, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<TransactionRecord, bool, QQueryOperations>
      driverCoveredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverCovered');
    });
  }

  QueryBuilder<TransactionRecord, String?, QQueryOperations>
      driverPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverPrimaryId');
    });
  }

  QueryBuilder<TransactionRecord, String, QQueryOperations>
      monkPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monkPrimaryId');
    });
  }

  QueryBuilder<TransactionRecord, String?, QQueryOperations>
      processedByUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'processedByUserId');
    });
  }

  QueryBuilder<TransactionRecord, UserRole, QQueryOperations>
      processedByUserRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'processedByUserRole');
    });
  }

  QueryBuilder<TransactionRecord, TransactionSource, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<TransactionRecord, TransactionType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
