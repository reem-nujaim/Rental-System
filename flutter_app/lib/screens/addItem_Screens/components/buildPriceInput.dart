import 'package:flutter/material.dart';

Widget buildPriceInput(String label, {required Null Function(dynamic value) onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'ر.س',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    ],
  );
}
