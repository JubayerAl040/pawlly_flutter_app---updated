import 'package:flutter/material.dart';

class CmAddButton extends StatelessWidget {
  const CmAddButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10),
        ),
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(26, 136, 135, 135)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Center(
        child: Text(title, style: const TextStyle(color: Color(0xFF9D67EF))),
      ),
    );
  }
}
