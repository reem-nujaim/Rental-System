import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/login_screens/signin_page.dart';
import '../../componenets/defualt_button.dart';
import '../../constants.dart';
import '../../core/APIService.dart';

class ForgetPasswordscreen extends StatefulWidget {
  const ForgetPasswordscreen({super.key});
  static String routeName = "/forget_PasswordScreen";

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ForgetPasswordscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  Future<void> resetPassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await APIService().resetPassword(
      email: emailController.text,
      token: tokenController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إعادة تعيين كلمة المرور بنجاح!')),
      );
      Navigator.pushReplacementNamed(context,
          SigninPage.routeNeme); // توجيه المستخدم إلى صفحة تسجيل الدخول
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(response['message'] ?? 'حدث خطأ أثناء إعادة التعيين')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إعادة تعيين كلمة المرور")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("أدخل الرمز وكلمة المرور الجديدة", style: headTextStyle()),
              SizedBox(height: 20),
              _buildTextField(
                  emailController, "البريد الإلكتروني", Icons.email),
              _buildTextField(tokenController, "رمز التحقق", Icons.lock),
              _buildTextField(
                  passwordController, "كلمة المرور الجديدة", Icons.lock,
                  obscureText: true),
              _buildTextField(
                  confirmPasswordController, "تأكيد كلمة المرور", Icons.lock,
                  obscureText: true),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator()
                  : DefualtBotton(text: "إعادة تعيين", press: resetPassword),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: kTextColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
