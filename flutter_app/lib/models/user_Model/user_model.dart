class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  final String address;
  final bool termsAccepted;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.address,
    required this.termsAccepted,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "phone": phone,
      "address": address,
      "terms_accepted": termsAccepted,
    };
  }
}
