import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginCode extends StatefulWidget {
  final Function(bool) onCodeEntered;

  const LoginCode({super.key, required this.onCodeEntered});

  @override
  State<LoginCode> createState() => _LoginCodeState();
}

class _LoginCodeState extends State<LoginCode> {
  final TextEditingController _controller = TextEditingController();
  // 테스트용으로 인증번호 만든거에요 수정 필요
  bool _isInPutCode = false;
  String _test = '1234';
// =======================

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text;
      if (text.length > 4) {
        _controller.text = text.substring(0, 4);
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendPhoneCode(String code) {
    if (code.length == 4) {
      bool result = code == _test;
      widget.onCodeEntered(result);
      setState(() {
        _isInPutCode = !result; // 코드가 일치하지 않을 때만 경고 메시지 활성화
      });
    } else {
      widget.onCodeEntered(false);
      setState(() {
        _isInPutCode = false; // 코드 길이가 4가 아닐 때 경고 메시지 비활성화
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.015),
        const Text(
          '휴대전화 인증',
          style: TextStyle(
            color: Color(0xff5b5b5b),
            fontSize: 12,
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            style: const TextStyle(
              height: 1.2,
              color: Color(0xff8e8e8e),
              fontFamily: 'Pretendard',
              fontSize: 12,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              enabledBorder: !_isInPutCode
                  ? OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffdbdbdb),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    )
                  : OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffff3636),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
              focusedBorder: !_isInPutCode
                  ? OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 110, 136, 246),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    )
                  : OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffff3636),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
            ),
            onChanged: (value) {
              sendPhoneCode(value);
            },
          ),
        ),
        Row(
          children: [
            const Spacer(),
            !_isInPutCode
                ? const SizedBox()
                : const Text(
                    '*  인증번호가 일치하지 않습니다.',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 10,
                      fontFamily: 'Pretendard',
                    ),
                  )
          ],
        )
      ],
    );
  }
}
