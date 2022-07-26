class UserModel {
  String? uid;
  String? email;
  String? password;

  UserModel({this.uid, this.email, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
    };
  }
}