// 유효성 검증 관련 로직

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  caseSensitive: false,
  multiLine: false,
);

RegExp passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%#?&])[A-Za-z\d@$!%*#?&]{9,20}$',
  caseSensitive: true, // 대문자 판별 필요
  multiLine: false,
);

RegExp phoneNumberRegExp = RegExp(r'^(010|011|016|017|018|019)\d{4}\d{4}$');

final maskFormatter = MaskTextInputFormatter(
    mask: '###-####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

/*
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
*/
// 비밀번호 검증식  사용하는 부분은 lib/join_membership/join_password.dart
class Passwordverification {
  String pwField = '';
  String pwcField = '';
  String passwordValidationMessage = '';
  bool? ispasswordValid = true;

// 비밀번호와 체크가 비어있지 않고, 서로 일치할때 실행
  Map<String, dynamic> passwordmatch() {
    if (pwField != '' && pwcField != '' && pwField == pwcField) {
      return {
        "issuccess": true,
        "passwordValidationMessage": '비밀번호가 서로 일치합니다',
        "ispasswordValid": true
      };
    } else {
      return {
        "issuccess": false,
        "passwordValidationMessage": '비밀번호가 서로 일치하지 않습니다',
        "ispasswordValid": false
      };
    }
  }

  // 비밀번호 형식 검증
  Map<String, dynamic> passwordvalidator() {
    bool ismatch = passwordRegExp.hasMatch(pwField);
    if (ismatch) {
      return {
        "issuccess": true,
        "passwordValidationMessage": '비밀번호 형식이 맞습니다.',
        "ispasswordValid": ismatch,
      };
    } else {
      return {
        "issuccess": false,
        "passwordValidationMessage": '비밀번호 형식이 맞지 않습니다.\n대문자 소문자 특수기호를 포함해주세요',
        "ispasswordValid": ismatch,
      };
    }
  }
}
