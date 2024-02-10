import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';

import 'package:flutter/material.dart';

class CmNameEmailField extends StatelessWidget {
  const CmNameEmailField({
    super.key,
    required this.title,
    required this.controller,
    required this.label,
    required this.readOnly,
    this.maxLines = 1,
  });
  final String title;
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CmRepo().titleText(title),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
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
          maxLines: maxLines,
          validator: (value) {
            // validation if it's city
            if (label.toLowerCase().contains('city')) {
              final haveNumber = _containsNumber(value!.trim());
              final haveSpecialChar = _containsSpecialChar(value.trim());
              if (value.trim().isEmpty) {
                return 'Please give your City.';
              } else if (haveNumber || haveSpecialChar) {
                return 'Cities can\'t have number or special character';
              } else {
                return null;
              }
            }
            // validation for email address
            else if (label.toLowerCase().contains('email')) {
              final haveDotCom = value!.trim().contains(".com");
              final haveDotOrg = value.trim().contains(".org");
              final haveSpace = value.trim().contains("..");
              final haveAtTheRate = value.trim().contains("@");
              if (value.trim().isEmpty) {
                return 'Please give your email address.';
              } else if ((!haveDotCom && !haveDotOrg) ||
                  !haveAtTheRate ||
                  haveSpace) {
                return 'Please give a valid email address';
              } else {
                return null;
              }
            }
            // validation for name or address
            else {
              if (value!.trim().isEmpty) {
                return 'Please give your $label';
              } else {
                return null;
              }
            }
          },
        ),
      ],
    );
  }

  bool _containsNumber(String str) {
    RegExp numberRegex = RegExp(r'[0-9]');
    return numberRegex.hasMatch(str);
  }

  bool _containsSpecialChar(String str) {
    RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(str);
  }
}
