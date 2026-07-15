// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/profile_inf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyItemsScreen extends StatefulWidget {
  static String routeName = "/my_items";

  const MyItemsScreen({super.key});

  @override
  _MyItemsScreenState createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {
  List items = [];
  bool isLoading = true;
  bool isLoggedOut = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final userId = prefs.getInt('user_id');

    if (token == null || userId == null) {
      setState(() {
        isLoggedOut = true;
        isLoading = false;
      });
    } else {
      fetchUserItems();
    }
  }

  Future<void> fetchUserItems() async {
    int? userId = await getUserId();
    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('$baseUrl/items/user/$userId');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          items = data['data'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteItem(int itemId) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد الحذف"),
          content: Text("هل أنت متأكد من أنك تريد حذف هذا العنصر؟"),
          actions: <Widget>[
            TextButton(
                child: Text("إلغاء"),
                onPressed: () => Navigator.of(context).pop(false)),
            TextButton(
                child: Text("حذف"),
                onPressed: () => Navigator.of(context).pop(true)),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final url = Uri.parse('$baseUrl/items/$itemId');
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        final response = await http.delete(
          url,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            items.removeWhere((item) => item['id'] == itemId);
          });
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, ProfileInf.routeNeme);
                }),
          ],
          title: Text("أغراضي",
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold)),
          backgroundColor: kPrimaryColor,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isLoggedOut
                ? Center(child: Text("لا يوجد أغراض مضافة"))
                : items.isEmpty
                    ? Center(child: Text("لا يوجد أغراض مضافة"))
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            color: Colors.grey[100],
                            elevation: 3,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                // التوجه إلى شاشة التفاصيل
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetailsScreen(item: item),
                                  ),
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                leading: (item['images'] != null &&
                                        item['images'].isNotEmpty)
                                    ? (() {
                                        List<dynamic> imagesList = [];
                                        try {
                                          imagesList =
                                              jsonDecode(item['images']);
                                        } catch (e) {
                                          print("خطأ في فك ترميز الصور: $e");
                                        }

                                        return (imagesList.isNotEmpty)
                                            ? Image.network(
                                                '$baseUrl/${imagesList.first}', // تجنب الخطأ عند كون القائمة فارغة
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                      Icons.image_not_supported,
                                                      size: 80,
                                                      color: Colors.grey);
                                                },
                                              )
                                            : Icon(Icons.image_not_supported,
                                                size: 80, color: Colors.grey);
                                      }())
                                    : Icon(Icons.image_not_supported,
                                        size: 80, color: Colors.grey),
                                title: Text(item['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle:
                                    Text("السعر: ${item['price_per_day']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: kPrimaryColor),
                                      onPressed: () {
                                        // التوجه إلى شاشة تعديل البيانات
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditItemScreen(item: item),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => deleteItem(item['id']),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}

// شاشة تفاصيل الغرض

class ItemDetailsScreen extends StatelessWidget {
  final dynamic item;

  const ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, ProfileInf.routeNeme);
              },
            ),
          ],
          title: Text(
            item['name'],
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  _buildInfoCard("الوصف", item['description'],
                      Icons.description, Colors.blue),
                  _buildInfoCard("السعر", "${item['price_per_day']} ريال/يوم",
                      Icons.attach_money, Colors.green),
                  _buildInfoCard("الحالة", item['status'], Icons.check_circle,
                      Colors.orange),
                  _buildInfoCard("طريقة التوصيل", item['delivery_method'],
                      Icons.local_shipping, Colors.purple),
                  _buildInfoCard("الكمية", "${item['quantity']}",
                      Icons.format_list_numbered, Colors.red),
                  _buildInfoCard("الموقع", item['location'], Icons.location_on,
                      Colors.teal),
                  _buildInfoCard(
                      "مدة الإيجار",
                      "من ${item['min_rental_duration']} إلى ${item['max_rental_duration']} يوم",
                      Icons.timer,
                      Colors.indigo),
                  _buildInfoCard("ساعات التوفر", item['availability_hours'],
                      Icons.access_time, Colors.brown),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, dynamic value, IconData icon, Color iconColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // الأيقونة الملونة
            Icon(icon, color: iconColor, size: 28),
            SizedBox(width: 16),
            // النص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 8),
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
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

// class ItemDetailsScreen extends StatelessWidget {
//   final dynamic item;

//   const ItemDetailsScreen({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl, // لضبط اتجاه النصوص لليمين
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
//                 onPressed: () {
//                   Navigator.pushNamed(context, ProfileInf.routeNeme);
//                 }),
//           ],
//           title: Text(
//             item['name'],
//             style: TextStyle(color: kSecondaryColor),
//           ),
//           backgroundColor: kPrimaryColor,
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: 16.0, vertical: 20), // تعديل الحواف
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start, // للتأكد من محاذاة النصوص بشكل صحيح
//             children: [
//               // لإضافة صورة (إذا كانت موجودة)
//               // Image.network("$baseUrl/${item['images'][0]}"),
//               SizedBox(height: 16),
//               Text("الوصف: ${item['description']}",
//                   textAlign: TextAlign.right), // ضبط المحاذاة لليمين
//               SizedBox(height: 12), // زيادة المسافة
//               Text("السعر: ${item['price_per_day']} ريال",
//                   textAlign: TextAlign.right),
//               SizedBox(height: 12),
//               Text("الحالة: ${item['status']}", textAlign: TextAlign.right),
//               SizedBox(height: 12),
//               Text("طريقة التوصيل: ${item['delivery_method']}",
//                   textAlign: TextAlign.right),
//               SizedBox(height: 12),
//               Text("الكمية: ${item['quantity']}", textAlign: TextAlign.right),
//               SizedBox(height: 12),
//               Text("الموقع: ${item['location']}", textAlign: TextAlign.right),
//               SizedBox(height: 12),
//               Text(
//                 "مدة الإيجار: من ${item['min_rental_duration']} إلى ${item['max_rental_duration']} يوم",
//                 textAlign: TextAlign.right,
//               ),
//               SizedBox(height: 12),
//               Text("ساعات التوفر: ${item['availability_hours']}",
//                   textAlign: TextAlign.right),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// شاشة تعديل الغرض
class EditItemScreen extends StatefulWidget {
  final dynamic item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceAssuranceController = TextEditingController();
  final _pricePerHourController = TextEditingController();
  final _pricePerDayController = TextEditingController();
  final _quantityController = TextEditingController();
  final _minRentalDurationController = TextEditingController();
  final _maxRentalDurationController = TextEditingController();
  final _availabilityHoursController = TextEditingController();

