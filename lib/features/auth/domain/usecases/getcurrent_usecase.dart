import 'package:tisser_app/features/auth/domain/entities/user.dart';
import 'package:tisser_app/features/auth/domain/repositories/auth_repo.dart';

class GetcurrentUsecase {
  final AuthRepo repo;
  GetcurrentUsecase(this.repo);

  Future<UserEntity?> call() async {
    return await repo.getCurrentUser();
  }
}
