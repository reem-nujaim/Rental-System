// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../constants.dart';

class defualthelpContainer extends StatelessWidget {
  final String title;
  final List<String> tips; // النصوص الخاصة بالنصائح
  final List<IconData>? icons; // قائمة الأيقونات لكل نصيحة (اختياري)
  final String? imagePath; // مسار الصورة (اختياري)

  const defualthelpContainer({
    super.key,
    required this.tips,
    this.icons, // السماح بتمرير قائمة الأيقونات
    this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          // إظهار النصائح كـ Bottom Sheet عند الضغط
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return _buildHintsBottomSheet(context); // تمرير السياق هنا
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'نصائح',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildHintsBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // الصف الأول: خط ملون
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 3,
            width: 100,
            color: kPrimaryColor,
          ),
          // الصف الثاني: زر الإغلاق في أقصى اليمين
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق Bottom Sheet
              },
            ),
          ),
          // الصف الثالث: نص "نصائح بسيطة من شأنها تحسين عرضك" مع أيقونة المصباح
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.lightbulb,
                color: kPrimaryColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                title,
                //'نصائح بسيطة من شأنها تحسين عرضك',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // الصف الرابع والخامس: النصوص والصورة داخل مربع ملون
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kPrimaryColor2, // لون خلفية مشابه للتصميم
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // النصوص
                ...tips.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final tip = entry.value;
                    final icon = (icons != null && icons!.length > index)
                        ? icons![index]
                        : Icons
                            .info; // تعيين أيقونة افتراضية إذا لم يتم توفير قائمة الأيقونات

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            icon, // استخدام الأيقونة المناسبة
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              tip,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
                const SizedBox(height: 16),
                // الصورة داخل نفس المربع (اختياري)
                if (imagePath != null)
                  Center(
                    child: Image.asset(
                      imagePath!,
                      height: 150,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
