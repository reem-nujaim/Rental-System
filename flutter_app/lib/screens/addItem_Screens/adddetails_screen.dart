// // import 'package:flutter/material.dart';

// // import 'ImagePickerScreen.dart'; // استدعاء الشاشة التالية

// // class AvailabilityScreen extends StatefulWidget {
// // static String routeName = "/adddetails_screen";
// //   final String categoryId;
// //   final String itemName;
// //   final String itemDescription;
// //   final String price;

// //   const AvailabilityScreen({
// //     Key? key,
// //     required this.categoryId,
// //     required this.itemName,
// //     required this.itemDescription,
// //     required this.price,
// //   }) : super(key: key);

// //   @override
// //   _AvailabilityScreenState createState() => _AvailabilityScreenState();
// // }

// // class _AvailabilityScreenState extends State<AvailabilityScreen> {
// //   String selectedStatus = 'excellent';
// //   String selectedDeliveryMethod = 'self';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("التوفر والتوصيل")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             DropdownButtonFormField<String>(
// //               value: selectedStatus,
// //               onChanged: (value) => setState(() => selectedStatus = value!),
// //               items: [
// //                 DropdownMenuItem(value: 'excellent', child: Text("ممتاز")),
// //                 DropdownMenuItem(value: 'good', child: Text("جيد")),
// //                 DropdownMenuItem(value: 'acceptable', child: Text("مقبول")),
// //                 DropdownMenuItem(
// //                     value: 'barely used', child: Text("بالكاد مستخدم")),
// //               ],
// //               decoration: InputDecoration(labelText: "حالة الغرض"),
// //             ),
// //             SizedBox(height: 16),
// //             DropdownButtonFormField<String>(
// //               value: selectedDeliveryMethod,
// //               onChanged: (value) =>
// //                   setState(() => selectedDeliveryMethod = value!),
// //               items: [
// //                 DropdownMenuItem(value: 'self', child: Text("توصيل ذاتي")),
// //                 DropdownMenuItem(
// //                     value: 'courier', child: Text("توصيل عبر شركة")),
// //               ],
// //               decoration: InputDecoration(labelText: "طريقة التوصيل"),
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ImageUploadScreen(
// //                       categoryId: widget.categoryId,
// //                       itemName: widget.itemName,
// //                       itemDescription: widget.itemDescription,
// //                       price: widget.price,
// //                       status: selectedStatus,
// //                       deliveryMethod: selectedDeliveryMethod,
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: Text("التالي"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
// import 'ImagePickerScreen.dart';

// class AvailabilityScreen extends StatefulWidget {
//   static String routeName = "/adddetails_screen";
//   final String categoryId;
//   final String itemName;
//   final String itemDescription;
//   final String quantity;
//   final String priceAssurance;
//   final String pricePerHour;
//   final String pricePerDay;

//   const AvailabilityScreen({
//     Key? key,
//     required this.categoryId,
//     required this.itemName,
//     required this.itemDescription,
//     required this.quantity,
//     required this.priceAssurance,
//     required this.pricePerHour,
//     required this.pricePerDay,
//   }) : super(key: key);

//   @override
//   _AvailabilityScreenState createState() => _AvailabilityScreenState();
// }

// class _AvailabilityScreenState extends State<AvailabilityScreen> {
//   final _formKey = GlobalKey<FormState>();

//   String selectedStatus = 'excellent';
//   String selectedDeliveryMethod = 'self';
//   String location = '';
//   String minRentalDuration = '';
//   String maxRentalDuration = '';
//   String availabilityHours = '';
//   int? userId;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserId();
//   }

//   Future<void> _fetchUserId() async {
//     int? fetchedUserId = await SharedPrefsHelper().getUserId();
//     setState(() {
//       userId = fetchedUserId;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("التوفر والتوصيل")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               DropdownButtonFormField<String>(
//                 value: selectedStatus,
//                 onChanged: (value) => setState(() => selectedStatus = value!),
//                 items: const [
//                   DropdownMenuItem(value: 'excellent', child: Text("ممتاز")),
//                   DropdownMenuItem(value: 'good', child: Text("جيد")),
//                   DropdownMenuItem(value: 'acceptable', child: Text("مقبول")),
//                   DropdownMenuItem(
//                       value: 'barely used', child: Text("بالكاد مستخدم")),
//                 ],
//                 decoration: const InputDecoration(labelText: "حالة الغرض"),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 value: selectedDeliveryMethod,
//                 onChanged: (value) =>
//                     setState(() => selectedDeliveryMethod = value!),
//                 items: const [
//                   DropdownMenuItem(value: 'self', child: Text("توصيل ذاتي")),
//                   DropdownMenuItem(
//                       value: 'courier', child: Text("توصيل عبر شركة")),
//                 ],
//                 decoration: const InputDecoration(labelText: "طريقة التوصيل"),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "الموقع"),
//                 onSaved: (value) => location = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال الموقع" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                     labelText: "الحد الأدنى لمدة الإيجار (بالساعات)"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => minRentalDuration = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال الحد الأدنى للإيجار" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                     labelText: "الحد الأقصى لمدة الإيجار (بالساعات)"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => maxRentalDuration = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال الحد الأقصى للإيجار" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "ساعات التوفر"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => availabilityHours = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال ساعات التوفر" : null,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ImageUploadScreen(
//                           categoryId: widget.categoryId,
//                           itemName: widget.itemName,
//                           itemDescription: widget.itemDescription,
//                           quantity: widget.quantity,
//                           priceAssurance: widget.priceAssurance,
//                           pricePerHour: widget.pricePerHour,
//                           pricePerDay: widget.pricePerDay,
//                           status: selectedStatus,
//                           deliveryMethod: selectedDeliveryMethod,
//                           location: location,
//                           minRentalDuration: minRentalDuration,
//                           maxRentalDuration: maxRentalDuration,
//                           availabilityHours: availabilityHours,
//                           userId: userId ?? 0,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text("التالي"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/addItem_Screens/setPrice_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/item_provider.dart';

class AddDetailsScreen extends StatelessWidget {
  static String routeName = "/adddetails_screen";
  final _quantityController = TextEditingController();
  final _minRentalController = TextEditingController();
  final _maxRentalController = TextEditingController();
  final _availabilityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("أضف التفاصيل")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: itemProvider.selectedStatus,
              items: ['excellent', 'good', 'acceptable', 'barely used']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) => itemProvider.setStatus(value!),
              decoration: InputDecoration(labelText: "حالة الغرض"),
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: "الكمية"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            TextFormField(
              controller: _minRentalController,
              decoration:
                  InputDecoration(labelText: "الحد الأدنى للإيجار (أيام)"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            TextFormField(
              controller: _maxRentalController,
              decoration:
                  InputDecoration(labelText: "الحد الأقصى للإيجار (أيام)"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            TextFormField(
              controller: _availabilityController,
              decoration: InputDecoration(labelText: "ساعات التوافر"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            ElevatedButton(
              onPressed: () {
                itemProvider.setQuantity(int.parse(_quantityController.text));
                itemProvider
                    .setMinRentalDuration(int.parse(_minRentalController.text));
                itemProvider
                    .setMaxRentalDuration(int.parse(_maxRentalController.text));
                itemProvider.setAvailabilityHours(
                    int.parse(_availabilityController.text));
                Navigator.pushNamed(context, SetPriceScreen.routeName);
              },
              child: Text("التالي"),
            ),
          ],
        ),
      ),
    );
  }
}
