// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class RentByDaysScreen extends StatefulWidget {
  const RentByDaysScreen({super.key});
  static String routeNeme = "/rentByDaysScreen";
  @override
  _RentByDaysScreenState createState() => _RentByDaysScreenState();
}

class _RentByDaysScreenState extends State<RentByDaysScreen> {
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _selectedDays = [];
  final int dailyRate = 771; // سعر الإيجار لليوم الواحد

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_selectedDays.contains(selectedDay)) {
      setState(() {
        _selectedDays.remove(selectedDay);
      });
    } else if (_selectedDays.length < 2) {
      setState(() {
        _selectedDays.add(selectedDay);
      });
    }
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  int calculateTotalCost() {
    return _selectedDays.length * dailyRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondaryColor),
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'اختر فترة الإيجار',
            style: TextStyle(color: kSecondaryColor),
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.now(),
            lastDay:
                DateTime.now().add(const Duration(days: 360)), // حد أقصى شهرين
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => _selectedDays.contains(day),
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'التواريخ المختارة: ${_selectedDays.map((e) => e.toLocal().toString().split(' ')[0]).join(', ')}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'التكلفة الإجمالية: ${calculateTotalCost()} ريال',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // تنفيذ إجراء عند تأكيد الحجز
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'تم حجز ${_selectedDays.length} يوم بـ ${calculateTotalCost()} ريال'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'اختيار طرق التوصيل',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
