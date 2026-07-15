// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/search_screen.dart';
import 'package:flutter_signin/screens/Rental_screens/componenets/payment_methods.dart';
import 'package:flutter_signin/screens/Rental_screens/rentByDaysScreen.dart';
import 'package:flutter_signin/screens/Rental_screens/rentByHoursScreen.dart';
import 'package:flutter_signin/screens/Rental_screens/rentalPeriodSelection.dart';
import 'package:flutter_signin/screens/UserProfileScreen.dart';
import 'package:flutter_signin/screens/VerificationScreen.dart';
import 'package:flutter_signin/screens/addItem_Screens/ImagePickerScreen.dart';
import 'package:flutter_signin/screens/addItem_Screens/ReviewScreen.dart';
import 'package:flutter_signin/screens/addItem_Screens/addCategories_Screen.dart';
import 'package:flutter_signin/screens/addItem_Screens/addItemName_screen.dart';
import 'package:flutter_signin/screens/addItem_Screens/adddetails_screen.dart';
import 'package:flutter_signin/screens/addItem_Screens/addlocation_screen.dart';
import 'package:flutter_signin/screens/addItem_Screens/setPrice_screen.dart';
import 'package:flutter_signin/screens/login_screens/forget_PasswordScreen.dart';
import 'package:flutter_signin/screens/welcome_page.dart';
import '../models/item_Model/item_model.dart';
import '../screens/ButtomAppBarSreens/categories_page.dart';
import '../screens/ButtomAppBarSreens/home_page.dart';
import '../screens/ButtomAppBarSreens/my_rental_screen.dart';
import '../screens/ButtomAppBarSreens/profile_inf.dart';
import '../screens/Items_screen/item_details_screen.dart';
import '../screens/Items_screen/items_Screen.dart';
import '../screens/Profile_screens/ChangePassword_Screen.dart';
import '../screens/Profile_screens/account_screen.dart';
import '../screens/Rental_screens/rentalRequest_screen.dart';
import '../screens/Setting_screens/Address_Screen.dart';
import '../screens/Setting_screens/contactUs_Screen.dart';
import '../screens/Setting_screens/my_items_screen.dart';
import '../screens/Setting_screens/notifications_Screen.dart';
import '../screens/Setting_screens/payment_screen.dart';
import '../screens/Setting_screens/reports_Screen.dart';
import '../screens/Setting_screens/whoweare_page.dart';
import '../screens/VerifyAccount_Screen/UnknownScreen.dart';
import '../screens/addItem_Screens/fullAdd_screen.dart';
import '../screens/login_screens/reset_password.dart';
import '../screens/login_screens/signin_page.dart';
import '../screens/signin_screens/completeProfile_page.dart';
import '../screens/signin_screens/login_page.dart';
import '../screens/signin_screens/otp_page.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomePage.routeNeme: (context) => WelcomePage(),
  SigninPage.routeNeme: (context) => SigninPage(),
  LoginPage.routeNeme: (context) => LoginPage(),
  PublicProfileScreen.routeName: (context) => PublicProfileScreen(),
  VerifyAccountScreen.routeName: (context) => VerifyAccountScreen(),
  CompleteprofilePage.routeNeme: (context) => CompleteprofilePage(),
  HomePage.routeNeme: (context) => HomePage(),
  WhowearePage.routeNeme: (context) => WhowearePage(),
  ResetPassword.routeNeme: (context) => ResetPassword(),
  OtpPage.routeNeme: (context) => OtpPage(),
  Unknownscreen.routeNeme: (context) => Unknownscreen(),
  FulladdScreen.routeName: (context) => FulladdScreen(),
  RentalPeriodSelection.routeNeme: (context) => RentalPeriodSelection(),
  Rentbyhoursscreen.routeNeme: (context) => Rentbyhoursscreen(),
  RentByDaysScreen.routeNeme: (context) => RentByDaysScreen(),
  ProfileInf.routeNeme: (context) => ProfileInf(),
  ForgetPasswordscreen.routeName: (context) => ForgetPasswordscreen(),
  MyRentalScreen.routeName: (context) => MyRentalScreen(),
  CategoriesPage.routeNeme: (context) => CategoriesPage(
        categoryId: 1,
        categoryName: '',
      ),
  CategoriesPage.routeNeme: (context) => CategoriesPage(
        categoryId: 2,
        categoryName: '',
      ),
  PaymentMethods.routeNeme: (context) => PaymentMethods(),
  ItemsScreen.routeNeme: (context) => ItemsScreen(
        categoryName: '',
        categoryId: 1,
      ),
  AccountScreen.routeName: (context) => AccountScreen(),
  ChangePasswordScreen.routeNeme: (context) => ChangePasswordScreen(),
  PaymentScreen.routeNeme: (context) => PaymentScreen(),
  AddressScreen.routeName: (context) => AddressScreen(),
  MyItemsScreen.routeName: (context) => MyItemsScreen(),
  ReportScreen.routeName: (context) => ReportScreen(),
  ContactUsScreen.routeName: (context) => ContactUsScreen(),
  AddCategoryScreen.routeName: (context) => AddCategoryScreen(),
  SetPriceScreen.routeName: (context) => SetPriceScreen(),
  AddItemNameScreen.routeName: (context) => AddItemNameScreen(),
  AddDetailsScreen.routeName: (context) => AddDetailsScreen(),
  AddLocationScreen.routeName: (context) => AddLocationScreen(),
  AddImagesScreen.routeName: (context) => AddImagesScreen(),
  ReviewScreen.routeName: (context) => ReviewScreen(),
  RentalRequestScreen.routeName: (context) => RentalRequestScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  SearchResultsScreen.routeNeme: (context) => SearchResultsScreen(
        query: '',
      ),
  ItemDetailScreen.routeNeme: (context) {
    final item = ModalRoute.of(context)?.settings.arguments as Item?;
    if (item == null) {
      return Scaffold(
        body: Center(child: Text("Item not found")),
      );
    }
    return ItemDetailScreen(item: item);
  },
};
