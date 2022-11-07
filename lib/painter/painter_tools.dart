import 'package:flutter/material.dart';

class PainterTools extends StatelessWidget {
  const PainterTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromARGB(255, 255, 255, 255)),
      child: SizedBox(
        height: 500,
        width: 300,
        child: Center(
          child: Text('Przybornik'),
        ),
      ),
    );
  }
}
