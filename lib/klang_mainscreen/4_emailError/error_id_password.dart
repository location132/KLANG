import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_between_leaf/klang_mainscreen/0_coreScreen/logo_screen.dart';
import 'package:team_between_leaf/klang_mainscreen/4_emailError/detail/input_name.dart';
import 'package:team_between_leaf/klang_mainscreen/4_emailError/detail/input_code.dart';
import 'package:team_between_leaf/klang_mainscreen/4_emailError/detail/input_phone.dart';

class ErrorIdPasssordPage extends StatefulWidget {
  const ErrorIdPasssordPage({super.key});

  @override
  State<ErrorIdPasssordPage> createState() => _ErrorIdPasssordPage();
}

class _ErrorIdPasssordPage extends State<ErrorIdPasssordPage> {
  bool _isChangedButton = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(CupertinoIcons.back, size: 32),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.158),
                      const LogoImage(),
                      SizedBox(height: screenHeight * 0.0305),
                      Text(
                        '비밀번호를 5회 이상 틀리셨습니다.\n휴대전화로 인증해주세요.',
                        style: TextStyle(
                          color: const Color(0xffff3636),
                          fontSize: screenHeight * 0.014,
                          fontFamily: 'PretendardSemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.0516),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.035,
                            right: screenWidth * 0.035),
                        child: Column(
                          children: [
                            LoginName(),
                            LoginPhone(),
                            LoginCode(onCodeEntered: (result) {
                              setState(() {
                                _isChangedButton = result;
                              });
                            }),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.035,
                            right: screenWidth * 0.035),
                        child: SizedBox(
                          height: 50,
                          child: !_isChangedButton
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 1),
                                    backgroundColor: const Color(0xffa8a8a8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 1),
                                    backgroundColor: const Color(0xff6185FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
