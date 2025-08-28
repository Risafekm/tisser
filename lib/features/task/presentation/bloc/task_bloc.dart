// features/lead/presentation/bloc/lead_bloc.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        final leadsStream = getTasks();
        await for (final leads in leadsStream) {
          emit(TaskLoaded(leads));
        }
      } catch (e) {
        emit(TaskError('Failed to load leads: ${e.toString()}'));
      }
    });

    // on<AddLeadEvent>((event, emit) async {
    //   try {
    //     await addLead(event.lead);
    //   } catch (e) {
    //     emit(LeadError('Failed to add lead: ${e.toString()}'));
    //   }
    // });
    // features/lead/presentation/bloc/lead_bloc.dart
    on<AddTaskEvent>((event, emit) async {
      try {
        emit(TaskLoading());
        await addTask(event.task);
        // Optionally emit success state or reload leads
        add(LoadTasksEvent()); // Reload leads after adding
      } on FirebaseException catch (e) {
        emit(TaskError('Firestore error: ${e.code} - ${e.message}'));
      } catch (e) {
        emit(TaskError('Failed to add lead: ${e.toString()}'));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await updateTask(event.task);
      } catch (e) {
        emit(TaskError('Failed to update lead: ${e.toString()}'));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTask(event.id);
      } catch (e) {
        emit(TaskError('Failed to delete lead: ${e.toString()}'));
      }
    });
  }
}
