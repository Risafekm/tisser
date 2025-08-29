// features/lead/presentation/bloc/lead_bloc.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/task/data/data_source/helper.dart';
import 'package:tisser_app/features/task/domain/usecases/add_task_usecase.dart';
import 'package:tisser_app/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:tisser_app/features/task/domain/usecases/get_task_usecae.dart';
import 'package:tisser_app/features/task/domain/usecases/update_task_usecase.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_event.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;
  final TaskCache taskCache = TaskCache();

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoading());

      // 1. Load cached tasks first
      final cachedTasks = await taskCache.loadTasks();
      if (cachedTasks.isNotEmpty) {
        emit(TaskLoaded(cachedTasks));
      }

      // 2. Check internet and fetch live data
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        try {
          final tasksStream = getTasks();
          await for (final tasks in tasksStream) {
            emit(TaskLoaded(tasks));
            await taskCache.saveTasks(tasks); // save latest to cache
          }
        } catch (e) {
          if (cachedTasks.isEmpty) {
            emit(TaskError('Failed to load tasks: ${e.toString()}'));
          }
        }
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await addTask(event.task);
        add(LoadTasksEvent());
      } catch (e) {
        emit(TaskError('Failed to add task: ${e.toString()}'));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await updateTask(event.task);
        add(LoadTasksEvent());
      } catch (e) {
        emit(TaskError('Failed to update task: ${e.toString()}'));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTask(event.id);
        add(LoadTasksEvent());
      } catch (e) {
        emit(TaskError('Failed to delete task: ${e.toString()}'));
      }
    });
  }
}
