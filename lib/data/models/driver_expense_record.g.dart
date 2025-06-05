// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_expense_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDriverExpenseRecordCollection on Isar {
  IsarCollection<DriverExpenseRecord> get driverExpenseRecords =>
      this.collection();
}

const DriverExpenseRecordSchema = CollectionSchema(
  name: r'DriverExpenseRecord',
  id: -5313328452110819975,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'details': PropertySchema(
      id: 2,
      name: r'details',
      type: IsarType.string,
    ),
    r'driverPrimaryId': PropertySchema(
      id: 3,
      name: r'driverPrimaryId',
      type: IsarType.string,
    ),
    r'expenseType': PropertySchema(
      id: 4,
      name: r'expenseType',
      type: IsarType.string,
    ),
    r'exportedToTreasurer': PropertySchema(
      id: 5,
      name: r'exportedToTreasurer',
      type: IsarType.bool,
    )
  },
  estimateSize: _driverExpenseRecordEstimateSize,
  serialize: _driverExpenseRecordSerialize,
  deserialize: _driverExpenseRecordDeserialize,
  deserializeProp: _driverExpenseRecordDeserializeProp,
  idName: r'id',
  indexes: {
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _driverExpenseRecordGetId,
  getLinks: _driverExpenseRecordGetLinks,
  attach: _driverExpenseRecordAttach,
  version: '3.1.0+1',
);

int _driverExpenseRecordEstimateSize(
  DriverExpenseRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.details;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.driverPrimaryId.length * 3;
  bytesCount += 3 + object.expenseType.length * 3;
  return bytesCount;
}

void _driverExpenseRecordSerialize(
  DriverExpenseRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.details);
  writer.writeString(offsets[3], object.driverPrimaryId);
  writer.writeString(offsets[4], object.expenseType);
  writer.writeBool(offsets[5], object.exportedToTreasurer);
}

DriverExpenseRecord _driverExpenseRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DriverExpenseRecord();
  object.amount = reader.readLong(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.details = reader.readStringOrNull(offsets[2]);
  object.driverPrimaryId = reader.readString(offsets[3]);
  object.expenseType = reader.readString(offsets[4]);
  object.exportedToTreasurer = reader.readBool(offsets[5]);
  object.id = id;
  return object;
}

P _driverExpenseRecordDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _driverExpenseRecordGetId(DriverExpenseRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _driverExpenseRecordGetLinks(
    DriverExpenseRecord object) {
  return [];
}

void _driverExpenseRecordAttach(
    IsarCollection<dynamic> col, Id id, DriverExpenseRecord object) {
  object.id = id;
}

extension DriverExpenseRecordQueryWhereSort
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QWhere> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DriverExpenseRecordQueryWhere
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QWhereClause> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
      driverPrimaryIdEqualTo(String driverPrimaryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'driverPrimaryId',
        value: [driverPrimaryId],
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterWhereClause>
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

extension DriverExpenseRecordQueryFilter on QueryBuilder<DriverExpenseRecord,
    DriverExpenseRecord, QFilterCondition> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'details',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'details',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'details',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'details',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'details',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'details',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      detailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'details',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      driverPrimaryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'driverPrimaryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      driverPrimaryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'driverPrimaryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      driverPrimaryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      driverPrimaryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'driverPrimaryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expenseType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expenseType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expenseType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenseType',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      expenseTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expenseType',
        value: '',
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      exportedToTreasurerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportedToTreasurer',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterFilterCondition>
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
}

extension DriverExpenseRecordQueryObject on QueryBuilder<DriverExpenseRecord,
    DriverExpenseRecord, QFilterCondition> {}

extension DriverExpenseRecordQueryLinks on QueryBuilder<DriverExpenseRecord,
    DriverExpenseRecord, QFilterCondition> {}

extension DriverExpenseRecordQuerySortBy
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QSortBy> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByExpenseType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseType', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByExpenseTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseType', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByExportedToTreasurer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedToTreasurer', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      sortByExportedToTreasurerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedToTreasurer', Sort.desc);
    });
  }
}

extension DriverExpenseRecordQuerySortThenBy
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QSortThenBy> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'details', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDriverPrimaryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByDriverPrimaryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverPrimaryId', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByExpenseType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseType', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByExpenseTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseType', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByExportedToTreasurer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedToTreasurer', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByExportedToTreasurerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedToTreasurer', Sort.desc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DriverExpenseRecordQueryWhereDistinct
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct> {
  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByDetails({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'details', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByDriverPrimaryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverPrimaryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByExpenseType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expenseType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QDistinct>
      distinctByExportedToTreasurer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportedToTreasurer');
    });
  }
}

extension DriverExpenseRecordQueryProperty
    on QueryBuilder<DriverExpenseRecord, DriverExpenseRecord, QQueryProperty> {
  QueryBuilder<DriverExpenseRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DriverExpenseRecord, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<DriverExpenseRecord, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DriverExpenseRecord, String?, QQueryOperations>
      detailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'details');
    });
  }

  QueryBuilder<DriverExpenseRecord, String, QQueryOperations>
      driverPrimaryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverPrimaryId');
    });
  }

  QueryBuilder<DriverExpenseRecord, String, QQueryOperations>
      expenseTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenseType');
    });
  }

  QueryBuilder<DriverExpenseRecord, bool, QQueryOperations>
      exportedToTreasurerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportedToTreasurer');
    });
  }
}
