part of 'authenticate_bloc.dart';

@immutable
sealed class AuthenticateEvent extends Equatable {}

class AuthenticateSignUpEvent extends AuthenticateEvent {

  final UserModel _newUser;
  AuthenticateSignUpEvent(this._newUser);
  
  @override
  List<Object?> get props => [_newUser.email, _newUser.password];
}

class AuthenticateSignInEvent extends AuthenticateEvent {
  
  final UserModel _existingUser;
   AuthenticateSignInEvent(this._existingUser);
  
  @override
  List<Object?> get props => [_existingUser.email, _existingUser.password];
}

class AuthenticateLogoutEvent extends AuthenticateEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticateSignInWithGoogleEvent extends AuthenticateEvent {

  @override
  List<Object?> get props => [];

}
