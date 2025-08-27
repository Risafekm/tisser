import 'package:firebase_auth/firebase_auth.dart';
import 'package:tisser_app/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({required super.uid, super.email});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(uid: user.uid, email: user.email);
  }
}
