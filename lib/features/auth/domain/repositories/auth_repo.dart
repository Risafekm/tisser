import 'package:tisser_app/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password);
  Future<void> signOut();
}
