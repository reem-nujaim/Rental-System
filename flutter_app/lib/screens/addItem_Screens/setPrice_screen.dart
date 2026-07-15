// // // import 'package:flutter/material.dart';

// // // import 'adddetails_screen.dart';
// // // // استدعاء الشاشة التالية

// // // class PricingScreen extends StatefulWidget {
// // // static String routeName = "/setPrice_screen";
// // //   final String categoryId;
// // //   final String itemName;
// // //   final String itemDescription;

// // //   const PricingScreen({
// // //     Key? key,
// // //     required this.categoryId,
// // //     required this.itemName,
// // //     required this.itemDescription,
// // //   }) : super(key: key);

// // //   @override
// // //   _PricingScreenState createState() => _PricingScreenState();
// // // }

// // // class _PricingScreenState extends State<PricingScreen> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   String price = '';

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text("إعدادات السعر")),
// // //       body: Padding(
// // //         padding: EdgeInsets.all(16),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             children: [
// // //               TextFormField(
// // //                 decoration: InputDecoration(labelText: "السعر"),
// // //                 keyboardType: TextInputType.number,
// // //                 onSaved: (value) => price = value!,
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "يرجى إدخال السعر" : null,
// // //               ),
// // //               SizedBox(height: 16),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (_formKey.currentState!.validate()) {
// // //                     _formKey.currentState!.save();
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (context) => AvailabilityScreen(
// // //                           categoryId: widget.categoryId,
// // //                           itemName: widget.itemName,
// // //                           itemDescription: widget.itemDescription,
// // //                           price: price,
// // //                         ),
// // //                       ),
// // //                     );
// // //                   }
// // //                 },
// // //                 child: Text("التالي"),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';

// // import 'adddetails_screen.dart';
// // // استدعاء الشاشة التالية

// // class PricingScreen extends StatefulWidget {
// // static String routeName = "/setPrice_screen";
// //   final String categoryId;
// //   final String itemName;
// //   final String itemDescription;
// //   final String quantity;

// //   const PricingScreen({
// //     Key? key,
// //     required this.categoryId,
// //     required this.itemName,
// //     required this.itemDescription,
// //     required this.quantity,
// //   }) : super(key: key);

// //   @override
// //   _PricingScreenState createState() => _PricingScreenState();
// // }

// // class _PricingScreenState extends State<PricingScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   String priceAssurance = '';
// //   String pricePerHour = '';
// //   String pricePerDay = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("إعدادات السعر")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "سعر الضمان"),
// //                 keyboardType: TextInputType.number,
// //                 onSaved: (value) => priceAssurance = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال سعر الضمان" : null,
// //               ),
// //               SizedBox(height: 16),
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "السعر لكل ساعة"),
// //                 keyboardType: TextInputType.number,
// //                 onSaved: (value) => pricePerHour = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال السعر لكل ساعة" : null,
// //               ),
// //               SizedBox(height: 16),
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "السعر لكل يوم"),
// //                 keyboardType: TextInputType.number,
// //                 onSaved: (value) => pricePerDay = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال السعر لكل يوم" : null,
// //               ),
// //               SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     _formKey.currentState!.save();
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => AvailabilityScreen(
// //                           categoryId: widget.categoryId,
// //                           itemName: widget.itemName,
// //                           itemDescription: widget.itemDescription,
// //                           quantity: widget.quantity,
// //                           priceAssurance: priceAssurance,
// //                           pricePerHour: pricePerHour,
// //                           pricePerDay: pricePerDay,
// //                         ),
// //                       ),
// //                     );
// //                   }
// //                 },
// //                 child: Text("التالي"),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'adddetails_screen.dart';

// class PricingScreen extends StatefulWidget {
//   static String routeName = "/setPrice_screen";
//   final String categoryId;
//   final String itemName;
//   final String itemDescription;
//   final String quantity;

//   const PricingScreen({
//     Key? key,
//     required this.categoryId,
//     required this.itemName,
//     required this.itemDescription,
//     required this.quantity,
//   }) : super(key: key);

//   @override
//   _PricingScreenState createState() => _PricingScreenState();
// }

// class _PricingScreenState extends State<PricingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String priceAssurance = '';
//   String pricePerHour = '';
//   String pricePerDay = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("إعدادات السعر")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "السعر التأميني"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => priceAssurance = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال السعر التأميني" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "السعر بالساعة"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => pricePerHour = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال السعر بالساعة" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "السعر باليوم"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => pricePerDay = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال السعر باليوم" : null,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AvailabilityScreen(
//                           categoryId: widget.categoryId,
//                           itemName: widget.itemName,
//                           itemDescription: widget.itemDescription,
//                           quantity: widget.quantity,
//                           priceAssurance: priceAssurance,
//                           pricePerHour: pricePerHour,
//                           pricePerDay: pricePerDay,
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
import 'package:flutter_signin/screens/addItem_Screens/addlocation_screen.dart';
import 'package:provider/provider.dart';
import '../../provider/item_provider.dart';

class SetPriceScreen extends StatelessWidget {
  static String routeName = "/setPrice_screen";
  final _priceAssuranceController = TextEditingController();
  final _pricePerHourController = TextEditingController();
  final _pricePerDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("حدد السعر")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _priceAssuranceController,
              decoration: InputDecoration(labelText: "مبلغ التأمين"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            TextFormField(
              controller: _pricePerHourController,
              decoration: InputDecoration(labelText: "السعر في الساعة"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            TextFormField(
              controller: _pricePerDayController,
              decoration: InputDecoration(labelText: "السعر في اليوم"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "مطلوب" : null,
            ),
            ElevatedButton(
              onPressed: () {
                itemProvider.setPriceAssurance(
                    double.parse(_priceAssuranceController.text));
                itemProvider.setPricePerHour(
                    double.parse(_pricePerHourController.text));
                itemProvider
                    .setPricePerDay(double.parse(_pricePerDayController.text));
                Navigator.pushNamed(context, AddLocationScreen.routeName);
              },
              child: Text("التالي"),
            ),
          ],
        ),
      ),
    );
  }
}
