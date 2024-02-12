import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';
import 'package:flutter/material.dart';

class CmDropDownField extends StatelessWidget {
  const CmDropDownField(
      {super.key,
      required this.title,
      required this.dropList,
      required this.selectedVal,
      required this.label});
  final String title;
  final List<String>? dropList;
  final ValueNotifier selectedVal;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedVal,
      builder: (context, val, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CmRepo().titleText(title),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            isExpanded: true,
            key: ValueKey(val),
            isDense: true,
            value: val.isNotEmpty ? val : null,
            items: dropList!
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) => selectedVal.value = val!,
            icon: const Icon(Icons.arrow_drop_down),
            dropdownColor: context.cardColor,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              filled: true,
              fillColor: const Color.fromARGB(26, 99, 99, 99),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
