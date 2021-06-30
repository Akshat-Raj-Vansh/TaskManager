//@dart=2.9
class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime date;

  Task({
    this.id = '',
    this.title,
    this.description,
    this.completed = false,
    this.date,
  });

  Task.fromRawJson(Map json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        completed = json['completed'],
        date = DateTime.parse(json['date']);

  Task.fromJson(Map json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        completed = json['completed'],
        date = DateTime.parse(json['createdAt']);

  Map toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'completed': completed,
        'createdAt': date.toString(),
      };
}
