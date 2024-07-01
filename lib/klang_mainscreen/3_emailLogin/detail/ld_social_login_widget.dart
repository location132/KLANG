import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({
    super.key,
  });

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  // 네이버 로그인
  Future<void> signInWithNaver() async {
    await FlutterNaverLogin.logIn();
    final NaverAccessToken naverLogin =
        await FlutterNaverLogin.currentAccessToken;
    bool loginSuccess = await SNSLoginToServer(naverLogin.accessToken, 'NAVER');
    if (mounted) {
      if (loginSuccess) {
        Provider.of<LoginModel>(context, listen: false)
            .setloginStatus(loginSuccess);
        Navigator.pushNamed(context, '/MainPage');
      }
    }
  }

  // 카카오 로그인
  void signInWithKakao() async {
    OAuthToken token;
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        String accessToken = token.accessToken;
        bool result = await SNSLoginToServer(accessToken, 'KAKAO');
        if (mounted) {
          if (result) {
            Provider.of<LoginModel>(context, listen: false)
                .setloginStatus(result);
            Navigator.pushNamed(context, '/MainPage');
          }
        }
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          String accessToken = token.accessToken;
          bool result = await SNSLoginToServer(accessToken, 'KAKAO');
          if (mounted) {
            if (result) {
              Provider.of<LoginModel>(context, listen: false)
                  .setloginStatus(result);
              Navigator.pushNamed(context, '/MainPage');
            }
          }
        } catch (error) {}
      }
    } else {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        String accessToken = token.accessToken;
        bool result = await SNSLoginToServer(accessToken, 'KAKAO');
        if (mounted) {
          if (result) {
            Provider.of<LoginModel>(context, listen: false)
                .setloginStatus(result);
            Navigator.pushNamed(context, '/MainPage');
          }
        }
      } catch (error) {}
    }
  }

  // 구글 로그인
  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      String accessToken = googleAuth.accessToken!;
      bool result = await SNSLoginToServer(accessToken, 'GOOGLE');
      if (mounted) {
        if (result) {
          Provider.of<LoginModel>(context, listen: false)
              .setloginStatus(result);
          Navigator.pushNamed(context, '/MainPage');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const Text(
              '간편 로그인',
              style: TextStyle(
                color: Color.fromARGB(255, 108, 108, 108),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: screenHeight * 0.0117)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => signInWithNaver(),
              child: SizedBox(
                height: screenHeight * 0.0587,
                child: Image.asset(
                  'assets/btnG_naver.png',
                ),
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () => signInWithKakao(),
              child: SizedBox(
                height: screenHeight * 0.0587,
                child: Image.asset(
                  'assets/kakao_login.png',
                ),
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: signInWithGoogle,
              child: SizedBox(
                height: screenHeight * 0.0587,
                child: Image.asset(
                  'assets/google_login.png',
                ),
              ),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () {},
              child: SizedBox(
                height: screenHeight * 0.0587,
                child: Image.asset(
                  'assets/apple_login.png',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '아직 클랭 회원이 아니신가요?',
              style: TextStyle(color: Color.fromARGB(255, 108, 108, 108)),
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
                              color: Color.fromARGB(255, 108, 108, 108),
                            ),
                          ),
                        ),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            color: Color.fromARGB(255, 108, 108, 108),
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
    );
  }
}
