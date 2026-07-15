// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';

class ItemConditionSlider extends StatefulWidget {
  const ItemConditionSlider({super.key});

  @override
  _ItemConditionSliderState createState() => _ItemConditionSliderState();
}

class _ItemConditionSliderState extends State<ItemConditionSlider> {
  double _sliderValue = 3;

  final List<String> _labels = [
    "جيد",
    "مقبول",
    "بالكاد مستعمل",
    "جديد",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.amber,
                inactiveTrackColor: Colors.grey[300],
                trackHeight: 20,
                thumbColor: kPrimaryColor2, //kPrimaryColor2,
                overlayColor: kPrimaryColor2.withOpacity(0.2),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              ),
              child: Slider(
                value: _sliderValue,
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _labels
                    .map(
                      (label) => Text(
                        label,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
