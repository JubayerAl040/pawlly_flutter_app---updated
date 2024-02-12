import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';

class CmClockField extends StatelessWidget {
  const CmClockField(
      {super.key,
      required this.title,
      required this.label,
      required this.controller});
  final String title;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CmRepo().titleText("Time"),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          textInputAction: TextInputAction.done,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            suffixIcon: const Icon(Icons.timer_outlined, color: Colors.grey),
            filled: true,
            fillColor: const Color.fromARGB(26, 99, 99, 99),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            focusedBorder: InputBorder.none,
          ),
          onTap: () => _onDateChange(context),
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }

  void _onDateChange(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: TimeOfDay.now().hour,
        minute: TimeOfDay.now().minute,
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time == null) return;
    controller.text =
        "${int.parse(time.hour.toString().padLeft(2, '0')) % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour % 12 == 0 ? "AM" : "PM"}";
  }
}
