// ignore_for_file: annotate_overrides, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/ButtomAppBarSreens/home_page.dart';

import '../../../componenets/defualt_button.dart';
import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  void dispose() {
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    super.dispose();
  }

  void nextNode({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(color: kTextColor, fontSize: 24),
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextNode(value: value, focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(color: kTextColor, fontSize: 24),
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextNode(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(color: kTextColor, fontSize: 24),
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextNode(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(color: kTextColor, fontSize: 24),
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          DefualtBotton(
            text: "   تأكيد  ",
            press: () {
              Navigator.pushNamed(context, HomePage.routeNeme);
            },
          ),
        ],
      ),
    );
  }
}
