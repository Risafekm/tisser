// features/lead/domain/entities/lead_entity.dart
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
}
