import 'package:tisser_app/features/auth/domain/entities/user.dart';
import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';

class SignInUsecase {
  final AuthRepo repo;
  SignInUsecase(this.repo);

  Future<UserEntity?> call(String email, String password) async {
    return await repo.signIn(email, password);
  }
}
