import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class CSMBS extends StatefulWidget {
  const CSMBS({Key? key}) : super(key: key);

  @override
  State<CSMBS> createState() => _CustomShowModalBottomSheetState();
}

class _CustomShowModalBottomSheetState extends State<CSMBS> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottommodalHeight = screenHeight * 0.31;
    final model = Provider.of<AgreementModel>(context, listen: false);

    void issuccess() async {
      final email = Provider.of<memberUserModel>(context, listen: false).email;
      final password =
          Provider.of<memberUserModel>(context, listen: false).password;
      final passwordCheck =
          Provider.of<memberUserModel>(context, listen: false).passwordCheck;
      final phoneNumber =
          Provider.of<memberUserModel>(context, listen: false).phoneNumber;
      bool result =
          await sendDataToServer(email, password, phoneNumber, passwordCheck);
      if (result) {
        bool loginresult = await loginToServer(email, password);
        if (loginresult) {
          Navigator.pushNamed(context, '/MainPage');
          Provider.of<memberUserModel>(context, listen: false).clear();
          Provider.of<LoginModel>(context, listen: false)
              .setloginStatus(loginresult);
        } else {
          print('회원가입 후 로그인 실패');
        }
      } else {
        print('회원가입 실패');
      }
    }

    return Container(
      height: bottommodalHeight,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: model.serviceAgreed &&
                    model.privacyAgreed &&
                    model.marketingAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    model.agreeToAll(value ?? false);
                  });
                },
              ),
              const Text('전체 동의하기', style: TextStyle(fontSize: 16)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 8),
            child: Row(
              children: [
                Checkbox(
                  value: model.serviceAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      model.toggleServiceAgreement();
                    });
                  },
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                ),
                const Text('서비스 이용약관 동의 (필수)',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const Spacer(),
                TextButton(
                  onPressed: null,
                  child: Text(
                    '보기 >',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    visualDensity:
                        VisualDensity(horizontal: -4.0, vertical: -4.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: Row(
              children: [
                Checkbox(
                  value: model.privacyAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      model.togglePrivacyAgreement();
                    });
                  },
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                ),
                const Text('개인정보 취급방침 동의 (필수)',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const Spacer(),
                TextButton(
                  onPressed: null,
                  child: Text(
                    '보기 >',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    visualDensity:
                        VisualDensity(horizontal: -4.0, vertical: -4.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 9),
            child: Row(
              children: [
                Checkbox(
                  value: model.marketingAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      model.toggleMarketingAgreement();
                    });
                  },
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                ),
                const Text('마케팅 정보 수신 동의 (선택)',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const Spacer(),
                TextButton(
                  onPressed: null,
                  child: Text(
                    '보기 >',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    visualDensity:
                        VisualDensity(horizontal: -4.0, vertical: -4.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                  minimumSize: Size(double.infinity, 32),
                ),
                onPressed: () {
                  if (model.serviceAgreed && model.privacyAgreed == true) {
                    issuccess();
                  } else if (model.serviceAgreed &&
                      model.privacyAgreed &&
                      model.marketingAgreed == true) {
                    issuccess();
                  } else {}
                },
                child: const Text('잎사이 시작하기',
                    style: TextStyle(fontSize: 22, color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
