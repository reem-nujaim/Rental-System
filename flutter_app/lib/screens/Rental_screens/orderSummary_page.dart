// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class OrdersummaryPage extends StatelessWidget {
  final String rentalType;
  final int duration;
  final double totalPrice;

  OrdersummaryPage(
      {required this.rentalType,
      required this.duration,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ملخص الطلب')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('نوع الاستئجار: $rentalType'),
            Text('المدة: $duration ${rentalType == "ساعات" ? "ساعة" : "يوم"}'),
            Text('الإجمالي: $totalPrice ريال'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => WaitingApprovalPage()),
                // );
              },
              child: Text('تأكيد الطلب'),
            ),
          ],
        ),
      ),
    );
  }
}
