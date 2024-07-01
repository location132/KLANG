import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart'; // 삭제

class AppleLogin extends StatefulWidget {
  const AppleLogin({super.key});

  @override
  State<AppleLogin> createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  Future<void> signout() async {
    await FlutterNaverLogin.logOut();
    print('로그아웃 성공');
    NaverAccessToken outToken = await FlutterNaverLogin.currentAccessToken;
    print('${outToken.accessToken}');
    print('${outToken.refreshToken}');
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => signout(),
      /*showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
          height: 112,
          width: double.infinity,
          child: const Center(
            child: Text('애플 로그인은 준비 중 입니다!', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
      */
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // 패딩을 0으로 설정
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 크기를 내용에 맞춤
      ),
      child: Image.asset(
        'assets/AppleLogin.png',
      ),
    );
  }
}
