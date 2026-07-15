// // // import 'package:flutter/material.dart';
// // // import 'dart:io';

// // // class ReviewScreen extends StatelessWidget {
// // // static String routeName = "/ReviewScreen";
// // //   final String categoryId;
// // //   final String itemName;
// // //   final String itemDescription;
// // //   final String price;
// // //   final String status;
// // //   final String deliveryMethod;
// // //   final List<File> images;

// // //   const ReviewScreen({
// // //     Key? key,
// // //     required this.categoryId,
// // //     required this.itemName,
// // //     required this.itemDescription,
// // //     required this.price,
// // //     required this.status,
// // //     required this.deliveryMethod,
// // //     required this.images,
// // //   }) : super(key: key);

// // //   void _submitData(BuildContext context) {
// // //     // هنا يمكنك تنفيذ API لإرسال البيانات إلى السيرفر
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text("تم إرسال الغرض بنجاح!")),
// // //     );
// // //     Navigator.popUntil(context, (route) => route.isFirst);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text("مراجعة التفاصيل")),
// // //       body: Padding(
// // //         padding: EdgeInsets.all(16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text("الفئة: $categoryId", style: TextStyle(fontSize: 16)),
// // //             Text("الاسم: $itemName", style: TextStyle(fontSize: 16)),
// // //             Text("الوصف: $itemDescription", style: TextStyle(fontSize: 16)),
// // //             Text("السعر: $price", style: TextStyle(fontSize: 16)),
// // //             Text("الحالة: $status", style: TextStyle(fontSize: 16)),
// // //             Text("طريقة التوصيل: $deliveryMethod",
// // //                 style: TextStyle(fontSize: 16)),
// // //             SizedBox(height: 16),
// // //             Text("الصور:",
// // //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// // //             SizedBox(height: 8),
// // //             images.isEmpty
// // //                 ? Text("لم يتم إضافة صور")
// // //                 : SizedBox(
// // //                     height: 100,
// // //                     child: ListView.builder(
// // //                       scrollDirection: Axis.horizontal,
// // //                       itemCount: images.length,
// // //                       itemBuilder: (context, index) {
// // //                         return Padding(
// // //                           padding: EdgeInsets.only(right: 8),
// // //                           child: Image.file(images[index],
// // //                               width: 100, height: 100, fit: BoxFit.cover),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),
// // //             SizedBox(height: 16),
// // //             ElevatedButton(
// // //               onPressed: () => _submitData(context),
// // //               child: Text("إرسال"),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'dart:io';

// // import 'package:flutter/material.dart';

// // class ReviewScreen extends StatelessWidget {
// // static String routeName = "/ReviewScreen";
// //   final String categoryId;
// //   final String itemName;
// //   final String itemDescription;
// //   final String quantity;
// //   final String priceAssurance;
// //   final String pricePerHour;
// //   final String pricePerDay;
// //   final String status;
// //   final String deliveryMethod;
// //   final String location;
// //   final String minRentalDuration;
// //   final String maxRentalDuration;
// //   final String availabilityHours;
// //   final List<String> imagePaths;

// //   const ReviewScreen({
// //     Key? key,
// //     required this.categoryId,
// //     required this.itemName,
// //     required this.itemDescription,
// //     required this.quantity,
// //     required this.priceAssurance,
// //     required this.pricePerHour,
// //     required this.pricePerDay,
// //     required this.status,
// //     required this.deliveryMethod,
// //     required this.location,
// //     required this.minRentalDuration,
// //     required this.maxRentalDuration,
// //     required this.availabilityHours,
// //     required this.imagePaths,
// //   }) : super(key: key);

