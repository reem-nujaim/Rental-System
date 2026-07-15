// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static String routeNeme = "/payment_screen";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'طرق الدفع',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(context, 'طرق الدفع', 1),
                  buildListTile(context, 'طرق الدفع للمؤجر', 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title, int type) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: InkWell(
        onTap: () {
          showPaymentOptions(context, type); // استدعاء الدالة لعرض الخيارات
        },
        borderRadius: BorderRadius.circular(15),
        child: Card(
          color: Colors.grey[100],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: kPrimaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة عرض نافذة طرق الدفع بناءً على الخيار المحدد
  // في دالة showPaymentOptions
  void showPaymentOptions(BuildContext context, int type) {
    List<Map<String, dynamic>> paymentOptions = [];

    if (type == 1) {
      paymentOptions = [
        {'title': 'حوالة', 'action': () => showBankTransferDetails(context)},
        {
          'title': 'الدفع عند الاستلام',
          'action': () => showCashOnDeliveryDetails(context)
        }, // إضافة الإجراءات الخاصة
      ];
    } else if (type == 2) {
      paymentOptions = [
        {
          'title': 'الحساب البنكي',
          'action': () => showTransferDetails(context)
        },
        {'title': 'حوالة', 'action': () => showTransferDetails(context)},
        // {
        //   'title': 'الدفع عند الاستلام',
        //   'action': () => showCashOnDeliveryDetails(context)
        // },
      ];
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر طريقة الدفع',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: paymentOptions
                      .map(
                        (option) => ListTile(
                          title: Text(
                            option['title'],
                            style: TextStyle(fontSize: 18),
                          ),
                          leading: Icon(Icons.payment, color: kPrimaryColor),
                          onTap: () {
                            Navigator.pop(context); // إغلاق النافذة
                            option['action'](); // تنفيذ الإجراء المناسب
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showTransferDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "نرجو منك التواصل مع الدعم الفني ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "لإتمام البيانات اللازمة",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBankTransferDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تفاصيل حساب كراء البنكي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'اسم الحساب: كراء',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'رقم الحساب: 1234567890',
                  style: TextStyle(fontSize: 18),
                ),
                // Text(
                //   'رقم الآيبان: SA1234567890',
                //   style: TextStyle(fontSize: 18),
                // ),
                SizedBox(height: 20),
                // Text(
                //   'يرجى ملء التفاصيل التالية لإتمام التحويل:',
                //   style: TextStyle(fontSize: 16),
                // ),
                // SizedBox(height: 10),
                // Directionality(
                //   textDirection: TextDirection.rtl,
                //   child: Column(
                //     children: [
                //       TextField(
                //         decoration: InputDecoration(
                //           labelText: 'رقم الحوالة',
                //           border: OutlineInputBorder(),
                //         ),
                //       ),
                //       SizedBox(height: 10),
                //       TextField(
                //         decoration: InputDecoration(
                //           labelText: 'اسم العميل',
                //           border: OutlineInputBorder(),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // هنا يمكن تنفيذ عملية الدفع أو إرسال الحوالة
                //     Navigator.pop(context); // إغلاق النافذة بعد إتمام العملية
                //   },
                //   child: Text('إرسال الحوالة'),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCashOnDeliveryDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping, color: kPrimaryColor, size: 28),
                  SizedBox(width: 10),
                  Text(
                    'الدفع عند الاستلام',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'يرجى التأكد من أن لديك المبلغ الكافي قبل استلام المنتج.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 10),
              Text(
                'يمكنك دفع المبلغ نقدًا عند استلام الطلب من المورد.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                // icon: Icon(Icons.check_circle_outline, color: Colors.white),
                label: Text(
                  'حسنا',
                  style: TextStyle(color: kSecondaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
