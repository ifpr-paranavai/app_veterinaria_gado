final String tableTask = 'task';


class TaskFields {
  static final List<String> values = [
    /// Add all fields
    id, title, note, isCompleted, date, startTime, endTime, color, remind,
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

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json[TaskFields.id] as int?,
      title: json[TaskFields.title] as String?,
      note: json[TaskFields.note] as String?,
      isCompleted: json[TaskFields.isCompleted] as int?,
      date: json[TaskFields.date] as String?,
      startTime: json[TaskFields.startTime] as String?,
      endTime: json[TaskFields.endTime] as String?,
      color: json[TaskFields.color] as int?,
      remind: json[TaskFields.remind] as int?,
      repeat: json[TaskFields.repeat] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[TaskFields.id] = this.id;
    data[TaskFields.title] = this.title;
    data[TaskFields.note] = this.note;
    data[TaskFields.isCompleted] = this.isCompleted;
    data[TaskFields.date] = this.date;
    data[TaskFields.startTime] = this.startTime;
    data[TaskFields.endTime] = this.endTime;
    data[TaskFields.color] = this.color;
    data[TaskFields.remind] = this.remind;
    data[TaskFields.repeat] = this.repeat;
    return data;
  }

  Task copy({
    int? id,
    String? title,
    String? note,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
    );
  }
}
