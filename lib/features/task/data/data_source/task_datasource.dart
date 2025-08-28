// features/lead/data/data_sources/firestore_lead_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tisser_app/features/task/data/models/task_model.dart';

class FirestoreTaskDataSource {
  final FirebaseFirestore _firestore;

  FirestoreTaskDataSource(this._firestore);

  CollectionReference get _tasksCollection => _firestore.collection('tasks');

  Stream<List<TaskModel>> getTasks() {
    return _tasksCollection
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList(),
        );
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _tasksCollection.add(task.toMap());
    } on FirebaseException catch (e) {
      print('Firestore error: ${e.code} - ${e.message}');
      throw Exception('Failed to add lead: ${e.code}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to add lead: Unexpected error');
    }
  }

  Future<void> updateTask(TaskModel lead) async {
    await _tasksCollection.doc(lead.id).update(lead.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }
}
