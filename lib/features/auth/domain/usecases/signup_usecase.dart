import 'package:tisser_app/features/auth/domain/entities/user.dart';
import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';

class SignUpUsecase {
  final AuthRepo repo;
  SignUpUsecase(this.repo);

  Future<UserEntity?> call(String email, String password) async {
    return await repo.signUp(email, password);
  }
}
