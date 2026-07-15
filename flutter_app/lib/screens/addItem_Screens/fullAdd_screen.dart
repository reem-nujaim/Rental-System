// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
import 'components/defualthelpContainer.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['ar_name'] ?? 'Unnamed Category',
    );
  }
}

class FulladdScreen extends StatefulWidget {
  static String routeName = "/fullAdd_screen";

  const FulladdScreen({super.key});
  @override
  _FulladdScreenState createState() => _FulladdScreenState();
}

class _FulladdScreenState extends State<FulladdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceAssuranceController =
      TextEditingController();
  final TextEditingController _pricePerHourController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minRentalDurationController =
      TextEditingController();
  final TextEditingController _maxRentalDurationController =
      TextEditingController();
  final TextEditingController _availabilityHoursController =
      TextEditingController();

  String? selectedStatus;
  String? selectedDeliveryMethod;
  String? selectedCategory;
  List<String> imagePaths = [];
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categories = data.map((json) => Category.fromJson(json)).toList();
          if (categories.isNotEmpty) {
            selectedCategory = categories.first.id.toString();
          }
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading categories: $e")),
      );
    }
  }

  Future<void> pickImages() async {
    if (imagePaths.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يمكنك اختيار 5 صور فقط!")),
      );
      return;
    }

    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        for (var file in pickedFiles) {
          if (imagePaths.length < 5 && !imagePaths.contains(file.path)) {
            imagePaths.add(file.path);
          }
        }
      });
    }

    if (imagePaths.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("لقد وصلت إلى الحد الأقصى للصور!")),
      );
    }
  }

  Widget buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: pickImages,
          child: Text("اختر الصور (${imagePaths.length}/5)"),
        ),
        SizedBox(height: 10),
        if (imagePaths.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imagePaths[index]),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          imagePaths.removeAt(index); // حذف الصورة من القائمة
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12,
                        child: Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  Future<List<String>> convertImagesToBase64(List<String> paths) async {
    List<String> base64Images = [];
    for (String path in paths) {
      File imageFile = File(path);
      if (await imageFile.exists()) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64String = base64Encode(imageBytes);
        base64Images.add(base64String);
      }
    }
    return base64Images;
  }

  // دالة لإضافة الغرض
  // ✅ تحديث التحقق عند إضافة الغرض
  Future<void> addItem() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى اختيار الفئة")),
      );
      return;
    }

    if (imagePaths.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى إضافة صورة واحدة على الأقل")),
      );
      return;
    }

    int minRental = int.tryParse(_minRentalDurationController.text) ?? 1;
    int maxRental = int.tryParse(_maxRentalDurationController.text) ?? 1;

    if (minRental > maxRental) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "الحد الأدنى للإيجار لا يمكن أن يكون أكبر من الحد الأقصى")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final userId = await SharedPrefsHelper().getUserID();

    if (token == null || userId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("خطأ في تسجيل الدخول")));
      return;
    }
    final pricePerHour = double.tryParse(_pricePerHourController.text) ?? 0.0;
    final pricePerDay = double.tryParse(_pricePerDayController.text) ?? 0.0;
    final item = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "images": jsonEncode(await convertImagesToBase64(imagePaths)),
      "status": selectedStatus,
      "available": false,
      "admin_approval": false,
      "location": _locationController.text,
      "price_assurance": double.tryParse(_priceAssuranceController.text) ?? 0.0,
      "delivery_method": selectedDeliveryMethod,
      "price_per_hour": pricePerHour + 500, // إضافة 500 للسعر في الساعة
      "price_per_day": pricePerDay + 500, // إضافة 500 للسعر في اليوم
      "quantity": int.tryParse(_quantityController.text) ?? 1,
      "min_rental_duration": minRental,
      "max_rental_duration": maxRental,
      "availability_hours":
          int.tryParse(_availabilityHoursController.text) ?? 0,
      "user_id": userId,
      "category_id": int.parse(selectedCategory!),
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/items'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(item),
      );

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("نجاح"),
              content: Text("تمت إضافة الغرض بنجاح!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("موافق"),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل في إضافة الغرض: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("خطأ في الشبكة: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSecondaryColor),
          title: Text(
            "أضف غرضك",
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  defualthelpContainer(
                    tips: [
                      "نوصي ألا يتجاوز سعر الإيجار اليومي 10% من السعر الأصلي للغرض",
                      "ضع سعرًا يتنافس مع الأغراض المماثلة في فئتك",
                      "لا تضع سعر مرتفع وتذكر أن غرضك ممكن أن يكون مستخدم وليس جديدًا",
                      "نشجعك على تقديم عروضات على السعر الأسبوعي والشهري",
                      "سيتم إضافة رسوم على السعر لتغطية نفقات الدفع والتحويلات",
                    ],
                    imagePath: 'assets/img/hints.png',
                    icons: [
                      Icons.check,
                      Icons.check,
                      Icons.check,
                      Icons.check,
                      Icons.money,
                    ],
                    title: 'نصائح بسيطة من شأنها تحسين عرضك',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  methodTextFormField(
                      "الاسم", _nameController, TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  methodTextFormField(
                      "وصف الغرض", _descriptionController, TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  methodTextFormField(
                      "الموقع", _locationController, TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  methodTextFormField("مبلغ التأمين", _priceAssuranceController,
                      TextInputType.number),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: methodTextFormField("السعر في الساعة",
                            _pricePerHourController, TextInputType.number),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: methodTextFormField("السعر في اليوم",
                            _pricePerDayController, TextInputType.number),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  methodTextFormField(
                      "الكمية", _quantityController, TextInputType.number),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: methodTextFormField(
                            "الحد الأدنى للإيجار (بالأيام)",
                            _minRentalDurationController,
                            TextInputType.number),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: methodTextFormField(
                            "الحد الأقصى للإيجار (بالأيام)",
                            _maxRentalDurationController,
                            TextInputType.number),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  methodTextFormField("ساعات التوافر",
                      _availabilityHoursController, TextInputType.number),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedStatus,
                          items: [
                            'excellent',
                            'good',
                            'acceptable',
                            'barely used'
                          ]
                              .map((status) => DropdownMenuItem(
                                  value: status, child: Text(status)))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedStatus = value!),
                          decoration: InputDecoration(labelText: "حالة الغرض"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedDeliveryMethod,
                          items: ['self', 'courier']
                              .map((method) => DropdownMenuItem(
                                  value: method, child: Text(method)))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedDeliveryMethod = value!),
                          decoration:
                              InputDecoration(labelText: "طريقة التوصيل"),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          hint: Text("أختر الفئة"),
                          items: categories
                              .map((category) => DropdownMenuItem(
                                    value: category.id.toString(),
                                    child: Text(category.name),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedCategory = value),
                          decoration: InputDecoration(labelText: "الفئة"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildImagePicker(),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 15,
                  ),
                  DefualtBotton(text: "إضف غرضك", press: addItem),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField methodTextFormField(String label,
      TextEditingController controller, TextInputType keyboardType) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "هذا الحقل مطلوب";
        }

        // التحقق من الحقول الرقمية
        if (keyboardType == TextInputType.number ||
            keyboardType == TextInputType.numberWithOptions(decimal: true)) {
          final numValue = num.tryParse(value);
          if (numValue == null) {
            return "يجب إدخال رقم صالح";
          }
          if (numValue <= 0) {
            return "يجب أن يكون الرقم أكبر من الصفر";
          }
        }

        return null; // ✅ الإدخال صحيح
      },
    );
  }
}
