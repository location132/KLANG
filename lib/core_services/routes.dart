import 'package:flutter/material.dart';
import 'package:team_between_leaf/klang_mainscreen/2_membership/login_page.dart';
import 'package:team_between_leaf/klang_mainscreen/3_emailLogin/emailLogin_page.dart';
import 'package:team_between_leaf/klang_mainscreen/4_emailError/error_id_password.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/find_id_password.dart';
import 'package:team_between_leaf/join_membership/agree_page/MarketingAgreedPage.dart';
import 'package:team_between_leaf/join_membership/agree_page/PrivacyAgreedPage.dart';
import 'package:team_between_leaf/join_membership/agree_page/ServiceAgreedPage.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/2_find_id_detail.dart';
import 'package:team_between_leaf/klang_mainscreen/6_joinmembership/membership_page.dart';
import 'package:team_between_leaf/my_page/TalentRequest.dart';
import 'package:team_between_leaf/my_page/notification_settings.dart';
import 'package:team_between_leaf/klang_mainscreen/Main_page.dart';
import 'package:team_between_leaf/klang_mainscreen/1_startPage/start_page.dart';
import 'package:team_between_leaf/wishlist_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/ErrorIdPasssordPage': (context) =>
      const ErrorIdPasssordPage(), // 아이디 비밀번호 찾기 페이지
  '/LoginPage': (context) =>
      const LoginPage(), // 로그인 페이지(자체 로그인, 소셜로그인, 아이디 비밀번호 찾기, 회원가입 이동)
  '/StartPage': (context) => const StartPage(), // 최초 시작 페이지(로그인, 회원가입 이동)
  '/KlangMemberShip': (context) => const KlangMemberShip(), // 클랭 회원가입 페이지
  '/MainPage': (context) => const MainPage(), // 테스트 페이지
  '/PrivacyAgreedPage': (context) => const PrivacyAgreedPage(), // 개인정보 보기 화면
  '/MarketingAgreedPage': (context) => const MarketingAgreedPage(), // 마케팅 보기 화면
  '/ServiceAgreedPage': (context) =>
      const ServiceAgreedPage(), // 서비스 이용약관 동의 화면
  '/TalentRequestPage': (context) => const TalentRequest(), // 재능 요청 페이지
  '/WishListPage': (context) => const WishListPage(), // 위시리스트 페이지
  '/NotificationSettings': (context) =>
      const NotificationSettings(), // 알림설정 페이지
  '/EmailLogin': (context) => const EmailLogin(), // 클랭 자체 로그인
  '/FindIdPassword': (context) => const FindIdPassword(), // 아이디 비밀번호 찾기
  '/IdFindDetail': (context) => const IdFindDetail(), // 아이디 찾기 완료 페이지
};
