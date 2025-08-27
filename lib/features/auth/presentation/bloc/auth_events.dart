abstract class AuthEvents {}

class LoadCurrentUserEvent extends AuthEvents {}

class SignInEvent extends AuthEvents {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvents {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvents {}
