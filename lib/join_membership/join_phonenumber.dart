import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';
import 'package:team_between_leaf/join_membership/agree_page/AgreePageModal.dart';

// 회원가입 페이지 중 전화번호 인증 페이지

class JoinPhonenumber extends StatefulWidget {
  const JoinPhonenumber({super.key});

  @override
  State<JoinPhonenumber> createState() => _JoinPhonenumberState();
}

class _JoinPhonenumberState extends State<JoinPhonenumber> {
  String phoneValidationMessage = '';
  String phone = '';
  bool isphoneValid = true;

  //전화번호 형식 검사 코드
  void checkPhone() async {
    String value =
        Provider.of<memberUserModel>(context, listen: false).phoneNumber;
    var result = phoneNumberRegExp.hasMatch(value);
    if (result) {
      setState(() {
        phoneValidationMessage = '이전에 가입한 내역이 있는지 확인해볼게요';
        isphoneValid = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      var istrue = await checkPhoneNumberAvailability(value);
      bool dioresult = istrue["success"];
      String message = istrue["message"];
      if (dioresult) {
        setState(() {
          phoneValidationMessage = '만나서 반가워요\n 전화번호인증을 부탁드릴게요!';
          isphoneValid = true;
        });
      } else {
        setState(() {
          phoneValidationMessage = message;
          isphoneValid = false;
        });
      }
    } else if (value.length == 11) {
      phoneValidationMessage = '전화번호 형식이 일치하지 않아요!';
      isphoneValid = true;
    } else {
      phoneValidationMessage = '클랭에 오신걸 환영해요!';
      isphoneValid = true;
    }
  }

  Widget _phoneNumberField() {
    final phonemodel = Provider.of<memberUserModel>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: TextFormField(
            textAlign: TextAlign.center,
            inputFormatters: [maskFormatter],
            decoration: InputDecoration(
              prefixText: '+82',
              hintText: "핸드폰 번호",
              suffixIcon: TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                ),
                child: const Text('인증번호 전송',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
                onPressed: () {},
              ),
              hintStyle: const TextStyle(fontSize: 14),
              prefixStyle: const TextStyle(color: Colors.black),
            ),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                phonemodel.setPhoneNumber(value); //상태관리 저장
                checkPhone();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(),
          child: Text(
            textAlign: TextAlign.center,
            phoneValidationMessage,
            style: TextStyle(
              color: isphoneValid ? Colors.green : Colors.red,
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
                      const SizedBox(height: 10),
                      const Text('Logo', style: TextStyle(fontSize: 42)),
                      const Text('잎사이에 오신 것을 환영합니다!',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 34),
                      _buildContainer(containerHeight),
                      const SizedBox(height: 10),
                      _phoneNumberField(),
                      const SizedBox(height: 10),
                      _certificationNumber(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 46),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      minimumSize: const Size(double.infinity, 36),
                    ),
                    onPressed: () {
                      if (phoneValidationMessage ==
                          '만나서 반가워요\n 전화번호인증을 부탁드릴게요!') {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext) {
                            return const CSMBS();
                          },
                        );
                      }
                    },
                    child: const Text('시작하기'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certificationNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
            hintText: "인증번호 입력", hintStyle: TextStyle(fontSize: 14)),
        keyboardType: TextInputType.number,
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
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.black,
    );
  }
}
