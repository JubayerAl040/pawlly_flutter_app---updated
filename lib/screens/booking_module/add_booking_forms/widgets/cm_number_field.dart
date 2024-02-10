import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';
import 'package:flutter/material.dart';

class CmNumberField extends StatelessWidget {
  const CmNumberField(
      {super.key,
      required this.title,
      required this.controller,
      required this.label,
      this.readOnly});
  final String title;
  final TextEditingController controller;
  final String label;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CmRepo().titleText(title),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            filled: true,
            fillColor: const Color.fromARGB(26, 99, 99, 99),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            focusedBorder: InputBorder.none,
          ),
          readOnly: readOnly ?? false,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Plz insert any number!';
            } else {
              final intValue = int.tryParse(val);
              if (intValue == null) return "Plz provide valid value";
              return null;
            }
          },
        ),
      ],
    );
  }
}
