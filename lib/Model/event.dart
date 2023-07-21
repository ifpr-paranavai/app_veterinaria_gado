import 'dart:convert';

final String tableEvento = 'event';

class EventFields {
  static final List<String> values = [
    id,
    title,
    note,
    isCompleted,
    date,
    startTime,
    endTime,
    color,
    remind,
    repeat,
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String note = 'note';
  static final String isCompleted = 'isCompleted';
  static final String date = 'date';
  static final String startTime = 'startTime';
  static final String endTime = 'endTime';
  static final String color = 'color';
  static final String remind = 'remind';
  static final String repeat = 'repeat';
}

class Event {
  final int? id;
  final String? title;
  final String? note;
  final int? isCompleted;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? color;
  final int? remind;
  final String? repeat;

  const Event({
    this.id,
    this.title,
    this.color,
    this.date,
    this.endTime,
    this.isCompleted,
    this.note,
    this.remind,
    this.repeat,
    this.startTime,
  });

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.title: title,
      };

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        title: json[EventFields.title] as String?,
      );

  static Event stringFromJson(Map<String, Object?> json) => Event(
        title: json[EventFields.title] as String?,
      );

  Event copy({
    int? id,
    String? title,
  }) =>
      Event(
        id: id ?? this.id,
        title: title ?? this.title,
      );
}
