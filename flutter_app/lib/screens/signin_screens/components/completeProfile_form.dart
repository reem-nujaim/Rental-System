// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/form_errors.dart';
import 'package:flutter_signin/screens/signin_screens/otp_page.dart';

import '../../../componenets/defualt_button.dart';
import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
  CompleteProfileForm({super.key});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumController = TextEditingController();
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildFirstNameFormField(),
              SizedBox(
                height: 30,
              ),
              buildLastNameFormField(),
              SizedBox(
                height: 30,
              ),
              buildPhoneNumFormField(),
              FormError(errors: errors),
              SizedBox(
                height: 30,
              ),
              DefualtBotton(
                  text: "  متابعة",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      print(firstNameController.text);
                      print(lastNameController.text);
                      print(phoneNumController.text);
                      Navigator.pushNamed(context, OtpPage.routeNeme);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) =>
          phoneNumController = newValue! as TextEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "رقم الهاتف",
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Icon(
              Icons.phone,
              color: kTextColor,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20)),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) =>
          lastNameController = newValue! as TextEditingController,
      decoration: InputDecoration(
          hintText: "الاسم الأخير",
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Icon(
              Icons.person,
              color: kTextColor,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20)),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) =>
          firstNameController = newValue! as TextEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "الاسم الأول",
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Icon(
              Icons.person,
              color: kTextColor,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor),
            gapPadding: 10,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20)),
    );
  }
}
