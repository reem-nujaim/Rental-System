// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_signin/componenets/DefualtTopContainer.dart';
// import 'package:flutter_signin/componenets/defualt_button.dart';
// import 'package:flutter_signin/constants.dart';
// import 'package:flutter_signin/screens/addItem_Screens/ImagePickerScreen.dart';
// import 'package:flutter_signin/Database/database_helper.dart';
// import 'package:flutter_signin/models/item_Model/item_model.dart';

// class AddLocationScreen extends StatefulWidget {
//   final int itemId; // استقبال معرف العنصر
//   const AddLocationScreen({super.key, required this.itemId});
//   static String routeName = "/AddLocationScreen";

//   @override
//   State<AddLocationScreen> createState() => _AddLocationScreenState();
// }

// class _AddLocationScreenState extends State<AddLocationScreen> {
//   final DatabaseHelper dbHelper = DatabaseHelper();
//   final _formKey = GlobalKey<FormState>(); // مفتاح النموذج للتحقق

//   // إضافة TextEditingController لكل حقل إدخال
//   final TextEditingController cityController = TextEditingController();

//   @override
//   void dispose() {
//     // تنظيف الـ Controllers عند إغلاق الصفحة
//     cityController.dispose();
//     super.dispose();
//   }

//   Future<void> saveLocationDetails() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final items = await dbHelper.getItems();
//         final item = items.firstWhere((item) => item.id == widget.itemId);

//         Item updatedItem = item.copyWith(
//           location: cityController.text,
//         );

//         await dbHelper.updateItem(updatedItem);
//         Navigator.pushNamed(context, ImagePickerScreen.routeNeme,
//             arguments: updatedItem.id);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("حدث خطأ أثناء حفظ البيانات: $e")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection:
//           TextDirection.rtl, // تغيير الاتجاه إلى من اليمين إلى اليسار
//       child: Scaffold(
//         appBar: DefualtTopAppBar(),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DefualtTopContainer(text: " أضف موقعك"),
//                   // حقل إدخال المدينة
//                   TextFormField(
//                     controller: cityController,
//                     decoration: InputDecoration(
//                       labelText: "المدينة",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       prefixIcon: const Icon(Icons.location_city),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "يرجى إدخال اسم المدينة";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 200),

//                   DefualtBotton(
//                     text: "أضف صورة الغرض",
//                     press: saveLocationDetails,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class LocationPickerScreen extends StatefulWidget {
// //   @override
// //   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// // }

// // class _LocationPickerScreenState extends State<LocationPickerScreen> {
// //   GoogleMapController? _mapController;
// //   LatLng _currentLocation = LatLng(15.3694, 44.1910); // افتراضياً صنعاء

// //   void _onMapCreated(GoogleMapController controller) {
// //     _mapController = controller;
// //   }

// //   void _saveLocation() {
// //     // قم بتنفيذ الإجراء الخاص بالحفظ هنا
// //     print("تم حفظ الموقع: $_currentLocation");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Text(
// //             "تحديد الموقع على الخريطة",
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             textAlign: TextAlign.center,
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //           child: Text(
// //             "في حال اختلاف موقعك الحالي عن موقع التوصيل، يرجى تحديد الموقع الخاص بك بالضغط على الخريطة التالية",
// //             style: TextStyle(fontSize: 14, color: Colors.grey),
// //             textAlign: TextAlign.center,
// //           ),
// //         ),
// //         Expanded(
// //           child: GoogleMap(
// //             onMapCreated: _onMapCreated,
// //             initialCameraPosition: CameraPosition(
// //               target: _currentLocation,
// //               zoom: 14.0,
// //             ),
// //             onTap: (LatLng location) {
// //               setState(() {
// //                 _currentLocation = location;
// //               });
// //             },
// //             markers: {
// //               Marker(
// //                 markerId: MarkerId("selected_location"),
// //                 position: _currentLocation,
// //               ),
// //             },
// //           ),
// //         ),
// //         Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: ElevatedButton(
// //             onPressed: _saveLocation,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.red,
// //               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
// //             ),
// //             child: Text(
// //               "حفظ",
// //               style: TextStyle(fontSize: 18, color: Colors.white),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/addItem_Screens/ImagePickerScreen.dart';
import 'package:provider/provider.dart';

import '../../provider/item_provider.dart';

class AddLocationScreen extends StatelessWidget {
  static String routeName = "/addlocation_screen";
  final _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("أضف الموقع"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "الموقع",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: itemProvider.selectedDeliveryMethod,
              items: ['self', 'courier']
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method == 'self'
                            ? 'توصيل ذاتي'
                            : 'توصيل عبر خدمة التوصيل'),
                      ))
                  .toList(),
              onChanged: (value) => itemProvider.setDeliveryMethod(value!),
              decoration: InputDecoration(
                labelText: "طريقة التوصيل",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_locationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("الرجاء إدخال الموقع")),
                  );
                  return;
                }
                itemProvider.setLocation(_locationController.text);
                Navigator.pushNamed(context, AddImagesScreen.routeName);
              },
              child: Text("التالي"),
            ),
          ],
        ),
      ),
    );
  }
}
