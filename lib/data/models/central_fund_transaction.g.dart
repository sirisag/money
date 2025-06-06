// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'central_fund_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCentralFundTransactionCollection on Isar {
  IsarCollection<CentralFundTransaction> get centralFundTransactions =>
      this.collection();
}

const CentralFundTransactionSchema = CollectionSchema(
  name: r'CentralFundTransaction',
  id: -8058024423741992874,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'balanceAfter': PropertySchema(
      id: 1,
      name: r'balanceAfter',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 2,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'processedByTreasurerId': PropertySchema(
      id: 4,
      name: r'processedByTreasurerId',
      type: IsarType.string,
    ),
    r'relatedDriverId': PropertySchema(
      id: 5,
      name: r'relatedDriverId',
      type: IsarType.string,
    ),
    r'relatedMonkId': PropertySchema(
      id: 6,
      name: r'relatedMonkId',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.byte,
      enumMap: _CentralFundTransactiontypeEnumValueMap,
    )
  },
  estimateSize: _centralFundTransactionEstimateSize,
  serialize: _centralFundTransactionSerialize,
  deserialize: _centralFundTransactionDeserialize,
  deserializeProp: _centralFundTransactionDeserializeProp,
  idName: r'id',
  indexes: {
    r'relatedDriverId': IndexSchema(
      id: 1465225861294152687,
      name: r'relatedDriverId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'relatedDriverId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _centralFundTransactionGetId,
  getLinks: _centralFundTransactionGetLinks,
  attach: _centralFundTransactionAttach,
  version: '3.1.0+1',
);

int _centralFundTransactionEstimateSize(
  CentralFundTransaction object,
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
  bytesCount += 3 + object.processedByTreasurerId.length * 3;
  {
    final value = object.relatedDriverId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.relatedMonkId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _centralFundTransactionSerialize(
  CentralFundTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeLong(offsets[1], object.balanceAfter);
  writer.writeDateTime(offsets[2], object.dateTime);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.processedByTreasurerId);
  writer.writeString(offsets[5], object.relatedDriverId);
  writer.writeString(offsets[6], object.relatedMonkId);
  writer.writeByte(offsets[7], object.type.index);
}

CentralFundTransaction _centralFundTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CentralFundTransaction();
  object.amount = reader.readLong(offsets[0]);
  object.balanceAfter = reader.readLongOrNull(offsets[1]);
  object.dateTime = reader.readDateTime(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.processedByTreasurerId = reader.readString(offsets[4]);
  object.relatedDriverId = reader.readStringOrNull(offsets[5]);
  object.relatedMonkId = reader.readStringOrNull(offsets[6]);
  object.type = _CentralFundTransactiontypeValueEnumMap[
          reader.readByteOrNull(offsets[7])] ??
      CentralFundTransactionType.donation;
  return object;
}

P _centralFundTransactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_CentralFundTransactiontypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          CentralFundTransactionType.donation) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CentralFundTransactiontypeEnumValueMap = {
  'donation': 0,
  'templeExpense': 1,
  'issueDriverAdvance': 2,
  'receiveDriverAdvanceReturn': 3,
  'reimburseDriverForExpense': 4,
  'unknown': 5,
};
const _CentralFundTransactiontypeValueEnumMap = {
  0: CentralFundTransactionType.donation,
  1: CentralFundTransactionType.templeExpense,
  2: CentralFundTransactionType.issueDriverAdvance,
  3: CentralFundTransactionType.receiveDriverAdvanceReturn,
  4: CentralFundTransactionType.reimburseDriverForExpense,
  5: CentralFundTransactionType.unknown,
};

Id _centralFundTransactionGetId(CentralFundTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _centralFundTransactionGetLinks(
    CentralFundTransaction object) {
  return [];
}

void _centralFundTransactionAttach(
    IsarCollection<dynamic> col, Id id, CentralFundTransaction object) {
  object.id = id;
}

extension CentralFundTransactionQueryWhereSort
    on QueryBuilder<CentralFundTransaction, CentralFundTransaction, QWhere> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CentralFundTransactionQueryWhere on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QWhereClause> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> relatedDriverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relatedDriverId',
        value: [null],
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> relatedDriverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relatedDriverId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> relatedDriverIdEqualTo(String? relatedDriverId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relatedDriverId',
        value: [relatedDriverId],
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterWhereClause> relatedDriverIdNotEqualTo(String? relatedDriverId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedDriverId',
              lower: [],
              upper: [relatedDriverId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedDriverId',
              lower: [relatedDriverId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedDriverId',
              lower: [relatedDriverId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedDriverId',
              lower: [],
              upper: [relatedDriverId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CentralFundTransactionQueryFilter on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QFilterCondition> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> amountGreaterThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> amountLessThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> amountBetween(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'balanceAfter',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'balanceAfter',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balanceAfter',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balanceAfter',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balanceAfter',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> balanceAfterBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balanceAfter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> dateTimeGreaterThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> dateTimeLessThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> dateTimeBetween(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionGreaterThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'processedByTreasurerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      processedByTreasurerIdContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'processedByTreasurerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      processedByTreasurerIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'processedByTreasurerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'processedByTreasurerId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> processedByTreasurerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'processedByTreasurerId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedDriverId',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedDriverId',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedDriverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      relatedDriverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedDriverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      relatedDriverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedDriverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedDriverId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedDriverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedDriverId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedMonkId',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedMonkId',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedMonkId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      relatedMonkIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedMonkId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
          QAfterFilterCondition>
      relatedMonkIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedMonkId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedMonkId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> relatedMonkIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedMonkId',
        value: '',
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> typeEqualTo(CentralFundTransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> typeGreaterThan(
    CentralFundTransactionType value, {
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> typeLessThan(
    CentralFundTransactionType value, {
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

  QueryBuilder<CentralFundTransaction, CentralFundTransaction,
      QAfterFilterCondition> typeBetween(
    CentralFundTransactionType lower,
    CentralFundTransactionType upper, {
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

extension CentralFundTransactionQueryObject on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QFilterCondition> {}

extension CentralFundTransactionQueryLinks on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QFilterCondition> {}

extension CentralFundTransactionQuerySortBy
    on QueryBuilder<CentralFundTransaction, CentralFundTransaction, QSortBy> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByBalanceAfter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceAfter', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByBalanceAfterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceAfter', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByProcessedByTreasurerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByTreasurerId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByProcessedByTreasurerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByTreasurerId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByRelatedDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedDriverId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByRelatedDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedDriverId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByRelatedMonkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedMonkId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByRelatedMonkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedMonkId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CentralFundTransactionQuerySortThenBy on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QSortThenBy> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByBalanceAfter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceAfter', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByBalanceAfterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceAfter', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByProcessedByTreasurerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByTreasurerId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByProcessedByTreasurerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'processedByTreasurerId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByRelatedDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedDriverId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByRelatedDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedDriverId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByRelatedMonkId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedMonkId', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByRelatedMonkIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedMonkId', Sort.desc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CentralFundTransactionQueryWhereDistinct
    on QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct> {
  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByBalanceAfter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balanceAfter');
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByProcessedByTreasurerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'processedByTreasurerId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByRelatedDriverId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedDriverId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByRelatedMonkId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedMonkId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransaction, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension CentralFundTransactionQueryProperty on QueryBuilder<
    CentralFundTransaction, CentralFundTransaction, QQueryProperty> {
  QueryBuilder<CentralFundTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CentralFundTransaction, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<CentralFundTransaction, int?, QQueryOperations>
      balanceAfterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balanceAfter');
    });
  }

  QueryBuilder<CentralFundTransaction, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<CentralFundTransaction, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CentralFundTransaction, String, QQueryOperations>
      processedByTreasurerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'processedByTreasurerId');
    });
  }

  QueryBuilder<CentralFundTransaction, String?, QQueryOperations>
      relatedDriverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedDriverId');
    });
  }

  QueryBuilder<CentralFundTransaction, String?, QQueryOperations>
      relatedMonkIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedMonkId');
    });
  }

  QueryBuilder<CentralFundTransaction, CentralFundTransactionType,
      QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
