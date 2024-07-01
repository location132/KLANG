import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class testMainPage extends StatefulWidget {
  const testMainPage({super.key});

  @override
  State<testMainPage> createState() => _testMainPage();
}

class _testMainPage extends State<testMainPage> {
  void logoutButton() async {
    final loginProvider = Provider.of<LoginModel>(context, listen: false);
    bool loginState = loginProvider.loginStatus;

    if (loginState) {
      bool issuccess = await logout();
      if (issuccess) {
        loginProvider.setloginStatus(false);
      }
    } else {
      print('현재 로그인 상태가 아니야');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text("MainPage, \n테스트 필요한 페이지 아래 버튼에 추가해서 라우터 연결하고 테스트하시면 됩니다"),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/WishListPage");
          },
          child: const Text("WishListPage"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/TalentRequestPage");
          },
          child: const Text("TalentRequestPage"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/NotificationSettings");
          },
          child: const Text("NotificationSettings"),
        ),
        ElevatedButton(
          onPressed: () {
            logoutButton();
          },
          child: const Text('로그아웃 버튼'),
        ),
        ElevatedButton(
          onPressed: () {
            sendrefreshToken();
          },
          child: const Text('토큰 재발급 버튼'),
        ),
      ],
    );
  }
}
