import 'package:activity_tracker/data/models/new_user.dart';
import 'package:activity_tracker/data/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {

  final AuthRepository _authRepository;
  AuthenticateBloc(this._authRepository) : super(AuthenticateSignUpState(SignUpState.unregisterd, UserModel.empty, false)) {
    on<AuthenticateSignUpEvent>(authenticateSignUpEvent);
    on<AuthenticateSignInEvent>(authenticateSignInEvent);
    on<AuthenticateLogoutEvent>(authenticateLogoutEvent);
    on<AuthenticateSignInWithGoogleEvent>(authenticateSignInWithGoogleEvent);
  }

  void authenticateSignUpEvent(AuthenticateSignUpEvent event, Emitter emit) async{
    emit(AuthenticateSignUpState(SignUpState.registering, event._newUser, true));
    try {
      await _authRepository.signUp(event._newUser);
      emit(AuthenticateSignUpState(SignUpState.registered, event._newUser, true));
    } catch (e){
      emit(AuthenticateSignUpState(SignUpState.failed, UserModel(e.toString(), e.toString()), true));
    }
  }

  void authenticateSignInEvent(AuthenticateSignInEvent event, Emitter emit) async {
    emit(AuthenticateSignUpState(SignUpState.registering, event._existingUser, false));
    try {
      await _authRepository.signIn(event._existingUser);
      emit(AuthenticateSignUpState(SignUpState.registered, event._existingUser, false));
    } catch (e) {
      emit(AuthenticateSignUpState(SignUpState.failed, UserModel(e.toString(), e.toString()), false));
    }

  }

  void authenticateLogoutEvent(AuthenticateLogoutEvent event, Emitter emit) async {
      _authRepository.logout();
      emit(AuthenticateSignUpState(SignUpState.unregisterd, UserModel.empty, false));
  }

  void authenticateSignInWithGoogleEvent(AuthenticateSignInWithGoogleEvent event, Emitter emit) async {
    emit(AuthenticateSignUpState(SignUpState.registering, UserModel.empty, false));
    UserModel userModel = await  _authRepository.signInWithGoogle();
    if (!userModel.isEmpty) {
      emit(AuthenticateSignUpState(SignUpState.registered, userModel, false));
    } else {
      emit(AuthenticateSignUpState(SignUpState.wentback, userModel, false));
    }
  }

}
