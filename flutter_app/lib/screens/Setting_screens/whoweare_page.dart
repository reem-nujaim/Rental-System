// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/home_page.dart';

import '../../componenets/DefualtTopContainer.dart';

class WhowearePage extends StatelessWidget {
  const WhowearePage({super.key});
  static String routeNeme = "/whoweare_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Top Container with background gradient
                DefualtTopContainer(
                  text: "من نحن ؟ ",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20), // Increased spacing
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card section for "من نحن"
                      _buildCardSection(
                        'تطبيق كراء',
                        Icons.info_outline,
                        "هو عبارة عن منصة تأجير لأي غرض فهو لا يقتصر \nعلى فئة محددة. \nلماذا تتكبد عناء الشراء إن كان بإمكانك الاستعارة ببساطة؟",
                        null,
                        () {}, // Empty callback
                      ),
                      SizedBox(height: 30),
                      _buildCardSection(
                        'طريقة العمل',
                        Icons.work_outline,
                        "كيفية التأجير\nاعرض غرضك مع الوصف. \nحدد سعره وفترة توافره. \nوافق على طلبات التأجير. \nأجره. \nاكسب النقود.",
                        "أضف غرضك الآن",
                        () {
                          Navigator.pushNamed(context, HomePage.routeNeme);
                        },
                      ),
                      SizedBox(height: 20),
                      _buildCardSection(
                        'كيفية الاستئجار',
                        Icons.search,
                        "ابحث عن الغرض الذي تحتاجه. \nاطلبه وأنتظر الموافقة. (لن يستغرق ذلك وقتا طويلا)\nاستعمله. \nأرجعه بحالته الأصلية واسترجع مبلغ التأمين.",
                        "استأجر الآن",
                        () {
                          Navigator.pushNamed(context, HomePage.routeNeme);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom function to create a section with a Card
  Widget _buildCardSection(String title, IconData icon, String description,
      String? buttonText, VoidCallback press) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header with Icon
            Row(
              children: [
                Icon(icon,
                    color: kPrimaryColor, size: 28), // Icon for the section
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor, // Section title color
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Section Description
            Text(
              description,
              style: TextStyle(
                color: kTextColor,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign:
                  TextAlign.start, // Align text to the start for RTL languages
            ),
            SizedBox(height: 20),
            // If buttonText is not null, display the button
            if (buttonText != null)
              Align(
                alignment:
                    Alignment.centerLeft, // Aligning the button to the left
                child: DefualtBotton(
                    text: buttonText,
                    press:
                        press), // Ensure you are using the correct button class name
              ),
          ],
        ),
      ),
    );
  }
}
