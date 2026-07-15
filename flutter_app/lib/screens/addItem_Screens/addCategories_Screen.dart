// import 'package:flutter/material.dart';
// import '../../constants.dart';
// import '../../models/category_Model/categoryApi.dart';
// import '../../models/category_Model/category_model.dart';
// import 'addItemName_screen.dart';
// // استدعاء الشاشة التالية

// class CategorySelectionScreen extends StatefulWidget {
//   static String routeName = "/addCategories_Screen";

//   @override
//   _CategorySelectionScreenState createState() =>
//       _CategorySelectionScreenState();
// }

// class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
//   String? selectedCategory;
//   final CategoryApi categoryApi = CategoryApi(baseUrl: baseUrl);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("اختر الفئة")),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Text("في أي فئة سيظهر غرضك؟",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ),
//           Expanded(
//             child: FutureBuilder<List<Category>>(
//               future: categoryApi.getCategories(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(
//                       child: Text("حدث خطأ: ${snapshot.error}",
//                           style: TextStyle(color: Colors.red)));
//                 } else if (snapshot.hasData) {
//                   final categories = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final category = categories[index];
//                       return ListTile(
//                         title: Text(category.arName),
//                         trailing: selectedCategory == category.id.toString()
//                             ? Icon(Icons.check_circle, color: kPrimaryColor)
//                             : null,
//                         onTap: () {
//                           setState(() {
//                             selectedCategory = category.id.toString();
//                           });
//                         },
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(child: Text("لا توجد فئات متاحة."));
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: ElevatedButton(
//               onPressed: selectedCategory == null
//                   ? null
//                   : () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               BasicDetailsScreen(categoryId: selectedCategory!),
//                         ),
//                       );
//                     },
//               child: Text("التالي"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin/screens/addItem_Screens/addItemName_screen.dart';
import '../../provider/item_provider.dart';

class AddCategoryScreen extends StatelessWidget {
  static String routeName = "/addCategories_Screen";

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("اختر الفئة")),
      body: itemProvider.categories.isEmpty
          ? Center(child: CircularProgressIndicator()) // عرض تحميل
          : ListView.builder(
              itemCount: itemProvider.categories.length,
              itemBuilder: (context, index) {
                final category = itemProvider.categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    if (category.id != null) {
                      itemProvider.setCategory(category.id
                          .toString()); // تحويل إلى String فقط إذا كانت غير null
                      Navigator.pushNamed(context, AddItemNameScreen.routeName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("خطأ: الفئة غير صالحة")),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}
