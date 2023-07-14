// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskDataCollection on Isar {
  IsarCollection<TaskData> get taskDatas => this.collection();
}

const TaskDataSchema = CollectionSchema(
  name: r'TaskData',
  id: 6386124436821998370,
  properties: {
    r'completedPercentage': PropertySchema(
      id: 0,
      name: r'completedPercentage',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _taskDataEstimateSize,
  serialize: _taskDataSerialize,
  deserialize: _taskDataDeserialize,
  deserializeProp: _taskDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _taskDataGetId,
  getLinks: _taskDataGetLinks,
  attach: _taskDataAttach,
  version: '3.1.0+1',
);

int _taskDataEstimateSize(
  TaskData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _taskDataSerialize(
  TaskData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedPercentage);
  writer.writeDateTime(offsets[1], object.date);
}

TaskData _taskDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskData();
  object.completedPercentage = reader.readLong(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _taskDataDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskDataGetId(TaskData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskDataGetLinks(TaskData object) {
  return [];
}

void _taskDataAttach(IsarCollection<dynamic> col, Id id, TaskData object) {
  object.id = id;
}

extension TaskDataQueryWhereSort on QueryBuilder<TaskData, TaskData, QWhere> {
  QueryBuilder<TaskData, TaskData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TaskDataQueryWhere on QueryBuilder<TaskData, TaskData, QWhereClause> {
  QueryBuilder<TaskData, TaskData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TaskData, TaskData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterWhereClause> idBetween(
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

extension TaskDataQueryFilter
    on QueryBuilder<TaskData, TaskData, QFilterCondition> {
  QueryBuilder<TaskData, TaskData, QAfterFilterCondition>
      completedPercentageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition>
      completedPercentageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition>
      completedPercentageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition>
      completedPercentageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TaskData, TaskData, QAfterFilterCondition> idBetween(
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

extension TaskDataQueryObject
    on QueryBuilder<TaskData, TaskData, QFilterCondition> {}

extension TaskDataQueryLinks
    on QueryBuilder<TaskData, TaskData, QFilterCondition> {}

extension TaskDataQuerySortBy on QueryBuilder<TaskData, TaskData, QSortBy> {
  QueryBuilder<TaskData, TaskData, QAfterSortBy> sortByCompletedPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPercentage', Sort.asc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy>
      sortByCompletedPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPercentage', Sort.desc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }
}

extension TaskDataQuerySortThenBy
    on QueryBuilder<TaskData, TaskData, QSortThenBy> {
  QueryBuilder<TaskData, TaskData, QAfterSortBy> thenByCompletedPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPercentage', Sort.asc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy>
      thenByCompletedPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPercentage', Sort.desc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskData, TaskData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension TaskDataQueryWhereDistinct
    on QueryBuilder<TaskData, TaskData, QDistinct> {
  QueryBuilder<TaskData, TaskData, QDistinct> distinctByCompletedPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedPercentage');
    });
  }

  QueryBuilder<TaskData, TaskData, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }
}

extension TaskDataQueryProperty
    on QueryBuilder<TaskData, TaskData, QQueryProperty> {
  QueryBuilder<TaskData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskData, int, QQueryOperations> completedPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedPercentage');
    });
  }

  QueryBuilder<TaskData, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }
}
