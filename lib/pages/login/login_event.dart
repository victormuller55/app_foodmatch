abstract class LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  String email;
  String password;
  LoginLoginEvent({required this.email, required this.password});
}
