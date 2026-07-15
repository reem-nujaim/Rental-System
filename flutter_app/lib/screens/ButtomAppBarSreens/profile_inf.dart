// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../componenets/DefualtTopContainer.dart';
import '../../componenets/buildListTile.dart';
import '../../componenets/customBottomAppBar.dart';
import '../../constants.dart';
import '../Profile_screens/account_screen.dart';
import '../Setting_screens/contactUs_Screen.dart';
import '../Setting_screens/my_items_screen.dart';
import '../Setting_screens/notifications_Screen.dart';
import '../Setting_screens/payment_screen.dart';
import '../Setting_screens/reports_Screen.dart';
import '../Setting_screens/whoweare_page.dart';

class ProfileInf extends StatelessWidget {
  const ProfileInf({super.key});
  static String routeNeme = "/profile_inf";

  @override
  Widget build(BuildContext context) {
    //   bool isLoggedIn = false;
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // قسم العنوان العلوي
            DefualtTopContainer(text: "مرحبًا بك "),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  // عناصر القائمة
                  buildListTile(
                      title: "حسابي",
                      icon: Icons.person,
                      onTap: () {
                        Navigator.pushNamed(context, AccountScreen.routeName);
                      }),
                  buildListTile(
                      title: "أغراضي",
                      icon: Icons.inventory_rounded,
                      onTap: () {
                        Navigator.pushNamed(context, MyItemsScreen.routeName);
                      }),
                  buildListTile(
                      title: 'طرق الدفع',
                      icon: Icons.payment,
                      onTap: () {
                        Navigator.pushNamed(context, PaymentScreen.routeNeme);
                      }),
                  // buildListTile(
                  //     title: 'العناوين',
                  //     icon: Icons.location_on,
                  //     onTap: () {
                  //       Navigator.pushNamed(context, AddressScreen.routeName);
                  //     }),
                  buildListTile(
                      title: 'إشعاراتي',
                      icon: Icons.notifications,
                      onTap: () {
                        Navigator.pushNamed(
                            context, NotificationsScreen.routeName);
                      }),
                  buildListTile(
                      title: 'تقارير',
                      icon: Icons.report,
                      onTap: () {
                        Navigator.pushNamed(context, ReportScreen.routeName);
                      }),
                  const Divider(),
                  buildListTile(
                      title: 'الأسئلة الشائعة', icon: Icons.info, onTap: () {}),
                  buildListTile(
                      title: 'تواصل معنا',
                      icon: Icons.contact_mail,
                      onTap: () {
                        Navigator.pushNamed(context, ContactUsScreen.routeName);
                      }),
                  buildListTile(
                      title: 'من نحن؟',
                      icon: Icons.help_outline,
                      onTap: () {
                        Navigator.pushNamed(context, WhowearePage.routeNeme);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: customBottomAppBar(currentIndex: 3),
      floatingActionButton: defaultFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
