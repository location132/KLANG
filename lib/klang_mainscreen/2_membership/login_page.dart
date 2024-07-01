import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_between_leaf/klang_mainscreen/2_membership/snslogin/apple_login.dart';
import 'package:team_between_leaf/klang_mainscreen/2_membership/snslogin/google_login.dart';
import 'package:team_between_leaf/klang_mainscreen/2_membership/snslogin/kakao_login.dart';
import 'package:team_between_leaf/klang_mainscreen/2_membership/snslogin/naver_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 15,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(CupertinoIcons.back, size: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.15),
                    Text(
                      'KLANG',
                      style: TextStyle(
                          fontSize: screenWidth * 0.089,
                          color: Color(0xff6185FE),
                          height: 0.75,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '클랭에 오신 것을 환영해요😊',
                      style: TextStyle(
                        color: Color(0xff5b5b5b),
                        fontSize: screenWidth * 0.031,
                        fontFamily: 'PretendardSemiBold',
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenWidth * 0.031,
                          color: Color(0xff5b5b5b),
                          fontFamily: 'PretendardSemiBold',
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '소셜계정으로 '),
                          TextSpan(
                              text: '3초',
                              style: TextStyle(
                                color: Color(0xffff3636),
                                fontFamily: 'PretendardSemiBold',
                              )),
                          TextSpan(text: '만에 가입해보세요.'),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.085),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.035,
                          right: screenWidth * 0.035),
                      child: Column(
                        children: [
                          NaverLogin(),
                          SizedBox(height: 12),
                          KakaoLogin(),
                          SizedBox(height: 12),
                          GoogleLogin(),
                          SizedBox(height: 12),
                          AppleLogin(),
                          SizedBox(height: screenHeight * 0.08),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15), // 좌우 여백 추가
                            child: const Divider(
                              color: Colors.grey,
                              thickness: 1, // 선의 두께 설정
                            ),
                          ),
                        ),
                        const Text('또는'),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15), // 좌우 여백 추가
                            child: const Divider(
                              color: Colors.grey,
                              thickness: 1, // 선의 두께 설정
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18), // 좌우 패딩 추가
                        child: TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 179, 193, 249),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/KlangMemberShip');
                          },
                          child: const Text(
                            '이메일로 가입하기',
                            style: TextStyle(
                                color: Color.fromARGB(255, 110, 136, 246),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '이미 계정이 있으신가요?',
                          style: TextStyle(
                              color: Color.fromARGB(255, 108, 108, 108)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/EmailLogin');
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 108, 108, 108),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      '로그인 하러가기',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 108, 108, 108),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
