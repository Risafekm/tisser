// features/task/domain/entities/task_entities.dart
class TaskEntity {
  final String? id;
  final String title;
  final String description;
  final String status;
  final DateTime createdDate;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'createdDate': createdDate.toIso8601String(),
  };

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}
