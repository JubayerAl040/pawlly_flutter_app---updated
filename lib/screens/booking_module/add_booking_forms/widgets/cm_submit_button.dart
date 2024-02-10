import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlly/screens/booking_module/payment_screen.dart';

class CmSubmitButton extends StatelessWidget {
  const CmSubmitButton({super.key, required this.onSubmit});
  final Function onSubmit;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.to((_) => const PaymentScreen()),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF9D67EF)),
      ),
      child: const Center(
          child: Text(
        "Book Now",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
