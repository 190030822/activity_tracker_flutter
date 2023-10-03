part of 'authenticate_bloc.dart';

@immutable
sealed class AuthenticateState {}


enum SignUpState {registering, registered, unregisterd, failed}


class AuthenticateSignUpState extends AuthenticateState {

  final SignUpState status;
  final UserModel user;
  final bool isNew;
  AuthenticateSignUpState(this.status, this.user, this.isNew);
}




