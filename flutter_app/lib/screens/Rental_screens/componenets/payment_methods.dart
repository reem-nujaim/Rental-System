// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/DefualtTopContainer.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});
  static String routeNeme = "/PaymentMethods";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            DefualtTopContainer(text: "اختر طريقة الدفع"),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    PaymentOption(
                      icon: Icons.credit_card,
                      title: 'حوالة',
                      onTap: () {
                        // Handle card payment
                      },
                    ),
                    PaymentOption(
                      icon: Icons.payments,
                      title: ' الدفع عند الاستلام',
                      onTap: () {
                        // Handle Google Pay
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المجموع: 1650 ر.س.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '3 أيام',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            DefualtBotton(text: "اطلب الغرض", press: () {})
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isDisabled;

  const PaymentOption({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDisabled ? Colors.grey : Colors.orange),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDisabled ? Colors.grey : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
