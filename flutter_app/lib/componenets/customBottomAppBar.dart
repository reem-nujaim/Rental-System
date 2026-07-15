// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/ButtomAppBarSreens/categories_page.dart';
import '../screens/ButtomAppBarSreens/home_page.dart';
import '../screens/ButtomAppBarSreens/my_rental_screen.dart';
import '../screens/ButtomAppBarSreens/profile_inf.dart';

class customBottomAppBar extends StatelessWidget {
  const customBottomAppBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Gray shadow color
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -5), // Negative offset for shadow on top
          ),
        ],
      ),
      child: BottomAppBar(
        color: kSecondaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70, // Set the height of the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left-side navigation items

              // Right-side navigation items
              Row(
                children: [
                  _buildNavBarItem(
                    icon: Icons.category,
                    label: "الفئات",
                    isSelected: currentIndex == 2,
                    onTap: () {
                      Navigator.pushNamed(context, CategoriesPage.routeNeme);
                      // setState(() {
                      //   currentIndex = 2;
                      // });
                    },
                  ),
                  _buildNavBarItem(
                    icon: Icons.person,
                    label: "حسابي",
                    isSelected: currentIndex == 3,
                    onTap: () {
                      Navigator.pushNamed(context, ProfileInf.routeNeme);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  _buildNavBarItem(
                    icon: Icons.shopping_bag,
                    label: "إيجاراتي",
                    isSelected: currentIndex == 1,
                    onTap: () {
                      Navigator.pushNamed(context, MyRentalScreen.routeName);
                      // setState(() {
                      //   currentIndex = 1;
                      // });
                    },
                  ),
                  _buildNavBarItem(
                    icon: Icons.home,
                    label: "الرئيسية",
                    isSelected: currentIndex == 0,
                    onTap: () {
                      Navigator.pushNamed(context, HomePage.routeNeme);
                      // setState(() {
                      //  currentIndex = 0;
                      // });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNavBarItem({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: isSelected ? kPrimaryColor : Colors.grey),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? kPrimaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