  String? selectedCategory;
  String? selectedStatus;
  String? selectedDeliveryMethod;

  @override
  void initState() {
    super.initState();
    // التحقق من القيم null عند إعداد البيانات في initState
    _nameController.text = widget.item['name'] ?? '';
    _descriptionController.text = widget.item['description'] ?? '';
    _locationController.text = widget.item['location'] ?? '';
    _priceAssuranceController.text =
        widget.item['price_assurance']?.toString() ?? '';
    _pricePerHourController.text =
        widget.item['price_per_hour']?.toString() ?? '';
    _pricePerDayController.text =
        widget.item['price_per_day']?.toString() ?? '';
    _quantityController.text = widget.item['quantity']?.toString() ?? '';
    _minRentalDurationController.text =
        widget.item['min_rental_duration']?.toString() ?? '';
    _maxRentalDurationController.text =
        widget.item['max_rental_duration']?.toString() ?? '';
    _availabilityHoursController.text =
        widget.item['availability_hours']?.toString() ?? '';

    selectedCategory = widget.item['category_id']?.toString();
    selectedStatus = widget.item['status'] ?? '';
    selectedDeliveryMethod = widget.item['delivery_method'] ?? '';
  }

  Future<void> editItem(int itemId, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/items/$itemId');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      // إزالة الصور إذا لم يتم تعديلها
      if (updatedData['images'] == null || updatedData['images'].isEmpty) {
        updatedData.remove('images');
      }

      final jsonData = jsonEncode(updatedData);
      print("Sending data: $jsonData");

      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonData,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // رسالة تأكيد
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تم التعديل بنجاح'),
              content: Text('تم تحديث بيانات الغرض بنجاح.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // إغلاق مربع الحوار
                    Navigator.pop(context, true); // العودة إلى الشاشة السابقة
                  },
                  child: Text('موافق'),
                ),
              ],
            );
          },
        );
      } else {
        print("فشل في التعديل: ${response.body}");
      }
    } catch (e) {
      print("خطأ في الاتصال: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, ProfileInf.routeNeme);
                }),
          ],
          title: Text(
            "تعديل الغرض",
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                _buildTextField(_nameController, 'الاسم'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(_descriptionController, 'الوصف'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(_locationController, 'الموقع'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(_availabilityHoursController, 'ساعات التوفر'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField(_quantityController, 'الكمية')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: _buildTextField(
                            _priceAssuranceController, "مبلغ التأمين")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField(
                            _pricePerHourController, 'السعر لكل ساعة')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: _buildTextField(
                            _pricePerDayController, 'السعر لكل يوم')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                          _minRentalDurationController, 'أدنى مدة للإيجار'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: _buildTextField(
                          _maxRentalDurationController, 'أقصى مدة للإيجار'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DefualtBotton(
                  text: 'حفظ التعديلات',
                  press: () {
                    final updatedData = {
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'location': _locationController.text,
                      'price_assurance':
                          double.tryParse(_priceAssuranceController.text) ??
                              0.0,
                      'price_per_hour':
                          double.tryParse(_pricePerHourController.text) ?? 0.0,
                      'price_per_day':
                          double.tryParse(_pricePerDayController.text) ?? 0.0,
                      'quantity': int.tryParse(_quantityController.text) ?? 0,
                      'min_rental_duration':
                          int.tryParse(_minRentalDurationController.text) ?? 0,
                      'max_rental_duration':
                          int.tryParse(_maxRentalDurationController.text) ?? 0,
                      'availability_hours':
                          int.tryParse(_availabilityHoursController.text) ?? 0,
                      'status': selectedStatus,
                      'delivery_method': selectedDeliveryMethod,
                    };

                    print("Updated Data: $updatedData");

                    editItem(widget.item['id'], updatedData);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to create TextField with a given controller and label
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
