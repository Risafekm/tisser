// features/lead/presentation/bloc/lead_events.dart

import 'package:tisser_app/features/task/domain/entities/task_entities.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent(this.id);
}
