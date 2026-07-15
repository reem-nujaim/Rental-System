// // // import 'package:flutter/material.dart';

// // // import 'setPrice_screen.dart';
// // // // استدعاء الشاشة التالية

// // // class BasicDetailsScreen extends StatefulWidget {
// // // static String routeName = "/addItemName_screen";
// // //   final String categoryId;

// // //   const BasicDetailsScreen({Key? key, required this.categoryId})
// // //       : super(key: key);

// // //   @override
// // //   _BasicDetailsScreenState createState() => _BasicDetailsScreenState();
// // // }

// // // class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   String itemName = '';
// // //   String itemDescription = '';

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text("تفاصيل الغرض")),
// // //       body: Padding(
// // //         padding: EdgeInsets.all(16),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             children: [
// // //               TextFormField(
// // //                 decoration: InputDecoration(labelText: "اسم الغرض"),
// // //                 onSaved: (value) => itemName = value!,
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "يرجى إدخال اسم الغرض" : null,
// // //               ),
// // //               SizedBox(height: 16),
// // //               TextFormField(
// // //                 decoration: InputDecoration(labelText: "وصف الغرض"),
// // //                 maxLines: 3,
// // //                 onSaved: (value) => itemDescription = value!,
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "يرجى إدخال وصف الغرض" : null,
// // //               ),
// // //               SizedBox(height: 16),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (_formKey.currentState!.validate()) {
// // //                     _formKey.currentState!.save();
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (context) => PricingScreen(
// // //                           categoryId: widget.categoryId,
// // //                           itemName: itemName,
// // //                           itemDescription: itemDescription,
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

// // import 'setPrice_screen.dart';
// // // استدعاء الشاشة التالية

// // class BasicDetailsScreen extends StatefulWidget {
// // static String routeName = "/addItemName_screen";
// //   final String categoryId;

// //   const BasicDetailsScreen({Key? key, required this.categoryId})
// //       : super(key: key);

// //   @override
// //   _BasicDetailsScreenState createState() => _BasicDetailsScreenState();
// // }

// // class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   String itemName = '';
// //   String itemDescription = '';
// //   String quantity = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("تفاصيل الغرض")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "اسم الغرض"),
// //                 onSaved: (value) => itemName = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال اسم الغرض" : null,
// //               ),
// //               SizedBox(height: 16),
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "وصف الغرض"),
// //                 maxLines: 3,
// //                 onSaved: (value) => itemDescription = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال وصف الغرض" : null,
// //               ),
// //               SizedBox(height: 16),
// //               TextFormField(
// //                 decoration: InputDecoration(labelText: "الكمية"),
// //                 keyboardType: TextInputType.number,
// //                 onSaved: (value) => quantity = value!,
// //                 validator: (value) =>
// //                     value!.isEmpty ? "يرجى إدخال الكمية" : null,
// //               ),
// //               SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     _formKey.currentState!.save();
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => PricingScreen(
// //                           categoryId: widget.categoryId,
// //                           itemName: itemName,
// //                           itemDescription: itemDescription,
// //                           quantity: quantity,
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
// import 'setPrice_screen.dart';

// class BasicDetailsScreen extends StatefulWidget {
//   static String routeName = "/addItemName_screen";
//   final String categoryId;

//   const BasicDetailsScreen({Key? key, required this.categoryId})
//       : super(key: key);

//   @override
//   _BasicDetailsScreenState createState() => _BasicDetailsScreenState();
// }

// class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String itemName = '';
//   String itemDescription = '';
//   String quantity = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("تفاصيل الغرض")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "اسم الغرض"),
//                 onSaved: (value) => itemName = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال اسم الغرض" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "وصف الغرض"),
//                 maxLines: 3,
//                 onSaved: (value) => itemDescription = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال وصف الغرض" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: "الكمية"),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => quantity = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? "يرجى إدخال الكمية" : null,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PricingScreen(
//                           categoryId: widget.categoryId,
//                           itemName: itemName,
//                           itemDescription: itemDescription,
//                           quantity: quantity,
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
import 'package:flutter_signin/screens/addItem_Screens/adddetails_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/item_provider.dart';

class AddItemNameScreen extends StatelessWidget {
  static String routeName = "/addItemName_screen";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("أضف اسم ووصف الغرض")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "اسم الغرض"),
                validator: (value) => value!.isEmpty ? "مطلوب" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "وصف الغرض"),
                validator: (value) => value!.isEmpty ? "مطلوب" : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    itemProvider.setItemName(_nameController.text);
                    itemProvider
                        .setItemDescription(_descriptionController.text);
                    Navigator.pushNamed(context, AddDetailsScreen.routeName);
                  }
                },
                child: Text("التالي"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
