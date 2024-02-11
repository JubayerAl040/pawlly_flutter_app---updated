import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly/components/service_app_button.dart';
import 'package:pawlly/screens/booking_module/payment_screen.dart';

class CmSubmitButton extends StatelessWidget {
  const CmSubmitButton({super.key, required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return AppButtonWithPricing(
      price: 667,
      tax: 6.5,
      items: "",
      serviceImg: img,
      onTap: () {
        hideKeyboard(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
      },
    );
  }
}
