import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CmDateField extends StatelessWidget {
  const CmDateField(
      {super.key,
      required this.title,
      required this.label,
      required this.controller,
      this.firstDate,
      this.lastDate});
  final String title;
  final String label;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CmRepo().titleText(title),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            suffixIcon: const Icon(CupertinoIcons.calendar),
            filled: true,
            fillColor: const Color.fromARGB(26, 99, 99, 99),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            focusedBorder: InputBorder.none,
          ),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate ??
                  DateTime.now().subtract(const Duration(days: 70 * 365)),
              lastDate:
                  lastDate ?? DateTime.now().add(const Duration(days: 30)),
            );
            if (date == null) return;
            controller.text = DateFormat('yyyy-MM-dd').format(date);
          },
        ),
      ],
    );
  }
}
