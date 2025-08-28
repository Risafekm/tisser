// service_locator.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tisser_app/features/auth/data/data_sources/firebase_auth_datasource.dart';
import 'package:tisser_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:tisser_app/features/auth/domain/usecases/getcurrent_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signout_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/task/data/data_source/task_datasource.dart';
import 'package:tisser_app/features/task/data/repositories/task_repo_imp.dart';
import 'package:tisser_app/features/task/domain/repositories/task_repo.dart';
import 'package:tisser_app/features/task/domain/usecases/add_task_usecase.dart';
import 'package:tisser_app/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:tisser_app/features/task/domain/usecases/get_task_usecae.dart';
import 'package:tisser_app/features/task/domain/usecases/update_task_usecase.dart';
import 'package:tisser_app/features/task/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  //datasource
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(sl()),
  );
  sl.registerLazySingleton<FirestoreTaskDataSource>(
    () => FirestoreTaskDataSource(sl()),
  );

  //repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(sl<FirebaseAuthDatasource>()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl<FirestoreTaskDataSource>()),
  );

  //usecases
  sl.registerLazySingleton(() => GetcurrentUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignoutUsecase(sl()));
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));

  //bloc
  sl.registerFactory(
    () => AuthBloc(
      getcurrentUsecase: sl(),
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signoutUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );
}
