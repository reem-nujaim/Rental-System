// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../componenets/DefualtTopContainer.dart';
import '../../componenets/customBottomAppBar.dart';
import '../../constants.dart';
import '../../models/category_Model/categoryApi.dart';
import '../../models/category_Model/category_model.dart';
import '../Items_screen/items_Screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage(
      {super.key, required int categoryId, required String categoryName});
  static String routeNeme = "/categories_page";

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryApi categoryApi = CategoryApi(baseUrl: baseUrl);
  // تأكد من تحديث الـ Base URL
  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = false;
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefualtTopContainer(text: "مرحبا بك"),
            // searchbox(
            //   hintText: "ابحث عن الفئة",
            // ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: categoryApi.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'حدث خطأ: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          color: Colors.grey[100],
                          elevation: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              category.arName,
                              style: headTextStyle2(),
                            ), // عرض الاسم بالعربية
                            subtitle: Text(
                                category.arDescription), // عرض الوصف بالعربية
                            leading: Icon(Icons.category, color: kPrimaryColor),
                            onTap: () {
                              // الانتقال إلى شاشة العناصر الخاصة بالفئة
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsScreen(
                                    categoryId: category.id,
                                    categoryName: category.arName,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('لا توجد بيانات لعرضها.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: customBottomAppBar(currentIndex: 2),
      floatingActionButton: defaultFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
