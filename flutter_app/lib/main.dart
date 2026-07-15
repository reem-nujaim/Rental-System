// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin/constants.dart';
import 'package:flutter_signin/routes/app_routes.dart';
import 'package:flutter_signin/screens/welcome_page.dart';
import 'package:provider/provider.dart';

import 'models/item_Model/item_model.dart';
import 'provider/NotificationsProvider.dart';
import 'provider/authProvider.dart';
import 'provider/item_provider.dart';
import 'provider/reportProvider.dart';
import 'screens/Items_screen/item_details_screen.dart';
import 'screens/VerifyAccount_Screen/UnknownScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
        ChangeNotifierProvider(create: (context) => ReportProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeMeth(context),
        onGenerateRoute: generateRoute,
        // home: WelcomePage(),
        initialRoute: WelcomePage.routeNeme,
        routes: routes);
  }

  ThemeData themeMeth(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: kPrimaryColor, fontSize: 27, fontWeight: FontWeight.w700),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ItemDetailScreen.routeNeme:
      final item = settings.arguments as Item; // هنا نقوم بتمرير العنصر
      return MaterialPageRoute(
        builder: (context) => ItemDetailScreen(item: item),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Unknownscreen(),
      );
  }
}
