import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';

class SignoutUsecase {
  final AuthRepo repo;
  SignoutUsecase(this.repo);

  Future<void> call() async {
    return await repo.signOut();
  }
}
