import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class InputLogIn extends StatefulWidget {
  const InputLogIn({super.key});

  @override
  State<InputLogIn> createState() => _InputLogInState();
}

class _InputLogInState extends State<InputLogIn> {
  bool _isChange = false;
  String _email = '';
  String _password = '';
  int _failure = 0;
  final TextEditingController _emailController = TextEditingController();

  void obsChange() {
    setState(() {
      if (_password.isNotEmpty) {
        if (_isChange) {
          _isChange = false;
        } else {
          _isChange = true;
        }
      }
    });
  }

  bool isNotEmpty(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> sendSeverLogin(String email, String password) async {
    print('$_failure');
    final loginStatus = Provider.of<LoginModel>(context, listen: false);
    bool istrue = isNotEmpty(email, password);
    if (istrue) {
      bool isResult = await loginToServer(email, password);
      if (isResult) {
        loginStatus.setloginStatus(isResult);
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/MainPage');
        }
      } else {
        _failure++;
        if (_failure < 5 /* 이거 수정*/) {
          if (mounted) {
            showCustomDialog(context, _failure);
          }
        } else {
          Navigator.pushNamed(context, '/ErrorIdPasssordPage');
        }
      }
    }
  }

  void showCustomDialog(BuildContext context, int retry) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: screenWidth * 0.88,
              margin: EdgeInsets.only(bottom: screenHeight * 0.07),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Text(
                        '계정 잠금 및 보안 알림',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/error.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text('누적 실패 시 계정이 일시적으로 잠금됩니다.'),
                      const SizedBox(height: 2),
                      Text('(로그인 실패 $retry/5 )'),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 24,
                        color: Color.fromARGB(255, 168, 168, 168),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그를 닫음
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 2),
          child: Text(
            '이메일',
            style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TextFormField(
            style: const TextStyle(height: 1),
            controller: _emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (String value) {
              _email = value;
            },
          ),
        ),
        const SizedBox(height: 11),
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            '비밀번호',
            style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          height: 50,
          child: TextFormField(
            style: const TextStyle(height: 1),
            obscureText: !_isChange,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    obsChange();
                  },
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Color.fromARGB(255, 142, 142, 142),
                  )),
            ),
            onChanged: (String value) {
              _password = value;
            },
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/FindIdPassword');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // 내부 패딩 제거
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // 클릭 가능 영역 축소
                  ),
                  child: const Row(
                    children: [
                      Text(
                        '아이디 / 비밀번호 찾기',
                        style: TextStyle(
                          color: Color.fromARGB(255, 148, 148, 148),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        CupertinoIcons.forward,
                        color: Color.fromARGB(255, 148, 148, 148),
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.0352),
        SizedBox(
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                backgroundColor: const Color(0xff6185fe),
                minimumSize: const Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              sendSeverLogin(_email, _password);
            },
            child: const Text(
              '로그인',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
