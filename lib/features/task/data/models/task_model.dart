// features/lead/data/models/lead_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    String? id,
    required String title,
    required String description,
    required String status,
    required DateTime createdDate,
  }) : super(
         id: id,
         title: title,
         description: description,
         status: status,
         createdDate: createdDate,
       );

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? 'New',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
