import 'package:flutter/material.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_add_button.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_clock_filed.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_date_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_dropdown_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_name_email_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_submit_button.dart';

class BookLawyerScreen extends StatefulWidget {
  static const routeName = "/book-lawyer-screen";
  const BookLawyerScreen({super.key, required this.img});
  final String img;
  @override
  State<BookLawyerScreen> createState() => _BookLawyerScreenState();
}

class _BookLawyerScreenState extends State<BookLawyerScreen> {
  final _dateField = TextEditingController();
  final _clockField = TextEditingController();
  final _selectedDuration = ValueNotifier<int>(0);
  final _selectedSeason = ValueNotifier<String>("");
  final _selectedLawyer = ValueNotifier<String>("");
  final _courtNameField = TextEditingController();
  final _additionalField = TextEditingController();
  final _durationList = [
    "15 min",
    "20 min",
    "25 min",
    "30 min",
    "35 min",
    "40 min",
    "45 min",
    "50 min",
    "55 min"
  ];
  final _seasonTypeList = [
    "Portrait Sessions",
    "Lifestyle Sessions",
    "Action Sessions",
    "Studio Sessions",
    "Family Sessions",
    "Event Sessions",
    "Pet-and-OwnerPortraits",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1116),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          "Book Lawyer",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CmRepo().titleText("Select Your Pets"),
              const SizedBox(height: 5),
              const CmAddButton(title: "Add Your Pet"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CmDateField(
                        title: "Date",
                        label: "Select Date",
                        controller: _dateField),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CmClockField(
                        title: "Time",
                        label: "Select Time",
                        controller: _clockField),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CmRepo().titleText("Duration"),
                  const Spacer(),
                  CmRepo().titleText("Online"),
                  const SizedBox(width: 5),
                  Switch.adaptive(value: true, onChanged: (_) {}),
                ],
              ),
              const SizedBox(height: 5),
              // se
              ValueListenableBuilder(
                valueListenable: _selectedDuration,
                builder: (context, val, _) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      _durationList.length,
                      (index) {
                        final isSelected = _selectedDuration.value == index;
                        return InkWell(
                          onTap: () => _selectedDuration.value = index,
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(26, 99, 99, 99),
                            ),
                            child: Text(
                              _durationList[index],
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF9D67EF)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Court Name",
                controller: _courtNameField,
                label: "Write here.....",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmDropDownField(
                title: "Case Type",
                dropList: _seasonTypeList,
                selectedVal: _selectedSeason,
                label: "Select Case Type",
              ),
              const SizedBox(height: 20),
              CmDropDownField(
                title: "Lawyer",
                dropList: _seasonTypeList,
                selectedVal: _selectedLawyer,
                label: "Select Your Lawyer",
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Additional Info",
                controller: _additionalField,
                label: "Write here.....",
                readOnly: false,
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              CmSubmitButton(img: widget.img),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _clockField.dispose();
    _dateField.dispose();
    _courtNameField.dispose();
    _additionalField.dispose();
    super.dispose();
  }
}
