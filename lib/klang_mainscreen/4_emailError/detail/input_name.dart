import 'package:flutter/material.dart';

class LoginName extends StatefulWidget {
  const LoginName({super.key});

  @override
  State<LoginName> createState() => _LoginNameState();
}

class _LoginNameState extends State<LoginName> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이름',
          style: TextStyle(
            color: Color(0xff5b5b5b),
            fontSize: 12,
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        SizedBox(
          height: 40,
          child: TextFormField(
            style: const TextStyle(
              height: 1.2,
              color: Color(0xff8e8e8e),
              fontFamily: 'Pretendard',
              fontSize: 12,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffdbdbdb),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
