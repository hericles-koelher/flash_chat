import 'package:flutter/material.dart';

class ExpansiveElevatedButton extends StatelessWidget {
  final int flex;
  final String label;
  final VoidCallback callback;
  final Color? color;

  const ExpansiveElevatedButton({
    Key? key,
    required this.flex,
    required this.label,
    required this.callback,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        child: Text(label),
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
