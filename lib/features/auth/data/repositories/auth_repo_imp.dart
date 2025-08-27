// ignore_for_file: unused_field

import 'package:tisser_app/features/auth/data/data_sources/firebase_auth_datasource.dart';
import 'package:tisser_app/features/auth/data/models/user_model.dart';
import 'package:tisser_app/features/auth/domain/entities/user.dart';
import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  final FirebaseAuthDatasource datasource;

  AuthRepoImp(this.datasource);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = datasource.geturrentUser();
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final user = await datasource.signIn(email, password);

    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  @override
  Future<UserEntity?> signUp(String email, String password) async {
    final user = await datasource.signUp(email, password);

    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await datasource.signOut();
  }
}