// //   void submitItem() {
// //     final Map<String, dynamic> itemData = {
// //       "category_id": categoryId,
// //       "name": itemName,
// //       "description": itemDescription,
// //       "quantity": quantity,
// //       "price_assurance": priceAssurance,
// //       "price_per_hour": pricePerHour,
// //       "price_per_day": pricePerDay,
// //       "status": status,
// //       "delivery_method": deliveryMethod,
// //       "location": location,
// //       "min_rental_duration": minRentalDuration,
// //       "max_rental_duration": maxRentalDuration,
// //       "availability_hours": availabilityHours,
// //       "available": true,
// //       "user_id": "123", // اجلب user_id الفعلي هنا
// //       "images": imagePaths,
// //     };

// //     print("📤 إرسال البيانات إلى API:");
// //     print(itemData);
// //     // هنا يتم استدعاء API لإرسال البيانات
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("مراجعة الغرض")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text("اسم الغرض: $itemName",
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               SizedBox(height: 8),
// //               Text("الوصف: $itemDescription"),
// //               SizedBox(height: 8),
// //               Text("الكمية: $quantity"),
// //               Text("السعر التأميني: $priceAssurance"),
// //               Text("السعر بالساعة: $pricePerHour"),
// //               Text("السعر باليوم: $pricePerDay"),
// //               Text("الحالة: $status"),
// //               Text("طريقة التوصيل: $deliveryMethod"),
// //               Text("الموقع: $location"),
// //               Text("أقل مدة تأجير: $minRentalDuration ساعة"),
// //               Text("أقصى مدة تأجير: $maxRentalDuration ساعة"),
// //               Text("ساعات التوفر: $availabilityHours"),
// //               Text("متاح: نعم"),
// //               SizedBox(height: 16),
// //               Wrap(
// //                 children: imagePaths
// //                     .map((path) =>
// //                         Image.file(File(path), width: 100, height: 100))
// //                     .toList(),
// //               ),
// //               SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: submitItem,
// //                 child: Text("إرسال"),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../../core/api_service.dart';

// class ReviewScreen extends StatelessWidget {
//   static String routeName = "/review_screen";
//   final String categoryId;
//   final String itemName;
//   final String itemDescription;
//   final String quantity;
//   final String priceAssurance;
//   final String pricePerHour;
//   final String pricePerDay;
//   final String status;
//   final String deliveryMethod;
//   final String location;
//   final String minRentalDuration;
//   final String maxRentalDuration;
//   final String availabilityHours;
//   final int userId;
//   final List<String> images;

//   const ReviewScreen({
//     Key? key,
//     required this.categoryId,
//     required this.itemName,
//     required this.itemDescription,
//     required this.quantity,
//     required this.priceAssurance,
//     required this.pricePerHour,
//     required this.pricePerDay,
//     required this.status,
//     required this.deliveryMethod,
//     required this.location,
//     required this.minRentalDuration,
//     required this.maxRentalDuration,
//     required this.availabilityHours,
//     required this.userId,
//     required this.images,
//   }) : super(key: key);

// // استيراد مكتبة JSON

// // Future<void> _submitItem(BuildContext context) async {
// //   // التأكد من أن الحقول غير فارغة ومهيأة بشكل صحيح
// //   final Map<String, dynamic> newItem = {
// //     "name": itemName,
// //     "description": itemDescription,
// //     "images": jsonEncode(images), // تحويل الصور إلى JSON String
// //     "status": status,
// //     "price_assurance": double.tryParse(priceAssurance) ?? 0.0, // إذا كانت فارغة نضع قيمة افتراضية
// //     "price_per_hour": double.tryParse(pricePerHour) ?? 0.0,
// //     "price_per_day": double.tryParse(pricePerDay) ?? 0.0,
// //     "category_id": int.tryParse(categoryId) ?? 0, // التأكد من أن category_id صحيح
// //     "delivery_method": deliveryMethod.isNotEmpty ? deliveryMethod : "self", // التأكد من أن طريقة التوصيل ليست فارغة
// //     "location": location,
// //     "min_rental_duration": int.tryParse(minRentalDuration) ?? 0,
// //     "max_rental_duration": int.tryParse(maxRentalDuration) ?? 0,
// //     "availability_hours": int.tryParse(availabilityHours) ?? 0,
// //     "quantity": int.tryParse(quantity) ?? 1, // التأكد من الكمية
// //     "user_id": userId > 0 ? userId : 1, // التأكد من أن user_id صحيح
// //     "available": true, // هذا يتم إرساله تلقائيًا
// //   };

// //   // طباعة البيانات قبل الإرسال لفحصها
// //   print("🛠️ البيانات المرسلة: ${jsonEncode(newItem)}");

// //   // إرسال البيانات إلى API
// //   bool success = await ApiService.addItem(newItem);

// //   // التعامل مع الاستجابة
// //   if (success) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text("تمت إضافة الغرض بنجاح!")),
// //     );
// //     Navigator.popUntil(context, ModalRoute.withName('/'));
// //   } else {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text("حدث خطأ أثناء الإضافة!")),
// //     );
// //   }
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("مراجعة التفاصيل")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("اسم الغرض: $itemName"),
//             Text("الوصف: $itemDescription"),
//             Text("الكمية: $quantity"),
//             Text("السعر التأميني: $priceAssurance"),
//             Text("السعر بالساعة: $pricePerHour"),
//             Text("السعر باليوم: $pricePerDay"),
//             Text("حالة الغرض: $status"),
//             Text("طريقة التوصيل: $deliveryMethod"),
//             Text("الموقع: $location"),
//             Text("الحد الأدنى للإيجار: $minRentalDuration"),
//             Text("الحد الأقصى للإيجار: $maxRentalDuration"),
//             Text("ساعات التوفر: $availabilityHours"),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {}, //() => _submitItem(context),
//               child: const Text("تأكيد الإضافة"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/item_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatelessWidget {
  static String routeName = "/ReviewScreen";

  Future<void> _submitItem(BuildContext context) async {
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final userId = prefs.getString('user_id');

    if (token == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في المصادقة")),
      );
      return;
    }

    final item = {
      "name": itemProvider.itemName,
      "description": itemProvider.itemDescription,
      "images": jsonEncode(itemProvider.imagePaths),
      "status": itemProvider.selectedStatus,
      "available": true,
      "location": itemProvider.location,
      "price_assurance": itemProvider.priceAssurance,
      "delivery_method": itemProvider.selectedDeliveryMethod,
      "price_per_hour": itemProvider.pricePerHour,
      "price_per_day": itemProvider.pricePerDay,
      "quantity": itemProvider.quantity,
      "min_rental_duration": itemProvider.minRentalDuration,
      "max_rental_duration": itemProvider.maxRentalDuration,
      "availability_hours": itemProvider.availabilityHours,
      "user_id": userId,
      "category_id": itemProvider.selectedCategory,
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.47.1:8000/api/items'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(item),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تمت إضافة الغرض بنجاح!")),
        );
        itemProvider.resetData(); // إعادة تعيين البيانات
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل في إضافة الغرض: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في الشبكة: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("مراجعة البيانات"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("الاسم: ${itemProvider.itemName}"),
            Text("الوصف: ${itemProvider.itemDescription}"),
            Text("الحالة: ${itemProvider.selectedStatus}"),
            Text("الكمية: ${itemProvider.quantity}"),
            Text("الحد الأدنى للإيجار: ${itemProvider.minRentalDuration} أيام"),
            Text("الحد الأقصى للإيجار: ${itemProvider.maxRentalDuration} أيام"),
            Text("ساعات التوافر: ${itemProvider.availabilityHours}"),
            Text("مبلغ التأمين: ${itemProvider.priceAssurance}"),
            Text("السعر في الساعة: ${itemProvider.pricePerHour}"),
            Text("السعر في اليوم: ${itemProvider.pricePerDay}"),
            Text("الموقع: ${itemProvider.location}"),
            Text("طريقة التوصيل: ${itemProvider.selectedDeliveryMethod}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitItem(context),
              child: Text("إرسال"),
            ),
          ],
        ),
      ),
    );
  }
}
