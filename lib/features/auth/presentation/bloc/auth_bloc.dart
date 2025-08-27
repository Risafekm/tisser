import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/auth/domain/usecases/getcurrent_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signout_usecase.dart';
import 'package:tisser_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final GetcurrentUsecase getcurrentUsecase;
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignoutUsecase signoutUsecase;

  AuthBloc({
    required this.getcurrentUsecase,
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signoutUsecase,
  }) : super(AuthInitial()) {
    on<LoadCurrentUserEvent>((event, emit) async {
      try {
        final user = await getcurrentUsecase();

        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError("Failed to get current user"));
      }
    });

    //signin
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInUsecase(event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthError("Sign in failed"));
        }
      } catch (e) {
        emit(AuthError("Sign in error: ${e.toString()}"));
      }
    });

    //signUp
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signUpUsecase(event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthError("Sign up failed"));
        }
      } catch (e) {
        emit(AuthError("Sign up error: ${e.toString()}"));
      }
    });

    //signOut
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signoutUsecase();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError("Sign out error: ${e.toString()}"));
      }
    });
  }
}
