class UserModel {
  final String email ;
  final String password;
  
  const UserModel(this.email, this.password);

  factory UserModel.abcd(String email, String password) {
    return UserModel(email, password);
  }

  static const UserModel empty = UserModel("","");

  bool get isEmpty => this == empty;
}
