// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Rentbyhoursscreen extends StatefulWidget {
  const Rentbyhoursscreen({super.key});
  static String routeNeme = "/rentByHoursScreen";
  @override
  _RentbyhoursscreenState createState() => _RentbyhoursscreenState();
}

class _RentbyhoursscreenState extends State<Rentbyhoursscreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final int hourlyRate = 98; // السعر لكل ساعة
  final List<String> availableHours = [
    '9:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
  ];

  List<String> _selectedHours = [];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedHours = []; // إعادة تعيين الساعات المختارة عند اختيار يوم جديد
    });
  }

  void _toggleHourSelection(String hour) {
    setState(() {
      if (_selectedHours.contains(hour)) {
        _selectedHours.remove(hour);
      } else if (_selectedHours.length < 2) {
        _selectedHours.add(hour);
      }
    });
  }

  int calculateTotalCost() {
    return _selectedHours.length * hourlyRate;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 360)),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
            SizedBox(height: 20),
            if (_selectedDay != null) ...[
              Text(
                'عدد الساعات المختارة: ${_selectedHours.length}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: availableHours.map((hour) {
                  final isSelected = _selectedHours.contains(hour);
                  return GestureDetector(
                    onTap: () => _toggleHourSelection(hour),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? kPrimaryColor2 : Colors.white,
                        border: Border.all(
                          color: isSelected ? kPrimaryColor2 : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hour,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            Spacer(),
            if (_selectedHours.isNotEmpty) ...[
              Text(
                'المجموع: ${calculateTotalCost()} ريال',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
            ],
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: _selectedHours.isNotEmpty
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                ' تم حجز ${_selectedHours.length} ساعة بـ ${calculateTotalCost()} ريال'),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'اختيار طرق التوصيل',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
