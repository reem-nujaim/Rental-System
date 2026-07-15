// class LoginResponse {
//   final String token;
//   final String message;
//   final User? user;

//   LoginResponse({
//     required this.token,
//     required this.message,
//     this.user,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       token: json['access_token'] ?? '',
//       message: json['message'] ?? '',
//       user: json['user'] != null ? User.fromJson(json['user']) : null,
//     );
//   }

//   @override
//   String toString() {
//     return 'LoginResponse(token: $token, message: $message, user: ${user?.toString() ?? "null"})';
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String email;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }
class LoginResponse {
  final String token;
  final String message;
  final User? user;

  LoginResponse({
    required this.token,
    required this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['access_token'] ?? '',
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  @override
  String toString() {
    return 'LoginResponse(access_token: $token, message: $message, user: ${user?.toString() ?? "null"})';
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
