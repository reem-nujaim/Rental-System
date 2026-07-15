class UserModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;

  UserModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
    };
  }
}
