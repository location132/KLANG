import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

// 회원가입 페이지 중 이메일 입력 페이지

class JoinEmail extends StatefulWidget {
  const JoinEmail({super.key});

  @override
  State<JoinEmail> createState() => _Figma2State();
}

class _Figma2State extends State<JoinEmail> {
  final FocusNode _emailFocusNode = FocusNode(); // 이메일로 이동
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();

  bool isEmailValid = false;
  String emailValidationMessage = '';

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        if (_emailFieldKey.currentState?.validate() ?? false) {
          _checkEmail();
        }
      }
    });
  }

  //----------- dio 연결 --
  String changeText = '이메일 중복검사하기'; // 다음화면으로 넘어가는 버튼

  void _checkEmail() async {
    var emailModel = Provider.of<memberUserModel>(context, listen: false);
    String email = emailModel.email;

    if (!emailRegExp.hasMatch(email)) {
      return;
    }
    try {
      bool isAvailable = await checkEmailAvailability(email);
      setState(() {
        if (!isAvailable) {
          emailValidationMessage = '이미 존재하는 이메일입니다.';
          isEmailValid = false;
          changeText = '이메일 중복검사하기';
        } else {
          emailValidationMessage = '사용 가능한 이메일입니다.';
          isEmailValid = true;
          changeText = '다음 화면으로';
        }
      });
    } catch (e) {
      setState(() {
        emailValidationMessage = '네트워크 연결을 확인해주세요.';
        isEmailValid = false;
      });
    }
  }
  // 완료

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_emailFieldKey.currentState?.validate() ?? false) {
            final email = _emailFieldKey.currentState?.value;
            if (email != null) {
              _checkEmail();
            }
          }
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLogo(),
                      _buildEmailField(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      minimumSize: const Size(double.infinity, 36),
                    ),
                    onPressed: () {
                      if (changeText == '다음 화면으로') {
                        Navigator.pushNamed(context, '/JoinPassword');
                      }
                    },
                    child: Text(changeText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/Figma.png', height: 36),
    );
  }

  Widget _buildContainer(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.black,
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Form(
            child: TextFormField(
              key: _emailFieldKey,
              focusNode: _emailFocusNode,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: '이메일을 입력해주세요.'),
              onChanged: (String value) {
                var emailModel =
                    Provider.of<memberUserModel>(context, listen: false);
                emailModel.setEmail(value);
                if (value.isEmpty) {
                  setState(() {
                    emailValidationMessage = '';
                    isEmailValid = false;
                    changeText = '이메일 중복검사하기';
                  });
                  return;
                }
                if (emailRegExp.hasMatch(value)) {
                  _checkEmail();
                } else {
                  setState(() {
                    emailValidationMessage = '이메일 형식을 확인해주세요.';
                    isEmailValid = false;
                    changeText = '이메일 중복검사하기';
                  });
                }
              },
            ),
          ),
          if (emailValidationMessage.isNotEmpty)
            Text(
              emailValidationMessage,
              style: TextStyle(
                color: isEmailValid ? Colors.green : Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
