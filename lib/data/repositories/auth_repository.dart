import 'package:activity_tracker/data/models/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthRepository(this._firebaseAuth);

  Future<UserCredential> signUp(UserModel newUser)  async {
    return await  _firebaseAuth.createUserWithEmailAndPassword(email: newUser.email, password: newUser.password);
  }

  Future<void> signIn(UserModel existingUser) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: existingUser.email, password: existingUser.password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return UserModel.empty;
    } else {
      GoogleSignInAuthentication authenticationDetails = await googleSignInAccount.authentication;
      AuthCredential credentials = GoogleAuthProvider.credential(idToken: authenticationDetails.idToken, accessToken: authenticationDetails.accessToken);
      UserCredential userData = await _firebaseAuth.signInWithCredential(credentials);
      return userData.user!.toUserModel();
    }
  }
}

extension UserToUserModel on User {
  UserModel toUserModel() {
    return UserModel(email!, email!);
  }
}