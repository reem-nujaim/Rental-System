// import 'userApi.dart';
// import 'user_model.dart';

// class AuthProvider {
//   final ApiService apiService;

//   AuthProvider(this.apiService);

//   Future<UserModel> registerUser(String email, String password,
//       String firstName, String lastName, String phoneNumber) async {
//     final response = await apiService.post('/register', {
//       'email': email,
//       'password': password,
//       'first_name': firstName,
//       'last_name': lastName,
//       'phone_number': phoneNumber,
//     });

//     return UserModel.fromJson(response['user']);
//   }
// }
