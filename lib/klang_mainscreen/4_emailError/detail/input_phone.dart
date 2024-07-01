import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: screenHeight * 0.015),
      const Text(
        '휴대전화',
        style: TextStyle(
          color: Color(0xff5b5b5b),
          fontSize: 12,
          fontFamily: 'Pretendard',
        ),
      ),
      SizedBox(height: screenHeight * 0.005),
      SizedBox(
        height: 40,
        child: Stack(
          children: [
            TextFormField(
              inputFormatters: [maskFormatter],
              style: const TextStyle(
                height: 1.2,
                color: Color(0xff8e8e8e),
                fontFamily: 'Pretendard',
                fontSize: 12,
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                hintText: "  ‘-’구분없이 입력",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 211, 211, 211),
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                ),
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
              keyboardType: TextInputType.phone,
            ),
            Positioned(
              right: 15,
              top: 10,
              child: GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 123, 123, 123),
                              ),
                            ),
                          ),
                          child: const Text(
                            '인증번호 재전송',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 123, 123, 123),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
