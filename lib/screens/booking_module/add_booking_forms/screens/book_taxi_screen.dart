import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly/components/app_scaffold.dart';
import 'package:pawlly/main.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_add_button.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_clock_filed.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_date_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_dropdown_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_name_email_field.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_repo.dart';
import 'package:pawlly/screens/booking_module/add_booking_forms/widgets/cm_submit_button.dart';

class BookTaxiScreen extends StatefulWidget {
  static const routeName = "/book-taxi-screen";
  const BookTaxiScreen({super.key, required this.img});
  final String img;
  @override
  State<BookTaxiScreen> createState() => _BookTaxiScreenState();
}

class _BookTaxiScreenState extends State<BookTaxiScreen> {
  final _selectedLocation = ValueNotifier<String>("");
  final _dateField = TextEditingController();
  final _clockField = TextEditingController();
  final _nameField = TextEditingController();
  final _selectedTaxi = ValueNotifier<String>("");
  final _addFeautureFiled = TextEditingController();
  final _additionalInfo = TextEditingController();
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
    return AppScaffold(
      hideAppBar: false,
      appBarTitle: Text(
        "${locale.value.book} Taxi",
        style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
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
              CmDropDownField(
                title: "Location",
                dropList: _seasonTypeList,
                selectedVal: _selectedLocation,
                label: "Select Your Location",
              ),
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
                  CmRepo().titleText("Inside City"),
                  const SizedBox(width: 5),
                  Switch.adaptive(value: true, onChanged: (_) {}),
                  const Spacer(),
                  CmRepo().titleText("Full Day"),
                  const SizedBox(width: 5),
                  Switch.adaptive(value: true, onChanged: (_) {}),
                ],
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Name",
                controller: _nameField,
                label: "Type Your Name",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmDropDownField(
                title: "Taxi",
                dropList: _seasonTypeList,
                selectedVal: _selectedTaxi,
                label: "Select Your Taxi",
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Additional Feature",
                controller: _addFeautureFiled,
                label: "Type Your Feature",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CmNameEmailField(
                title: "Additional Info",
                controller: _additionalInfo,
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
    _additionalInfo.dispose();
    super.dispose();
  }
}
