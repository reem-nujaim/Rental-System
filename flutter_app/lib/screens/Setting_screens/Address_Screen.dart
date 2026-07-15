// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/profile_inf.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  static const routeName = '/Address_Screen';
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
            'إضافة العنوان',
            style: TextStyle(color: kSecondaryColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // قائمة المدن (ListBox)
                Text(
                  'المدينة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  items: [
                    'صنعاء',
                    // 'تعز',
                    // 'الحديدة',
                  ]
                      .map((city) => DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // يمكنك إضافة وظيفة هنا لمعالجة المدينة المختارة
                  },
                  decoration: InputDecoration(
                    labelText: 'اختر المدينة',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // حقل الشارع
                Text(
                  'الشارع',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'أدخل اسم الشارع',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // حقل المنطقة
                Text(
                  'المنطقة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'أدخل اسم المنطقة',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // ملاحظات إضافية
                Text(
                  'ملاحظات إضافية',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'أضف ملاحظاتك هنا',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: DefualtBotton(
                    text: 'حفظ العنوان',
                    press: () {
                      // يمكن إضافة دالة هنا لحفظ العنوان
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم إضافة العنوان بنجاح')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
