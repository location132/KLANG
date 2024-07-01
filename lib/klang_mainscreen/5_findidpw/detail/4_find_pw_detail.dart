import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class FindPw1 extends StatefulWidget {
  const FindPw1({super.key});

  @override
  State<FindPw1> createState() => _FindPw1State();
}

class _FindPw1State extends State<FindPw1> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _passwordController2 = TextEditingController();
  final FocusNode _passwordFocusNode2 = FocusNode();

  // 새로 만들기
  bool _isObsButton = false;
  bool _isBorderDefaultColor = true;
  bool _isBorderDefaultColor2 = true;
  bool _isIcon = false;

  String _passwordError = '';
  String _confirmationError = '';
  bool _isPasswordValid = false;
  bool _doPasswordsMatch = false;
  bool _checkButton = false;
  //----------

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(_onFocusChange);
    _passwordFocusNode2.addListener(_onFocusChange2);
  }

  void _onFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      checkPassword(_passwordController.text, _passwordController2.text);
      setState(() {
        _isObsButton = false;
      });
    }
  }

  void _onFocusChange2() {
    if (!_passwordFocusNode2.hasFocus) {
      bothCheckPassword(_passwordController.text, _passwordController2.text);
    }
  }

  //비밀번호 검증
  void checkPassword(String password, String password2) {
    bool firstCheck = password2.isEmpty;
    if (passwordRegExp.hasMatch(password)) {
      setState(() {
        _isPasswordValid = true;
        _isBorderDefaultColor = true;
      });
      if (!firstCheck) {
        bothCheckPassword(password, password2);
      }
    } else {
      setState(() {
        _isPasswordValid = false;
        _isBorderDefaultColor = false;
        _passwordError = '* 대소문자,숫자,특수문자를 사용해 9~20자로 구성해주세요';
      });
    }
  }

  //비밀번호 일치 검증
  bool bothCheckPassword(String password, String password2) {
    bool passwordsNotEmpty = password.isNotEmpty && password2.isNotEmpty;
    bool passwordsMatch = password == password2;

    if (passwordsNotEmpty && passwordsMatch) {
      setState(() {
        _doPasswordsMatch = true;
        _isBorderDefaultColor2 = true;
        _isIcon = true;
        _checkButton = true;
      });
      return true;
    } else if (passwordsNotEmpty && !passwordsMatch) {
      setState(() {
        _doPasswordsMatch = false;
        _isBorderDefaultColor2 = false;
        _isIcon = false;
        _checkButton = false;
        _confirmationError = '* 비밀번호가 서로 일치하지 않습니다.';
      });
      return false;
    } else {
      setState(() {
        _doPasswordsMatch = false;
        _isBorderDefaultColor2 = false;
        _isIcon = false;
        _checkButton = false;
        _confirmationError = '* 비밀번호를 입력해주세요.';
      });
      return false;
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode2.removeListener(_onFocusChange2);

    _passwordFocusNode.dispose();
    _passwordFocusNode2.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();

    super.dispose();
  }

  // obs 활성화
  void _obsChange() {
    if (_passwordController.text.isNotEmpty) {
      setState(() {
        _isObsButton = !_isObsButton;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          '새 비밀번호',
          style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'Pretendard',
              height: 1.2),
        ),
        SizedBox(height: screenHeight * 0.0059),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            style: const TextStyle(
              color: Color(0xff393939),
              fontSize: 12,
              fontFamily: 'Pretendard',
            ),
            obscureText: !_isObsButton,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _isBorderDefaultColor
                      ? const Color(0xffdbdbdb)
                      : const Color(0xffff3636),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: !_isObsButton
                  ? IconButton(
                      onPressed: () {
                        _obsChange();
                      },
                      icon: const Icon(
                        Icons.visibility_off_outlined,
                        color: Color.fromARGB(255, 142, 142, 142),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        _obsChange();
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color.fromARGB(255, 142, 142, 142),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Stack(
          children: [
            Row(
              children: [
                const Spacer(),
                !_isPasswordValid
                    ? Text(
                        _passwordError,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10,
                          fontFamily: 'PretendardSemiBold',
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: screenHeight * 0.0176),
            const Text(
              '비밀번호 재확인',
              style: TextStyle(
                  color: Color(0xff5b5b5b),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  height: 1.2),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.0059),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _passwordController2,
            focusNode: _passwordFocusNode2,
            enabled: _isPasswordValid,
            style: const TextStyle(
              color: Color(0xff393939),
              fontSize: 12,
              fontFamily: 'Pretendard',
            ),
            obscureText: true,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isBorderDefaultColor2
                      ? const Color(0xffdbdbdb)
                      : const Color(0xffff3636),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: _isIcon
                  ? const Icon(
                      Icons.check,
                      color: Color(0xff33d03a),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Spacer(),
            !_doPasswordsMatch
                ? Text(
                    _confirmationError,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 10,
                      fontFamily: 'PretendardSemiBold',
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          child: !_checkButton
              ? TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 1),
                    backgroundColor: const Color(0xffa8a8a8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    checkPassword(
                        _passwordController.text, _passwordController2.text);
                    bothCheckPassword(
                        _passwordController.text, _passwordController2.text);
                    if (_isPasswordValid && _doPasswordsMatch) {
                      print('비밀번호 재설정 로직을 실행합니다.');
                    } else {
                      print('비밀번호 검증 실패');
                    }
                  },
                  child: const Text(
                    '비밀번호 재설정하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 1),
                    backgroundColor: const Color(0xff6185fe),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    checkPassword(
                        _passwordController.text, _passwordController2.text);
                    bothCheckPassword(
                        _passwordController.text, _passwordController2.text);

                    if (_isPasswordValid && _doPasswordsMatch) {
                      print('비밀번호 재설정 로직을 실행합니다.');
                    } else {
                      print('비밀번호 검증 실패');
                    }
                  },
                  child: const Text(
                    '비밀번호 재설정하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
        SizedBox(height: screenHeight * 0.1502),
      ],
    );
  }
}
