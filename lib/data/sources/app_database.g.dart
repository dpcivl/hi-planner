// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodosTable extends Todos with TableInfo<$TodosTable, TodoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<String> scheduledDate = GeneratedColumn<String>(
    'scheduled_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<String> startAt = GeneratedColumn<String>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<String> endAt = GeneratedColumn<String>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAllDayMeta = const VerificationMeta(
    'isAllDay',
  );
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
    'is_all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusTotalSecondsMeta = const VerificationMeta(
    'focusTotalSeconds',
  );
  @override
  late final GeneratedColumn<int> focusTotalSeconds = GeneratedColumn<int>(
    'focus_total_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _focusSessionCountMeta = const VerificationMeta(
    'focusSessionCount',
  );
  @override
  late final GeneratedColumn<int> focusSessionCount = GeneratedColumn<int>(
    'focus_session_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    notes,
    status,
    createdAt,
    updatedAt,
    completedAt,
    scheduledDate,
    startAt,
    endAt,
    timezone,
    isAllDay,
    priority,
    tags,
    focusTotalSeconds,
    focusSessionCount,
    orderIndex,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    } else if (isInserting) {
      context.missing(_isAllDayMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('focus_total_seconds')) {
      context.handle(
        _focusTotalSecondsMeta,
        focusTotalSeconds.isAcceptableOrUnknown(
          data['focus_total_seconds']!,
          _focusTotalSecondsMeta,
        ),
      );
    }
    if (data.containsKey('focus_session_count')) {
      context.handle(
        _focusSessionCountMeta,
        focusSessionCount.isAcceptableOrUnknown(
          data['focus_session_count']!,
          _focusSessionCountMeta,
        ),
      );
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_date'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_at'],
      ),
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_at'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      focusTotalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_total_seconds'],
      )!,
      focusSessionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_session_count'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class TodoRow extends DataClass implements Insertable<TodoRow> {
  final String id;
  final String title;
  final String? notes;

  /// `TodoStatus.wireValue`.
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? completedAt;

  /// Local 'YYYY-MM-DD' bucket key.
  final String scheduledDate;
  final String? startAt;
  final String? endAt;
  final String timezone;
  final bool isAllDay;

  /// `Priority.level` (0..3).
  final int priority;

  /// JSON-encoded `List<String>`.
  final String tags;

  /// Denormalized cache (recomputed from FocusSessions on session end).
  final int focusTotalSeconds;
  final int focusSessionCount;
  final int orderIndex;

  /// Soft-delete marker (ISO-UTC-Z). Null = active.
  final String? deletedAt;
  const TodoRow({
    required this.id,
    required this.title,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    required this.scheduledDate,
    this.startAt,
    this.endAt,
    required this.timezone,
    required this.isAllDay,
    required this.priority,
    required this.tags,
    required this.focusTotalSeconds,
    required this.focusSessionCount,
    required this.orderIndex,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    map['scheduled_date'] = Variable<String>(scheduledDate);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<String>(startAt);
    }
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<String>(endAt);
    }
    map['timezone'] = Variable<String>(timezone);
    map['is_all_day'] = Variable<bool>(isAllDay);
    map['priority'] = Variable<int>(priority);
    map['tags'] = Variable<String>(tags);
    map['focus_total_seconds'] = Variable<int>(focusTotalSeconds);
    map['focus_session_count'] = Variable<int>(focusSessionCount);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      scheduledDate: Value(scheduledDate),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      timezone: Value(timezone),
      isAllDay: Value(isAllDay),
      priority: Value(priority),
      tags: Value(tags),
      focusTotalSeconds: Value(focusTotalSeconds),
      focusSessionCount: Value(focusSessionCount),
      orderIndex: Value(orderIndex),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TodoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
      scheduledDate: serializer.fromJson<String>(json['scheduledDate']),
      startAt: serializer.fromJson<String?>(json['startAt']),
      endAt: serializer.fromJson<String?>(json['endAt']),
      timezone: serializer.fromJson<String>(json['timezone']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      priority: serializer.fromJson<int>(json['priority']),
      tags: serializer.fromJson<String>(json['tags']),
      focusTotalSeconds: serializer.fromJson<int>(json['focusTotalSeconds']),
      focusSessionCount: serializer.fromJson<int>(json['focusSessionCount']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'completedAt': serializer.toJson<String?>(completedAt),
      'scheduledDate': serializer.toJson<String>(scheduledDate),
      'startAt': serializer.toJson<String?>(startAt),
      'endAt': serializer.toJson<String?>(endAt),
      'timezone': serializer.toJson<String>(timezone),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'priority': serializer.toJson<int>(priority),
      'tags': serializer.toJson<String>(tags),
      'focusTotalSeconds': serializer.toJson<int>(focusTotalSeconds),
      'focusSessionCount': serializer.toJson<int>(focusSessionCount),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  TodoRow copyWith({
    String? id,
    String? title,
    Value<String?> notes = const Value.absent(),
    String? status,
    String? createdAt,
    String? updatedAt,
    Value<String?> completedAt = const Value.absent(),
    String? scheduledDate,
    Value<String?> startAt = const Value.absent(),
    Value<String?> endAt = const Value.absent(),
    String? timezone,
    bool? isAllDay,
    int? priority,
    String? tags,
    int? focusTotalSeconds,
    int? focusSessionCount,
    int? orderIndex,
    Value<String?> deletedAt = const Value.absent(),
  }) => TodoRow(
    id: id ?? this.id,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    scheduledDate: scheduledDate ?? this.scheduledDate,
    startAt: startAt.present ? startAt.value : this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    timezone: timezone ?? this.timezone,
    isAllDay: isAllDay ?? this.isAllDay,
    priority: priority ?? this.priority,
    tags: tags ?? this.tags,
    focusTotalSeconds: focusTotalSeconds ?? this.focusTotalSeconds,
    focusSessionCount: focusSessionCount ?? this.focusSessionCount,
    orderIndex: orderIndex ?? this.orderIndex,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TodoRow copyWithCompanion(TodosCompanion data) {
    return TodoRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      priority: data.priority.present ? data.priority.value : this.priority,
      tags: data.tags.present ? data.tags.value : this.tags,
      focusTotalSeconds: data.focusTotalSeconds.present
          ? data.focusTotalSeconds.value
          : this.focusTotalSeconds,
      focusSessionCount: data.focusSessionCount.present
          ? data.focusSessionCount.value
          : this.focusSessionCount,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('timezone: $timezone, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('priority: $priority, ')
          ..write('tags: $tags, ')
          ..write('focusTotalSeconds: $focusTotalSeconds, ')
          ..write('focusSessionCount: $focusSessionCount, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    notes,
    status,
    createdAt,
    updatedAt,
    completedAt,
    scheduledDate,
    startAt,
    endAt,
    timezone,
    isAllDay,
    priority,
    tags,
    focusTotalSeconds,
    focusSessionCount,
    orderIndex,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt &&
          other.scheduledDate == this.scheduledDate &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.timezone == this.timezone &&
          other.isAllDay == this.isAllDay &&
          other.priority == this.priority &&
          other.tags == this.tags &&
          other.focusTotalSeconds == this.focusTotalSeconds &&
          other.focusSessionCount == this.focusSessionCount &&
          other.orderIndex == this.orderIndex &&
          other.deletedAt == this.deletedAt);
}

class TodosCompanion extends UpdateCompanion<TodoRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> completedAt;
  final Value<String> scheduledDate;
  final Value<String?> startAt;
  final Value<String?> endAt;
  final Value<String> timezone;
  final Value<bool> isAllDay;
  final Value<int> priority;
  final Value<String> tags;
  final Value<int> focusTotalSeconds;
  final Value<int> focusSessionCount;
  final Value<int> orderIndex;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.priority = const Value.absent(),
    this.tags = const Value.absent(),
    this.focusTotalSeconds = const Value.absent(),
    this.focusSessionCount = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodosCompanion.insert({
    required String id,
    required String title,
    this.notes = const Value.absent(),
    required String status,
    required String createdAt,
    required String updatedAt,
    this.completedAt = const Value.absent(),
    required String scheduledDate,
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    required String timezone,
    required bool isAllDay,
    required int priority,
    required String tags,
    this.focusTotalSeconds = const Value.absent(),
    this.focusSessionCount = const Value.absent(),
    required int orderIndex,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       scheduledDate = Value(scheduledDate),
       timezone = Value(timezone),
       isAllDay = Value(isAllDay),
       priority = Value(priority),
       tags = Value(tags),
       orderIndex = Value(orderIndex);
  static Insertable<TodoRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? completedAt,
    Expression<String>? scheduledDate,
    Expression<String>? startAt,
    Expression<String>? endAt,
    Expression<String>? timezone,
    Expression<bool>? isAllDay,
    Expression<int>? priority,
    Expression<String>? tags,
    Expression<int>? focusTotalSeconds,
    Expression<int>? focusSessionCount,
    Expression<int>? orderIndex,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (timezone != null) 'timezone': timezone,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (priority != null) 'priority': priority,
      if (tags != null) 'tags': tags,
      if (focusTotalSeconds != null) 'focus_total_seconds': focusTotalSeconds,
      if (focusSessionCount != null) 'focus_session_count': focusSessionCount,
      if (orderIndex != null) 'order_index': orderIndex,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodosCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? notes,
    Value<String>? status,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? completedAt,
    Value<String>? scheduledDate,
    Value<String?>? startAt,
    Value<String?>? endAt,
    Value<String>? timezone,
    Value<bool>? isAllDay,
    Value<int>? priority,
    Value<String>? tags,
    Value<int>? focusTotalSeconds,
    Value<int>? focusSessionCount,
    Value<int>? orderIndex,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      timezone: timezone ?? this.timezone,
      isAllDay: isAllDay ?? this.isAllDay,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      focusTotalSeconds: focusTotalSeconds ?? this.focusTotalSeconds,
      focusSessionCount: focusSessionCount ?? this.focusSessionCount,
      orderIndex: orderIndex ?? this.orderIndex,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<String>(scheduledDate.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<String>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<String>(endAt.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (focusTotalSeconds.present) {
      map['focus_total_seconds'] = Variable<int>(focusTotalSeconds.value);
    }
    if (focusSessionCount.present) {
      map['focus_session_count'] = Variable<int>(focusSessionCount.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('timezone: $timezone, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('priority: $priority, ')
          ..write('tags: $tags, ')
          ..write('focusTotalSeconds: $focusTotalSeconds, ')
          ..write('focusSessionCount: $focusSessionCount, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTable extends FocusSessions
    with TableInfo<$FocusSessionsTable, FocusSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _todoIdMeta = const VerificationMeta('todoId');
  @override
  late final GeneratedColumn<String> todoId = GeneratedColumn<String>(
    'todo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES todos (id)',
    ),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<String> startAt = GeneratedColumn<String>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<String> endAt = GeneratedColumn<String>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedSecondsMeta = const VerificationMeta(
    'plannedSeconds',
  );
  @override
  late final GeneratedColumn<int> plannedSeconds = GeneratedColumn<int>(
    'planned_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pausedSecondsMeta = const VerificationMeta(
    'pausedSeconds',
  );
  @override
  late final GeneratedColumn<int> pausedSeconds = GeneratedColumn<int>(
    'paused_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interruptedMeta = const VerificationMeta(
    'interrupted',
  );
  @override
  late final GeneratedColumn<bool> interrupted = GeneratedColumn<bool>(
    'interrupted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("interrupted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _endReasonMeta = const VerificationMeta(
    'endReason',
  );
  @override
  late final GeneratedColumn<String> endReason = GeneratedColumn<String>(
    'end_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<String> scheduledDate = GeneratedColumn<String>(
    'scheduled_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    todoId,
    startAt,
    endAt,
    createdAt,
    plannedSeconds,
    durationSeconds,
    pausedSeconds,
    interrupted,
    endReason,
    scheduledDate,
    timezone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FocusSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('todo_id')) {
      context.handle(
        _todoIdMeta,
        todoId.isAcceptableOrUnknown(data['todo_id']!, _todoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_todoIdMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('planned_seconds')) {
      context.handle(
        _plannedSecondsMeta,
        plannedSeconds.isAcceptableOrUnknown(
          data['planned_seconds']!,
          _plannedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('paused_seconds')) {
      context.handle(
        _pausedSecondsMeta,
        pausedSeconds.isAcceptableOrUnknown(
          data['paused_seconds']!,
          _pausedSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pausedSecondsMeta);
    }
    if (data.containsKey('interrupted')) {
      context.handle(
        _interruptedMeta,
        interrupted.isAcceptableOrUnknown(
          data['interrupted']!,
          _interruptedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interruptedMeta);
    }
    if (data.containsKey('end_reason')) {
      context.handle(
        _endReasonMeta,
        endReason.isAcceptableOrUnknown(data['end_reason']!, _endReasonMeta),
      );
    } else if (isInserting) {
      context.missing(_endReasonMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      todoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}todo_id'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      plannedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_seconds'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      pausedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paused_seconds'],
      )!,
      interrupted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}interrupted'],
      )!,
      endReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_reason'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_date'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
    );
  }

  @override
  $FocusSessionsTable createAlias(String alias) {
    return $FocusSessionsTable(attachedDatabase, alias);
  }
}

class FocusSessionRow extends DataClass implements Insertable<FocusSessionRow> {
  final String id;

  /// FK to [Todos.id]. No cascade — sessions outlive a soft-deleted todo.
  final String todoId;
  final String startAt;
  final String? endAt;
  final String createdAt;
  final int? plannedSeconds;
  final int durationSeconds;
  final int pausedSeconds;
  final bool interrupted;

  /// `FocusEndReason.wireValue`.
  final String endReason;
  final String scheduledDate;
  final String timezone;
  const FocusSessionRow({
    required this.id,
    required this.todoId,
    required this.startAt,
    this.endAt,
    required this.createdAt,
    this.plannedSeconds,
    required this.durationSeconds,
    required this.pausedSeconds,
    required this.interrupted,
    required this.endReason,
    required this.scheduledDate,
    required this.timezone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['todo_id'] = Variable<String>(todoId);
    map['start_at'] = Variable<String>(startAt);
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<String>(endAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || plannedSeconds != null) {
      map['planned_seconds'] = Variable<int>(plannedSeconds);
    }
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['paused_seconds'] = Variable<int>(pausedSeconds);
    map['interrupted'] = Variable<bool>(interrupted);
    map['end_reason'] = Variable<String>(endReason);
    map['scheduled_date'] = Variable<String>(scheduledDate);
    map['timezone'] = Variable<String>(timezone);
    return map;
  }

  FocusSessionsCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsCompanion(
      id: Value(id),
      todoId: Value(todoId),
      startAt: Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      createdAt: Value(createdAt),
      plannedSeconds: plannedSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedSeconds),
      durationSeconds: Value(durationSeconds),
      pausedSeconds: Value(pausedSeconds),
      interrupted: Value(interrupted),
      endReason: Value(endReason),
      scheduledDate: Value(scheduledDate),
      timezone: Value(timezone),
    );
  }

  factory FocusSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSessionRow(
      id: serializer.fromJson<String>(json['id']),
      todoId: serializer.fromJson<String>(json['todoId']),
      startAt: serializer.fromJson<String>(json['startAt']),
      endAt: serializer.fromJson<String?>(json['endAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      plannedSeconds: serializer.fromJson<int?>(json['plannedSeconds']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      pausedSeconds: serializer.fromJson<int>(json['pausedSeconds']),
      interrupted: serializer.fromJson<bool>(json['interrupted']),
      endReason: serializer.fromJson<String>(json['endReason']),
      scheduledDate: serializer.fromJson<String>(json['scheduledDate']),
      timezone: serializer.fromJson<String>(json['timezone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'todoId': serializer.toJson<String>(todoId),
      'startAt': serializer.toJson<String>(startAt),
      'endAt': serializer.toJson<String?>(endAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'plannedSeconds': serializer.toJson<int?>(plannedSeconds),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'pausedSeconds': serializer.toJson<int>(pausedSeconds),
      'interrupted': serializer.toJson<bool>(interrupted),
      'endReason': serializer.toJson<String>(endReason),
      'scheduledDate': serializer.toJson<String>(scheduledDate),
      'timezone': serializer.toJson<String>(timezone),
    };
  }

  FocusSessionRow copyWith({
    String? id,
    String? todoId,
    String? startAt,
    Value<String?> endAt = const Value.absent(),
    String? createdAt,
    Value<int?> plannedSeconds = const Value.absent(),
    int? durationSeconds,
    int? pausedSeconds,
    bool? interrupted,
    String? endReason,
    String? scheduledDate,
    String? timezone,
  }) => FocusSessionRow(
    id: id ?? this.id,
    todoId: todoId ?? this.todoId,
    startAt: startAt ?? this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    createdAt: createdAt ?? this.createdAt,
    plannedSeconds: plannedSeconds.present
        ? plannedSeconds.value
        : this.plannedSeconds,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    pausedSeconds: pausedSeconds ?? this.pausedSeconds,
    interrupted: interrupted ?? this.interrupted,
    endReason: endReason ?? this.endReason,
    scheduledDate: scheduledDate ?? this.scheduledDate,
    timezone: timezone ?? this.timezone,
  );
  FocusSessionRow copyWithCompanion(FocusSessionsCompanion data) {
    return FocusSessionRow(
      id: data.id.present ? data.id.value : this.id,
      todoId: data.todoId.present ? data.todoId.value : this.todoId,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      plannedSeconds: data.plannedSeconds.present
          ? data.plannedSeconds.value
          : this.plannedSeconds,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      pausedSeconds: data.pausedSeconds.present
          ? data.pausedSeconds.value
          : this.pausedSeconds,
      interrupted: data.interrupted.present
          ? data.interrupted.value
          : this.interrupted,
      endReason: data.endReason.present ? data.endReason.value : this.endReason,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionRow(')
          ..write('id: $id, ')
          ..write('todoId: $todoId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('pausedSeconds: $pausedSeconds, ')
          ..write('interrupted: $interrupted, ')
          ..write('endReason: $endReason, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('timezone: $timezone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    todoId,
    startAt,
    endAt,
    createdAt,
    plannedSeconds,
    durationSeconds,
    pausedSeconds,
    interrupted,
    endReason,
    scheduledDate,
    timezone,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSessionRow &&
          other.id == this.id &&
          other.todoId == this.todoId &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.createdAt == this.createdAt &&
          other.plannedSeconds == this.plannedSeconds &&
          other.durationSeconds == this.durationSeconds &&
          other.pausedSeconds == this.pausedSeconds &&
          other.interrupted == this.interrupted &&
          other.endReason == this.endReason &&
          other.scheduledDate == this.scheduledDate &&
          other.timezone == this.timezone);
}

class FocusSessionsCompanion extends UpdateCompanion<FocusSessionRow> {
  final Value<String> id;
  final Value<String> todoId;
  final Value<String> startAt;
  final Value<String?> endAt;
  final Value<String> createdAt;
  final Value<int?> plannedSeconds;
  final Value<int> durationSeconds;
  final Value<int> pausedSeconds;
  final Value<bool> interrupted;
  final Value<String> endReason;
  final Value<String> scheduledDate;
  final Value<String> timezone;
  final Value<int> rowid;
  const FocusSessionsCompanion({
    this.id = const Value.absent(),
    this.todoId = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.plannedSeconds = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.pausedSeconds = const Value.absent(),
    this.interrupted = const Value.absent(),
    this.endReason = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FocusSessionsCompanion.insert({
    required String id,
    required String todoId,
    required String startAt,
    this.endAt = const Value.absent(),
    required String createdAt,
    this.plannedSeconds = const Value.absent(),
    required int durationSeconds,
    required int pausedSeconds,
    required bool interrupted,
    required String endReason,
    required String scheduledDate,
    required String timezone,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       todoId = Value(todoId),
       startAt = Value(startAt),
       createdAt = Value(createdAt),
       durationSeconds = Value(durationSeconds),
       pausedSeconds = Value(pausedSeconds),
       interrupted = Value(interrupted),
       endReason = Value(endReason),
       scheduledDate = Value(scheduledDate),
       timezone = Value(timezone);
  static Insertable<FocusSessionRow> custom({
    Expression<String>? id,
    Expression<String>? todoId,
    Expression<String>? startAt,
    Expression<String>? endAt,
    Expression<String>? createdAt,
    Expression<int>? plannedSeconds,
    Expression<int>? durationSeconds,
    Expression<int>? pausedSeconds,
    Expression<bool>? interrupted,
    Expression<String>? endReason,
    Expression<String>? scheduledDate,
    Expression<String>? timezone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todoId != null) 'todo_id': todoId,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (createdAt != null) 'created_at': createdAt,
      if (plannedSeconds != null) 'planned_seconds': plannedSeconds,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (pausedSeconds != null) 'paused_seconds': pausedSeconds,
      if (interrupted != null) 'interrupted': interrupted,
      if (endReason != null) 'end_reason': endReason,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (timezone != null) 'timezone': timezone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FocusSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? todoId,
    Value<String>? startAt,
    Value<String?>? endAt,
    Value<String>? createdAt,
    Value<int?>? plannedSeconds,
    Value<int>? durationSeconds,
    Value<int>? pausedSeconds,
    Value<bool>? interrupted,
    Value<String>? endReason,
    Value<String>? scheduledDate,
    Value<String>? timezone,
    Value<int>? rowid,
  }) {
    return FocusSessionsCompanion(
      id: id ?? this.id,
      todoId: todoId ?? this.todoId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      createdAt: createdAt ?? this.createdAt,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pausedSeconds: pausedSeconds ?? this.pausedSeconds,
      interrupted: interrupted ?? this.interrupted,
      endReason: endReason ?? this.endReason,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      timezone: timezone ?? this.timezone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (todoId.present) {
      map['todo_id'] = Variable<String>(todoId.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<String>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<String>(endAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (plannedSeconds.present) {
      map['planned_seconds'] = Variable<int>(plannedSeconds.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (pausedSeconds.present) {
      map['paused_seconds'] = Variable<int>(pausedSeconds.value);
    }
    if (interrupted.present) {
      map['interrupted'] = Variable<bool>(interrupted.value);
    }
    if (endReason.present) {
      map['end_reason'] = Variable<String>(endReason.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<String>(scheduledDate.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsCompanion(')
          ..write('id: $id, ')
          ..write('todoId: $todoId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('pausedSeconds: $pausedSeconds, ')
          ..write('interrupted: $interrupted, ')
          ..write('endReason: $endReason, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('timezone: $timezone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodosTable todos = $TodosTable(this);
  late final $FocusSessionsTable focusSessions = $FocusSessionsTable(this);
  late final Index idxTodoScheduledDate = Index(
    'idx_todo_scheduledDate',
    'CREATE INDEX idx_todo_scheduledDate ON todos (scheduled_date)',
  );
  late final Index idxTodoStatus = Index(
    'idx_todo_status',
    'CREATE INDEX idx_todo_status ON todos (status)',
  );
  late final Index idxFsScheduledDate = Index(
    'idx_fs_scheduledDate',
    'CREATE INDEX idx_fs_scheduledDate ON focus_sessions (scheduled_date)',
  );
  late final Index idxFsTodoId = Index(
    'idx_fs_todoId',
    'CREATE INDEX idx_fs_todoId ON focus_sessions (todo_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    todos,
    focusSessions,
    idxTodoScheduledDate,
    idxTodoStatus,
    idxFsScheduledDate,
    idxFsTodoId,
  ];
}

typedef $$TodosTableCreateCompanionBuilder =
    TodosCompanion Function({
      required String id,
      required String title,
      Value<String?> notes,
      required String status,
      required String createdAt,
      required String updatedAt,
      Value<String?> completedAt,
      required String scheduledDate,
      Value<String?> startAt,
      Value<String?> endAt,
      required String timezone,
      required bool isAllDay,
      required int priority,
      required String tags,
      Value<int> focusTotalSeconds,
      Value<int> focusSessionCount,
      required int orderIndex,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$TodosTableUpdateCompanionBuilder =
    TodosCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> notes,
      Value<String> status,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> completedAt,
      Value<String> scheduledDate,
      Value<String?> startAt,
      Value<String?> endAt,
      Value<String> timezone,
      Value<bool> isAllDay,
      Value<int> priority,
      Value<String> tags,
      Value<int> focusTotalSeconds,
      Value<int> focusSessionCount,
      Value<int> orderIndex,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$TodosTableReferences
    extends BaseReferences<_$AppDatabase, $TodosTable, TodoRow> {
  $$TodosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FocusSessionsTable, List<FocusSessionRow>>
  _focusSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.focusSessions,
    aliasName: 'todos__id__focus_sessions__todo_id',
  );

  $$FocusSessionsTableProcessedTableManager get focusSessionsRefs {
    final manager = $$FocusSessionsTableTableManager(
      $_db,
      $_db.focusSessions,
    ).filter((f) => f.todoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_focusSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TodosTableFilterComposer extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusTotalSeconds => $composableBuilder(
    column: $table.focusTotalSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusSessionCount => $composableBuilder(
    column: $table.focusSessionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> focusSessionsRefs(
    Expression<bool> Function($$FocusSessionsTableFilterComposer f) f,
  ) {
    final $$FocusSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.focusSessions,
      getReferencedColumn: (t) => t.todoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FocusSessionsTableFilterComposer(
            $db: $db,
            $table: $db.focusSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodosTableOrderingComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusTotalSeconds => $composableBuilder(
    column: $table.focusTotalSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusSessionCount => $composableBuilder(
    column: $table.focusSessionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<String> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get focusTotalSeconds => $composableBuilder(
    column: $table.focusTotalSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get focusSessionCount => $composableBuilder(
    column: $table.focusSessionCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> focusSessionsRefs<T extends Object>(
    Expression<T> Function($$FocusSessionsTableAnnotationComposer a) f,
  ) {
    final $$FocusSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.focusSessions,
      getReferencedColumn: (t) => t.todoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FocusSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.focusSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TodosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodosTable,
          TodoRow,
          $$TodosTableFilterComposer,
          $$TodosTableOrderingComposer,
          $$TodosTableAnnotationComposer,
          $$TodosTableCreateCompanionBuilder,
          $$TodosTableUpdateCompanionBuilder,
          (TodoRow, $$TodosTableReferences),
          TodoRow,
          PrefetchHooks Function({bool focusSessionsRefs})
        > {
  $$TodosTableTableManager(_$AppDatabase db, $TodosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
                Value<String> scheduledDate = const Value.absent(),
                Value<String?> startAt = const Value.absent(),
                Value<String?> endAt = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> focusTotalSeconds = const Value.absent(),
                Value<int> focusSessionCount = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion(
                id: id,
                title: title,
                notes: notes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                scheduledDate: scheduledDate,
                startAt: startAt,
                endAt: endAt,
                timezone: timezone,
                isAllDay: isAllDay,
                priority: priority,
                tags: tags,
                focusTotalSeconds: focusTotalSeconds,
                focusSessionCount: focusSessionCount,
                orderIndex: orderIndex,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> notes = const Value.absent(),
                required String status,
                required String createdAt,
                required String updatedAt,
                Value<String?> completedAt = const Value.absent(),
                required String scheduledDate,
                Value<String?> startAt = const Value.absent(),
                Value<String?> endAt = const Value.absent(),
                required String timezone,
                required bool isAllDay,
                required int priority,
                required String tags,
                Value<int> focusTotalSeconds = const Value.absent(),
                Value<int> focusSessionCount = const Value.absent(),
                required int orderIndex,
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion.insert(
                id: id,
                title: title,
                notes: notes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                scheduledDate: scheduledDate,
                startAt: startAt,
                endAt: endAt,
                timezone: timezone,
                isAllDay: isAllDay,
                priority: priority,
                tags: tags,
                focusTotalSeconds: focusTotalSeconds,
                focusSessionCount: focusSessionCount,
                orderIndex: orderIndex,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TodosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({focusSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (focusSessionsRefs) db.focusSessions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (focusSessionsRefs)
                    await $_getPrefetchedData<
                      TodoRow,
                      $TodosTable,
                      FocusSessionRow
                    >(
                      currentTable: table,
                      referencedTable: $$TodosTableReferences
                          ._focusSessionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TodosTableReferences(
                        db,
                        table,
                        p0,
                      ).focusSessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.todoId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TodosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodosTable,
      TodoRow,
      $$TodosTableFilterComposer,
      $$TodosTableOrderingComposer,
      $$TodosTableAnnotationComposer,
      $$TodosTableCreateCompanionBuilder,
      $$TodosTableUpdateCompanionBuilder,
      (TodoRow, $$TodosTableReferences),
      TodoRow,
      PrefetchHooks Function({bool focusSessionsRefs})
    >;
typedef $$FocusSessionsTableCreateCompanionBuilder =
    FocusSessionsCompanion Function({
      required String id,
      required String todoId,
      required String startAt,
      Value<String?> endAt,
      required String createdAt,
      Value<int?> plannedSeconds,
      required int durationSeconds,
      required int pausedSeconds,
      required bool interrupted,
      required String endReason,
      required String scheduledDate,
      required String timezone,
      Value<int> rowid,
    });
typedef $$FocusSessionsTableUpdateCompanionBuilder =
    FocusSessionsCompanion Function({
      Value<String> id,
      Value<String> todoId,
      Value<String> startAt,
      Value<String?> endAt,
      Value<String> createdAt,
      Value<int?> plannedSeconds,
      Value<int> durationSeconds,
      Value<int> pausedSeconds,
      Value<bool> interrupted,
      Value<String> endReason,
      Value<String> scheduledDate,
      Value<String> timezone,
      Value<int> rowid,
    });

final class $$FocusSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FocusSessionsTable, FocusSessionRow> {
  $$FocusSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TodosTable _todoIdTable(_$AppDatabase db) =>
      db.todos.createAlias('focus_sessions__todo_id__todos__id');

  $$TodosTableProcessedTableManager get todoId {
    final $_column = $_itemColumn<String>('todo_id')!;

    final manager = $$TodosTableTableManager(
      $_db,
      $_db.todos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_todoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FocusSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pausedSeconds => $composableBuilder(
    column: $table.pausedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  $$TodosTableFilterComposer get todoId {
    final $$TodosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoId,
      referencedTable: $db.todos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodosTableFilterComposer(
            $db: $db,
            $table: $db.todos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pausedSeconds => $composableBuilder(
    column: $table.pausedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  $$TodosTableOrderingComposer get todoId {
    final $$TodosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoId,
      referencedTable: $db.todos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodosTableOrderingComposer(
            $db: $db,
            $table: $db.todos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<String> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pausedSeconds => $composableBuilder(
    column: $table.pausedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get interrupted => $composableBuilder(
    column: $table.interrupted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endReason =>
      $composableBuilder(column: $table.endReason, builder: (column) => column);

  GeneratedColumn<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  $$TodosTableAnnotationComposer get todoId {
    final $$TodosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.todoId,
      referencedTable: $db.todos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodosTableAnnotationComposer(
            $db: $db,
            $table: $db.todos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FocusSessionsTable,
          FocusSessionRow,
          $$FocusSessionsTableFilterComposer,
          $$FocusSessionsTableOrderingComposer,
          $$FocusSessionsTableAnnotationComposer,
          $$FocusSessionsTableCreateCompanionBuilder,
          $$FocusSessionsTableUpdateCompanionBuilder,
          (FocusSessionRow, $$FocusSessionsTableReferences),
          FocusSessionRow,
          PrefetchHooks Function({bool todoId})
        > {
  $$FocusSessionsTableTableManager(_$AppDatabase db, $FocusSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> todoId = const Value.absent(),
                Value<String> startAt = const Value.absent(),
                Value<String?> endAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int?> plannedSeconds = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int> pausedSeconds = const Value.absent(),
                Value<bool> interrupted = const Value.absent(),
                Value<String> endReason = const Value.absent(),
                Value<String> scheduledDate = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsCompanion(
                id: id,
                todoId: todoId,
                startAt: startAt,
                endAt: endAt,
                createdAt: createdAt,
                plannedSeconds: plannedSeconds,
                durationSeconds: durationSeconds,
                pausedSeconds: pausedSeconds,
                interrupted: interrupted,
                endReason: endReason,
                scheduledDate: scheduledDate,
                timezone: timezone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String todoId,
                required String startAt,
                Value<String?> endAt = const Value.absent(),
                required String createdAt,
                Value<int?> plannedSeconds = const Value.absent(),
                required int durationSeconds,
                required int pausedSeconds,
                required bool interrupted,
                required String endReason,
                required String scheduledDate,
                required String timezone,
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsCompanion.insert(
                id: id,
                todoId: todoId,
                startAt: startAt,
                endAt: endAt,
                createdAt: createdAt,
                plannedSeconds: plannedSeconds,
                durationSeconds: durationSeconds,
                pausedSeconds: pausedSeconds,
                interrupted: interrupted,
                endReason: endReason,
                scheduledDate: scheduledDate,
                timezone: timezone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FocusSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({todoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (todoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.todoId,
                                referencedTable: $$FocusSessionsTableReferences
                                    ._todoIdTable(db),
                                referencedColumn: $$FocusSessionsTableReferences
                                    ._todoIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FocusSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FocusSessionsTable,
      FocusSessionRow,
      $$FocusSessionsTableFilterComposer,
      $$FocusSessionsTableOrderingComposer,
      $$FocusSessionsTableAnnotationComposer,
      $$FocusSessionsTableCreateCompanionBuilder,
      $$FocusSessionsTableUpdateCompanionBuilder,
      (FocusSessionRow, $$FocusSessionsTableReferences),
      FocusSessionRow,
      PrefetchHooks Function({bool todoId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
  $$FocusSessionsTableTableManager get focusSessions =>
      $$FocusSessionsTableTableManager(_db, _db.focusSessions);
}
