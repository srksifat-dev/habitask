// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'everyday_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEverydayDataCollection on Isar {
  IsarCollection<EverydayData> get everydayDatas => this.collection();
}

const EverydayDataSchema = CollectionSchema(
  name: r'EverydayData',
  id: 148223519511769276,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'percent': PropertySchema(
      id: 1,
      name: r'percent',
      type: IsarType.long,
    )
  },
  estimateSize: _everydayDataEstimateSize,
  serialize: _everydayDataSerialize,
  deserialize: _everydayDataDeserialize,
  deserializeProp: _everydayDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _everydayDataGetId,
  getLinks: _everydayDataGetLinks,
  attach: _everydayDataAttach,
  version: '3.1.0+1',
);

int _everydayDataEstimateSize(
  EverydayData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _everydayDataSerialize(
  EverydayData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeLong(offsets[1], object.percent);
}

EverydayData _everydayDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EverydayData();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.id = id;
  object.percent = reader.readLong(offsets[1]);
  return object;
}

P _everydayDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _everydayDataGetId(EverydayData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _everydayDataGetLinks(EverydayData object) {
  return [];
}

void _everydayDataAttach(
    IsarCollection<dynamic> col, Id id, EverydayData object) {
  object.id = id;
}

extension EverydayDataQueryWhereSort
    on QueryBuilder<EverydayData, EverydayData, QWhere> {
  QueryBuilder<EverydayData, EverydayData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EverydayDataQueryWhere
    on QueryBuilder<EverydayData, EverydayData, QWhereClause> {
  QueryBuilder<EverydayData, EverydayData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<EverydayData, EverydayData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterWhereClause> idBetween(
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
}

extension EverydayDataQueryFilter
    on QueryBuilder<EverydayData, EverydayData, QFilterCondition> {
  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
      percentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percent',
        value: value,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
      percentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percent',
        value: value,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
      percentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percent',
        value: value,
      ));
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterFilterCondition>
      percentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EverydayDataQueryObject
    on QueryBuilder<EverydayData, EverydayData, QFilterCondition> {}

extension EverydayDataQueryLinks
    on QueryBuilder<EverydayData, EverydayData, QFilterCondition> {}

extension EverydayDataQuerySortBy
    on QueryBuilder<EverydayData, EverydayData, QSortBy> {
  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> sortByPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percent', Sort.asc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> sortByPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percent', Sort.desc);
    });
  }
}

extension EverydayDataQuerySortThenBy
    on QueryBuilder<EverydayData, EverydayData, QSortThenBy> {
  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenByPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percent', Sort.asc);
    });
  }

  QueryBuilder<EverydayData, EverydayData, QAfterSortBy> thenByPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percent', Sort.desc);
    });
  }
}

extension EverydayDataQueryWhereDistinct
    on QueryBuilder<EverydayData, EverydayData, QDistinct> {
  QueryBuilder<EverydayData, EverydayData, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<EverydayData, EverydayData, QDistinct> distinctByPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'percent');
    });
  }
}

extension EverydayDataQueryProperty
    on QueryBuilder<EverydayData, EverydayData, QQueryProperty> {
  QueryBuilder<EverydayData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EverydayData, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<EverydayData, int, QQueryOperations> percentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percent');
    });
  }
}
