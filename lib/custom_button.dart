import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // Attribute
  final String text;
  final void Function()? onPressed;

  // Konstruktor
  const CustomButton({super.key, required this.text, required this.onPressed});

  // Methode(n)
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Variante 1
      // onTap: () {
      //   debugPrint("GestureDetector wurde getapped");
      //   if (onPressed != null) {
      //     onPressed!(); // Variante 2
      //   }
      // },
      // onTap: () {
      //   debugPrint("GestureDetector wurde getapped");
      //   onPressed?.call(); // Variante 3
      // },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              onPressed == null
                  ? Colors.grey
                  : Theme.of(context).colorScheme.tertiary,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
