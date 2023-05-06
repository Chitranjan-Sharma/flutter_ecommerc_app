class UserModel {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String profileImg;
  int? v = 0;

  UserModel(
      {required this.id,
      required this.userName,
      required this.email,
      required this.password,
      required this.profileImg});

  Map<String, dynamic> toMap() {
    return {
      "UserName": userName,
      "Email": email,
      "Password": password,
      "ProfileImg": profileImg,
    };
  }
}
