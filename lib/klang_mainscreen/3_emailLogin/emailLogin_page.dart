import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_between_leaf/klang_mainscreen/3_emailLogin/detail/ld_input_login.dart';
import 'package:team_between_leaf/klang_mainscreen/0_coreScreen/logo_screen.dart';
import 'package:team_between_leaf/klang_mainscreen/3_emailLogin/detail/ld_social_login_widget.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLogin();
}

class _EmailLogin extends State<EmailLogin> {
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
                    padding: EdgeInsets.zero, // 내부 패딩 제거
                    constraints:
                        const BoxConstraints(), // 최소 크기 제약을 제거하여 클릭 가능 영역 축소
                    icon: const Icon(CupertinoIcons.back, size: 32),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.158),
                      const LogoImage(),
                      SizedBox(height: screenHeight * 0.0422),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.035,
                            right: screenWidth * 0.035),
                        child: Column(
                          children: [
                            const InputLogIn(),
                            SizedBox(height: screenHeight * 0.135),
                            const SocialLoginWidget(),
                          ],
                        ),
                      ),
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
