// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../componenets/defualt_button.dart';
import '../../../componenets/form_errors.dart';
import '../../../constants.dart';
import '../../../models/user_Model/userApi.dart';
import '../../../models/user_Model/user_model.dart';
import '../../login_screens/signin_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool agree = false;
  bool obscurePassword = true; // لإدارة إخفاء/إظهار كلمة المرور
  bool obscureConfirmPassword = true; // لإدارة إخفاء/إظهار تأكيد كلمة المرور
  final List<String> errors = [];
  ApiService apiService = ApiService();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate() && agree) {
      final user = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        phone: phoneNumController.text,
        address: addressController.text,
        termsAccepted: agree,
      );

      try {
        final success = await apiService.registerUser(user);

        // طباعة النتيجة المستلمة من الـ API
        print("Registration success: $success");

        if (success) {
          Navigator.pushNamed(
            context,
            SigninPage.routeNeme,
            arguments: {
              'message': 'تم إنشاء حسابك بنجاح! يرجى تسجيل الدخول.',
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل التسجيل!")),
          );
        }
      } catch (e) {
        // تحقق من رسالة الاستجابة أو الخطأ
        if (e.toString().contains("تم انشاء الحساب بنجاح")) {
          // حساب تم إنشاؤه بنجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("تم إنشاء الحساب بنجاح!")),
          );

          // انتقل إلى صفحة تسجيل الدخول
          Navigator.pushNamed(
            context,
            SigninPage.routeNeme,
            arguments: {
              'message': 'تم إنشاء حسابك بنجاح! يرجى تسجيل الدخول.',
            },
          );
        } else {
          // طباعة الخطأ في حال حدوث استثناء آخر
          print("Error during registration: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("خطأ: $e")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: buildFirstNameFormField()),
                SizedBox(width: 20),
                Expanded(child: buildLastNameFormField()),
              ],
            ),
            SizedBox(height: 15),
            buildEmailFormField(),
            SizedBox(height: 20),
            buildPhoneNumFormField(),
            SizedBox(height: 20),
            buildAddressFormField(),
            SizedBox(height: 20),
            buildPassFormField(),
            SizedBox(height: 20),
            buildConfirmPassFormField(),
            SizedBox(height: 20),
            FormError(errors: errors),
            Row(
              children: [
                Checkbox(
                  value: agree,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      agree = value!;
                    });
                  },
                ),
                Text(" موافق على "),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "الشروط والأحكام",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: agree ? 1.0 : 0.5,
              child: DefualtBotton(
                text: "إنشاء حساب",
                press: agree ? _submitForm : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "الاسم الأول مطلوب";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "الاسم الأول",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.person, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "الاسم الأخير مطلوب";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "الاسم الأخير",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.person, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "البريد الإلكتروني مطلوب";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return "البريد الإلكتروني غير صالح";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "البريد الإلكتروني",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.email, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }

  TextFormField buildPhoneNumFormField() {
    return TextFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNull);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      controller: phoneNumController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "رقم الهاتف مطلوب";
        } else if (!RegExp(r'^(77|78|73)\d{7}$').hasMatch(value)) {
          return "يجب أن يكون رقم الهاتف مكونًا من 9 أرقام ويبدأ بـ 77 أو 78 أو 73";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "رقم الهاتف",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.phone, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "العنوان مطلوب";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "أدخل العنوان",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.location_city_rounded, color: kTextColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obscurePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "كلمة المرور مطلوبة";
        } else if (value.length < 8) {
          return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "أدخل كلمة المرور",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.lock, color: kTextColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: kTextColor,
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword; // تبديل حالة الإخفاء
            });
          },
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }

  // 🔹 **حقل إدخال تأكيد كلمة المرور مع زر الإظهار والإخفاء**
  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: obscureConfirmPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "تأكيد كلمة المرور مطلوب";
        } else if (value != passwordController.text) {
          return "كلمة المرور غير متطابقة";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "تأكيد كلمة المرور",
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Icon(Icons.lock, color: kTextColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: kTextColor,
          ),
          onPressed: () {
            setState(() {
              obscureConfirmPassword =
                  !obscureConfirmPassword; // تبديل حالة الإخفاء
            });
          },
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      ),
    );
  }
}
