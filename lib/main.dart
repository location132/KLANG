import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/klang_mainscreen/1_startPage/start_page.dart';
import 'package:team_between_leaf/core_services/routes.dart';
import 'package:team_between_leaf/klang_mainscreen/Main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: '.env');

  bool jailbroken = await FlutterJailbreakDetection.jailbroken;
  //bool developerMode = await FlutterJailbreakDetection.developerMode;
  if (jailbroken /*|| developerMode   개발자 모드 일때 튕기기*/) {
    exit(0);
  }
  // runApp() 호출 전 Flutter SDK 초기화 from kakao
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_APP_KEY']!);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => memberUserModel()), // 회원가입, 가입 후 자동로그인 모델
        ChangeNotifierProvider(
            create: (context) => AgreementModel()), // 회원가입 동의 모델
        ChangeNotifierProvider(create: (context) => UserModel()), // 위시리스트 모델
        ChangeNotifierProvider(create: (context) => LoginModel()), // 자동 로그인 모델
        ChangeNotifierProvider(create: (context) => SearchProvider()), // 검색어 모델
        ChangeNotifierProvider(
            create: (context) => FindUserModel()), // 아이디 비밀번호 찾기 모델
      ],
      child: const MyApp(), // 앱이 자식으로 변경
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  LoginModel loginModel = LoginModel();

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    bool result = await checkAndSetLoginStatus();
    if (result && mounted) {
      Provider.of<LoginModel>(context, listen: false).setloginStatus(result);
      navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // 여기에 추가
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      routes: appRoutes,
    );
  }
}
