import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class PwFindDetail extends StatefulWidget {
  const PwFindDetail({super.key});

  @override
  State<PwFindDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PwFindDetail> {
  bool _isChangedButton = false;

  void isEmailVerification(String email) {
    if (email.isNotEmpty) {
      setState(() {
        _isChangedButton = true;
      });
    } else {
      setState(() {
        _isChangedButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPwdStaus = Provider.of<FindUserModel>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          '이메일',
          style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'Pretendard',
              height: 1.2),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: TextFormField(
            style: const TextStyle(
              height: 1.2,
              color: Color(0xff8e8e8e),
              fontFamily: 'Pretendard',
              fontSize: 12,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffdbdbdb),
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
            ),
            onChanged: (value) {
              isEmailVerification(value);
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '가입한 이메일로 비밀번호 재설정 링크를 보내드립니다.',
              style: TextStyle(
                color: const Color(0xff8e8e8e),
                fontSize: screenWidth * 0.025,
                fontFamily: 'PretendardSemiBold',
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          child: !_isChangedButton
              ? TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 1),
                    backgroundColor: const Color(0xffa8a8a8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
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
                    backgroundColor: const Color(0xff6185FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    isPwdStaus.setFindPwStatus(true);
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
