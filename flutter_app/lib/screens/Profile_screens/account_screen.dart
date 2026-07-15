// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/home_page.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/profile_inf.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
import '../../models/UserProfile_Model/UserProfileModel.dart';
import '../../models/UserProfile_Model/getUserProfile_Api.dart';
import '../../models/item_Model/item_model.dart';
import '../login_screens/signin_page.dart';
import 'ChangePassword_Screen.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account_screen';

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<UserProfile> userProfile;
  String? _token;
  List<Item> items = [];
  final _prefsHelper = SharedPrefsHelper();
  bool isVerified = false; // حالة التوثيق

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _prefsHelper.init();
    _token = _prefsHelper.getString('access_token');
    if (_token != null) {
      userProfile = fetchUserProfile();
      await _checkVerificationStatus(); // جلب حالة التوثيق
    } else {
      Navigator.pushReplacementNamed(
        context,
        SigninPage.routeNeme,
        arguments: {
          'message': 'أنت لا تملك حساب! نرجو منك تسجيل الدخول أولاً.',
        },
      );
    }
    setState(() {});
  }

  Future<void> _checkVerificationStatus() async {
    bool status = await fetchVerificationStatusFromAPI();
    setState(() {
      isVerified = status;
    });
  }

  Future<UserProfile> fetchUserProfile() async {
    ApiService apiService = ApiService(token: _token!);
    final data = await apiService.getUserProfile();
    return UserProfile.fromJson(data);
  }

  Future<bool> fetchVerificationStatusFromAPI() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      final response = await http.get(
        Uri.parse('$baseUrl/user/verification-status'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['is_verified'] ?? false;
      } else {
        print("فشل جلب حالة التوثيق: ${response.body}");
        return false;
      }
    } catch (e) {
      print("خطأ في جلب حالة التوثيق: $e");
      return false;
    }
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تأكيد تسجيل الخروج"),
          content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // لا تسجيل خروج
              },
              child: Text("لا"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // تسجيل خروج
              },
              child: Text("نعم"),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // حذف التوكن ومعرف المستخدم
      await _prefsHelper.remove('access_token');
      await _prefsHelper.remove('user_id');

      // تفريغ الأغراض المخزنة (إن كان هناك قائمة أشياء مخزنة)
      setState(() {
        items = []; // إفراغ قائمة الأغراض
      });

      // عرض إشعار بتسجيل الخروج
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم تسجيل الخروج بنجاح")),
      );

      // التوجيه إلى صفحة تسجيل الدخول
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(token: _token!),
              ),
            ).then((_) {
              setState(() {
                userProfile = fetchUserProfile();
                _checkVerificationStatus(); // إعادة جلب حالة التوثيق بعد التعديل
              });
            });
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, ProfileInf.routeNeme);
              }),
        ],
      ),
      body: _token == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<UserProfile>(
              future: userProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("خطأ: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return _buildProfileContent(user);
                } else {
                  return const Center(child: Text("لا توجد بيانات لعرضها"));
                }
              },
            ),
    );
  }

  Widget _buildProfileContent(UserProfile user) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: AssetImage("assets/img/hints.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  // **كونتينر حالة التوثيق**
                  Container(
                    decoration: BoxDecoration(
                        color: isVerified ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isVerified ? Icons.verified : Icons.error,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          isVerified ? "الحساب موثق ✅" : "الحساب غير موثق ❌",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(height: 30, thickness: 1, color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SectionTitle(title: "الاسم الأول"),
                        // Card around the detail
                        Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                user.firstName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SectionTitle(title: "الاسم الأخير"),
                        Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                user.lastName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SectionTitle(title: "رقم الهاتف المحمول"),
                        Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                user.phone,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SectionTitle(title: "البريد الإلكتروني"),
                        Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                user.email,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SectionTitle(title: "العنوان"),
                        Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                user.address ?? "غير متوفر",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            height: 30, thickness: 1, color: Colors.grey[300]),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: kPrimaryColor),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ChangePasswordScreen.routeNeme);
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ChangePasswordScreen.routeNeme);
                              },
                              child: Text(
                                "تغيير كلمة المرور",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.logout, color: kPrimaryColor),
                              onPressed: _confirmLogout,
                            ),
                            GestureDetector(
                                onTap: _confirmLogout,
                                child: Text(
                                  "تسجيل خروج",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String token;

  const EditProfileScreen({super.key, required this.token});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = Uri.parse("$baseUrl/user");
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _firstNameController.text = data['first_name'] ?? '';
          _lastNameController.text = data['last_name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _addressController.text = data['address'] ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل في جلب البيانات")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: $e")),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد التعديل"),
          content: Text("هل أنت متأكد أنك تريد تعديل البيانات؟"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
              child: Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
                _updateProfile(); // تنفيذ التعديل
              },
              child: Text("تأكيد"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfile() async {
    final url = Uri.parse("$baseUrl/user/update");
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم تحديث البيانات بنجاح")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل تحديث البيانات")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: kSecondaryColor),
            backgroundColor: kPrimaryColor,
            title: Text(
              "تعديل البيانات",
              style: TextStyle(color: kSecondaryColor),
            )),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: "الاسم الأول",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: kTextColor),
                          gapPadding: 10,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: "الاسم الأخير",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: kTextColor),
                          gapPadding: 10,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "البريد الإلكتروني",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: kTextColor),
                          gapPadding: 10,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "رقم الهاتف",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: kTextColor),
                          gapPadding: 10,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: "العنوان",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: kTextColor),
                          gapPadding: 10,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    DefualtBotton(
                      text: "حفظ التعديلات",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _showConfirmationDialog(); // عرض مربع التأكيد
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
