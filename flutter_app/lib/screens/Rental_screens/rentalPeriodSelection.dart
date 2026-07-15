// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/DefualtTopContainer.dart';
import 'package:flutter_signin/constants.dart';

import 'rentByDaysScreen.dart';
import 'rentByHoursScreen.dart';

class RentalPeriodSelection extends StatelessWidget {
  const RentalPeriodSelection({super.key});
  static String routeNeme = "/rentaldetails_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            DefualtTopContainer(text: "اختر فترة الإيجار"),
            Expanded(
              child: Container(
                color: kSecondaryColor,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  children: [
                    // خيار استئجار لأيام
                    RentalOption(
                      title: 'أود الاستئجار لأيام',
                      icon: Icons.calendar_today,
                      iconColor: Colors.orange,
                      onTap: () {
                        // الانتقال إلى صفحة استئجار لأيام
                        Navigator.pushNamed(
                            context, RentByDaysScreen.routeNeme);
                      },
                    ),
                    SizedBox(height: 30),
                    // خيار استئجار لساعات
                    RentalOption(
                      title: 'أود الاستئجار لساعات',
                      icon: Icons.access_time,
                      iconColor: Colors.purple,
                      onTap: () {
                        // الانتقال إلى صفحة استئجار لساعات
                        Navigator.pushNamed(
                            context, Rentbyhoursscreen.routeNeme);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ويدجت مخصصة للخيار
class RentalOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const RentalOption({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kTextColor3,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(icon, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
