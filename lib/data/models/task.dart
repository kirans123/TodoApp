class Task {
  final int id;
  final String title;
  final bool completed;

  Task({required this.id, required this.title, required this.completed});

  // From JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] is bool
          ? json['completed']
          : json['completed'] == 1, // Handle both bool and int
    );
  }
  //copyWith method
  Task copyWith({
    int? id,
    String? title,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
    };
  }
}
