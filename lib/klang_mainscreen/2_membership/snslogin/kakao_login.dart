import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class KakaoLogin extends StatefulWidget {
  const KakaoLogin({super.key});

  @override
  State<KakaoLogin> createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  void signInWithKakao() async {
    OAuthToken token;
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        String accessToken = token.accessToken;
        bool result = await SNSLoginToServer(accessToken, 'KAKAO');
        if (result) {
          Provider.of<LoginModel>(context, listen: false)
              .setloginStatus(result);
          Navigator.pushNamed(context, '/MainPage');
        }
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          String accessToken = token.accessToken;
          bool result = await SNSLoginToServer(accessToken, 'KAKAO');
          if (result) {
            Provider.of<LoginModel>(context, listen: false)
                .setloginStatus(result);
            Navigator.pushNamed(context, '/MainPage');
          }
        } catch (error) {}
      }
    } else {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        String accessToken = token.accessToken;
        bool result = await SNSLoginToServer(accessToken, 'KAKAO');
        if (result) {
          Provider.of<LoginModel>(context, listen: false)
              .setloginStatus(result);
          Navigator.pushNamed(context, '/MainPage');
        }
      } catch (error) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // 패딩을 0으로 설정
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 크기를 내용에 맞춤
      ),
      onPressed: signInWithKakao,
      child: Image.asset('assets/kakaoLogin.png'),
    );
  }
}
