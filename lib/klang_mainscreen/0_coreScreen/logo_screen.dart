import 'package:flutter/material.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({
    super.key,
  });

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'KLANG',
          style: TextStyle(
              fontSize: screenHeight * 0.046,
              height: 0.79,
              color: Color.fromARGB(255, 110, 136, 246),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
