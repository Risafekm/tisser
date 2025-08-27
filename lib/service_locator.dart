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

final sl = GetIt.instance;

Future<void> init() async {
  //firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //datasource
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(sl()),
  );

  //repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(sl<FirebaseAuthDatasource>()),
  );

  //usecases

  sl.registerLazySingleton(() => GetcurrentUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignoutUsecase(sl()));

  //bloc

  sl.registerFactory(
    () => AuthBloc(
      getcurrentUsecase: sl(),
      signInUsecase: sl(),
      signUpUsecase: sl(),
      signoutUsecase: sl(),
    ),
  );
}
