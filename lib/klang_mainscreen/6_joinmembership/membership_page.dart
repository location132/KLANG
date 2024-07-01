import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_between_leaf/klang_mainscreen/0_coreScreen/logo_screen.dart';
import 'package:team_between_leaf/klang_mainscreen/6_joinmembership/detail/email_field.dart';
import 'package:team_between_leaf/klang_mainscreen/6_joinmembership/detail/password_field.dart';
import 'package:team_between_leaf/klang_mainscreen/6_joinmembership/detail/phone_field.dart';

class KlangMemberShip extends StatefulWidget {
  const KlangMemberShip({super.key});

  @override
  State<KlangMemberShip> createState() => _KlangMemberShipState();
}

class _KlangMemberShipState extends State<KlangMemberShip> {
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
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.035, right: screenWidth * 0.035),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: screenHeight * 0.12),
                        const LogoImage(),
                        Spacer(),
                        const Stack(
                          children: [
                            EmailField(),
                            Padding(
                              padding: EdgeInsets.only(top: 70),
                              child: PasswordField(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 210),
                              child: PhoneField(),
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
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
                        SizedBox(height: screenHeight * 0.1502),
                      ],
                    ),
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
