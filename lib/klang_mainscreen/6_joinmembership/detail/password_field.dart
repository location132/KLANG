import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _passwordController2 = TextEditingController();
  final FocusNode _passwordFocusNode2 = FocusNode();

  bool _isPasswordVerification = false; // 비밀번호 형식 검증

  String _errorMessage = ''; // 에러 메세지
  String _errorMessage2 = ''; // 에러 메세지

  bool _isBorder = true; // 테두리 색
  bool _isPasswordMatch = false; // 비밀번호 확인

  bool _isChange = false; // obs 보이기
  bool _isIcon = false;

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
        _isChange = false;
      });
    }
  }

  void _onFocusChange2() {
    if (!_passwordFocusNode2.hasFocus) {
      bothCheckPassword(_passwordController.text, _passwordController2.text);
      setState(() {
        _isChange = false;
      });
    }
  }

  //비밀번호 검증
  void checkPassword(String password, String password2) {
    bool firstCheck = password2.isEmpty;
    if (passwordRegExp.hasMatch(password)) {
      setState(() {
        _isPasswordVerification = true;
        _isBorder = true;
      });
      if (!firstCheck) {
        bothCheckPassword(password, password2);
      }
    } else {
      setState(() {
        _isPasswordVerification = false;
        _isBorder = false;
        _errorMessage = '*  영문,숫자,특수문자가 포함되어야 합니다.';
      });
    }
  }

  //비밀번호 일치 검증
  void bothCheckPassword(String password, String password2) {
    bool passwordsNotEmpty = password.isNotEmpty && password2.isNotEmpty;
    bool passwordsMatch = password == password2;

    setState(() {
      if (passwordsNotEmpty && passwordsMatch) {
        _isPasswordMatch = false;
        _isPasswordVerification = true;
        _isIcon = true;
        _errorMessage2 = '';
      } else if (passwordsNotEmpty && !passwordsMatch) {
        _isPasswordMatch = true;
        _isPasswordVerification = false;
        _isIcon = false;
        _errorMessage2 = '* 비밀번호가 서로 일치하지 않습니다.';
      } else {
        _isPasswordMatch = true;
        _isPasswordVerification = false;
        _isIcon = false;
        _errorMessage2 = '* 비밀번호를 입력해주세요.';
      }
    });
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
        _isChange = !_isChange;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '비밀번호',
            style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'PretendardSemiBold',
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !_isChange,
              obscuringCharacter: '●',
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isBorder
                        ? const Color(0xffdbdbdb)
                        : const Color(0xffff3636),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 110, 136, 246),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                suffixIcon: !_isChange
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
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Row(
                children: [
                  const Spacer(),
                  !_isPasswordVerification
                      ? Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  '비밀번호 확인',
                  style: TextStyle(
                    color: Color(0xff5b5b5b),
                    fontSize: 12,
                    fontFamily: 'PretendardSemiBold',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _passwordController2,
                    focusNode: _passwordFocusNode2,
                    obscureText: true,
                    obscuringCharacter: '●',
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: !_isPasswordMatch
                              ? const Color(0xffdbdbdb)
                              : const Color(0xffff3636),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 110, 136, 246),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      suffixIcon: _isIcon
                          ? const Icon(
                              Icons.check,
                              color: Color(0xff33d03a),
                            )
                          : const SizedBox(),
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Spacer(),
              _isPasswordMatch
                  ? Text(
                      _errorMessage2,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
