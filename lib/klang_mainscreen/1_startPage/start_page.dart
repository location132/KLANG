import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.3),
                const Text(
                  'KLANG',
                  style: TextStyle(
                      fontSize: 55,
                      height: 0.7,
                      color: Color.fromARGB(255, 110, 136, 246),
                      fontFamily: 'PretendardBold'),
                ),
                const SizedBox(height: 13),
                const Text(
                  '클랭에 오신 것을 환영합니다!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Pretendard'),
                ),
                SizedBox(height: screenHeight * 0.327),
                SizedBox(
                  height: 50,
                  width: screenWidth * 0.847,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        backgroundColor: const Color(0xff6185fe),
                        minimumSize: const Size(double.infinity, 36),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => Navigator.pushNamed(context, '/LoginPage'),
                    child: const Text(
                      '클랭 시작하기',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MainPage');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ),
                            child: const Text(
                              '회원가입 없이 둘러보기',
                              style: TextStyle(
                                color: Color(0xff6c6c6c),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
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
          ),
        ),
      ),
    );
  }
}
