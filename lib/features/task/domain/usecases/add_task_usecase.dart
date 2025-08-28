// features/lead/domain/usecases/add_lead_usecase.dart
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';
import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(TaskEntity lead) {
    return repository.addTask(lead);
  }
}
