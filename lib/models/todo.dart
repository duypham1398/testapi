import 'dart:convert';

/// userId : 1
/// id : 1
/// title : "delectus aut autem"
/// completed : false

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));
String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    _userId = userId;
    _id = id;
    _title = title;
    _completed = completed;
  }

  Todo.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _completed = json['completed'];
  }
  int? _userId;
  int? _id;
  String? _title;
  bool? _completed;
  Todo copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) =>
      Todo(
        userId: userId ?? _userId,
        id: id ?? _id,
        title: title ?? _title,
        completed: completed ?? _completed,
      );
  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  bool? get completed => _completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['completed'] = _completed;
    return map;
  }
}
