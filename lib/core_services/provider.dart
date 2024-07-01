import 'package:flutter/material.dart';

// Provider (함채현)
class UserModel with ChangeNotifier {
  int _userId = 0;

  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }
}

//Provider (이정원)
class FindUserModel with ChangeNotifier {
  bool _findIdStatus = false; // 아이디 찾기 완료
  bool _findPwStatue = false; // 비밀번호 찾기 완료

  bool get findIdStatus => _findIdStatus;
  bool get findPwStatue => _findPwStatue;

  void setFindIdStatus(bool idStatus) {
    _findIdStatus = idStatus;
    notifyListeners();
  }

  void setFindPwStatus(bool pwStatus) {
    _findPwStatue = pwStatus;
    notifyListeners();
  }
}

// 로그인 모델
class LoginModel with ChangeNotifier {
  bool _loginStatus = false; // 로그인 모델

  bool get loginStatus => _loginStatus;

  void setloginStatus(bool loginStatus) {
    _loginStatus = loginStatus;
    notifyListeners();
  }
}

// 회원가입 모델
class memberUserModel with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _passwordCheck = '';
  String _phoneNumber = '';

  // Getter
  String get email => _email;
  String get password => _password;
  String get passwordCheck => _passwordCheck;
  String get phoneNumber => _phoneNumber;

  // Setter
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPasswordCheck(String passwordCheck) {
    _passwordCheck = passwordCheck;

    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber.replaceAll('-', '');

    notifyListeners();
  }

  // 초기화 함수 - 회원가입이나 로그인 처리 후 호출할 수 있음
  void clear() {
    _email = '';
    _password = '';
    _passwordCheck = '';
    _phoneNumber = '';
    notifyListeners();
  }
}

class AgreementModel with ChangeNotifier {
  bool _serviceAgreed = false; // 서비스 이용약관 동의
  bool _privacyAgreed = false; // 개인정보 취급방침 동의
  bool _marketingAgreed = false; // 마케팅 정보 수신 동의

  bool get serviceAgreed => _serviceAgreed;
  bool get privacyAgreed => _privacyAgreed;
  bool get marketingAgreed => _marketingAgreed;

  void toggleServiceAgreement() {
    _serviceAgreed = !_serviceAgreed;
    notifyListeners();
  }

  void togglePrivacyAgreement() {
    _privacyAgreed = !_privacyAgreed;
    notifyListeners();
  }

  void toggleMarketingAgreement() {
    _marketingAgreed = !_marketingAgreed;
    notifyListeners();
  }

  // 전체 동의 처리
  void agreeToAll(bool isAgreed) {
    _serviceAgreed = isAgreed;
    _privacyAgreed = isAgreed;
    _marketingAgreed = isAgreed;
    notifyListeners();
  }
}

// 검색 상태관리 모델
class SearchProvider extends ChangeNotifier {
  bool _isMainScreenVisible = true; // 메인화면
  bool _isRecentLiveSearchVisible = false; // 최근+ 실시간 검색어
  bool _isRelatedSearchVisible = false; // 연관 검색어
  String _isUserSearchValue = ''; // 사용자 입력 값
  List<String> _previousValue = []; // 이전 연관기록 저장

  bool get isMainScreenVisible => _isMainScreenVisible;
  bool get isRecentLiveSearchVisible => _isRecentLiveSearchVisible;
  bool get isRelatedSearchVisible => _isRelatedSearchVisible;
  String get isUserSearchValue => _isUserSearchValue;
  List<String> get previousValue => _previousValue;

  // 메인화면으로 전환
  void showChangeScreen(
    bool isMainScreenVisible,
    bool isRecentSearchVisible,
    bool isRelatedSearchVisible,
  ) {
    _isMainScreenVisible = isMainScreenVisible;
    _isRecentLiveSearchVisible = isRecentSearchVisible;
    _isRelatedSearchVisible = isRelatedSearchVisible;

    notifyListeners();
  }

// 사용자 겁색 기록 저장
  void userSearhValue(String isUserSearchValue) {
    _isUserSearchValue = isUserSearchValue;
    notifyListeners();
  }

  void previousValueHistory(
    List<String> issevervaildate,
  ) {
    _previousValue = issevervaildate;
  }
}
