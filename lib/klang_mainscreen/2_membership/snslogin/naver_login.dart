import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class NaverLogin extends StatefulWidget {
  const NaverLogin({super.key});

  @override
  State<NaverLogin> createState() => _NaverLoginState();
}

class _NaverLoginState extends State<NaverLogin> {
  Future<void> signInWithNaver() async {
    await FlutterNaverLogin.logIn();
    final NaverAccessToken naverLogin =
        await FlutterNaverLogin.currentAccessToken;
    print(naverLogin.accessToken);
    bool loginSuccess = await SNSLoginToServer(naverLogin.accessToken, 'NAVER');
    if (loginSuccess) {
      Provider.of<LoginModel>(context, listen: false)
          .setloginStatus(loginSuccess);
      Navigator.pushNamed(context, '/MainPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => signInWithNaver(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // 패딩을 0으로 설정
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 크기를 내용에 맞춤
      ),
      child: Image.asset(
        'assets/NaverLogin.png',
      ),
    );
  }
}
