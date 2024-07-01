import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

// 회원가입 페이지 중 비밀번호 입력 페이지

class JoinPassword extends StatefulWidget {
  const JoinPassword({super.key});

  @override
  State<JoinPassword> createState() => _JoinPasswordState();
}

class _JoinPasswordState extends State<JoinPassword> {
  Passwordverification passwordverification = Passwordverification();
  String passwordValidationMessage = '대문자 소문자 특수기호를 포함해주세요';
  String passwordCheckValidationMessage = '';
  bool ispasswordValid = true;
  bool ispasswordCheckValid = true;
  //--------------------

  // 비밀번호 형식 검증
  void pwdCheck() {
    var result = passwordverification.passwordvalidator();
    passwordValidationMessage = result["passwordValidationMessage"];
    ispasswordValid = result["ispasswordValid"];
  }

  // 비밀번호 일치 검증
  void pwdcCheck() {
    var result = passwordverification.passwordmatch();
    passwordCheckValidationMessage = result["passwordValidationMessage"];
    ispasswordCheckValid = result["ispasswordValid"];
  }

// 다음화면으로 넘어가기 위한 최종 검증
  bool finalCheck() {
    var firstvalidata = passwordverification.passwordvalidator();
    var secondvalidatga = passwordverification.passwordmatch();
    bool firstCheck = firstvalidata["issuccess"];
    bool secondCheck = secondvalidatga["issuccess"];

    if (firstCheck == true && secondCheck == true) {
      return true;
    } else {
      return false;
    }
  }

// 위젯-----------------------
  Widget _passwordField() {
    final passwordModel = Provider.of<memberUserModel>(context, listen: false);
    // 비밀번호 입력 필드 위젯 구현
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: '비밀번호를 입력해주세요.'),
            onChanged: (value) {
              setState(() {
                passwordModel.setPassword(value);
                passwordverification.pwField = value; // 위에 만든 클래스에 집어넣기
                if (passwordverification.pwField == '') {
                  passwordCheckValidationMessage = '';
                  passwordValidationMessage = '대문자 소문자 특수기호를 포함해주세요';
                  ispasswordValid = true;
                } else if (passwordverification.pwcField == '') {
                  pwdCheck();
                } else if (passwordverification.pwcField != '') {
                  pwdcCheck();
                } else {
                  pwdcCheck();
                }
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            textAlign: TextAlign.center,
            passwordValidationMessage,
            style: TextStyle(
              color: ispasswordValid ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordCheckField() {
    final passwordCheckModer =
        Provider.of<memberUserModel>(context, listen: false);
    // 비밀번호 확인 입력 필드 위젯 구현
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: '비밀번호 확인'),
            onChanged: (value) {
              setState(() {
                passwordCheckModer.setPasswordCheck(value);
                passwordverification.pwcField = value;
                if (passwordverification.pwcField == '') {
                  passwordCheckValidationMessage = '';
                }
                if (passwordverification.pwField == '') {
                  passwordCheckValidationMessage = '비밀번호가 입력되지 않았어요!';
                  ispasswordCheckValid = false;
                } else {
                  pwdcCheck();
                }
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            passwordCheckValidationMessage,
            style: TextStyle(
              color: ispasswordCheckValid ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.339;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLogo(),
                      const Text('Logo', style: TextStyle(fontSize: 42)),
                      const Text('잎사이에 오신 것을 환영합니다!',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 34),
                      _buildContainer(containerHeight),
                      const SizedBox(height: 10),
                      _passwordField(),
                      const SizedBox(height: 10),
                      _passwordCheckField(),
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
                      bool nextPage = finalCheck();
                      if (nextPage) {
                        Navigator.pushNamed(context, '/JoinPhonenumber');
                      }
                    },
                    child: const Text('다음 화면으로'),
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
    // 로고 위젯 구현
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/Figma.png', height: 36),
    );
  }

  Widget _buildContainer(double height) {
    // 배경 컨테이너 위젯 구현
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.black,
    );
  }
}
