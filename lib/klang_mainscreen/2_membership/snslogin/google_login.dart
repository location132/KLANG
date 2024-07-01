import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      String accessToken = googleAuth.accessToken!;
      bool result = await SNSLoginToServer(accessToken, 'GOOGLE');
      if (result) {
        Provider.of<LoginModel>(context, listen: false).setloginStatus(result);
        Navigator.pushNamed(context, '/MainPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // 패딩을 0으로 설정
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 크기를 내용에 맞춤
      ),
      onPressed: signInWithGoogle,
      child: Image.asset('assets/GoogolLogin.png'),
    );
  }
}
