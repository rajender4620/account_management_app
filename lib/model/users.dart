class User {
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  final String? email;
  final String? password;

  User({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson(User user) {
    return {
      'firstname': user.firstName,
      'lastname': user.lastName,
      'mobileNumber': user.mobileNumber,
      'email': user.email,
      'password': user.password
    };
  }
}
