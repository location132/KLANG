// 임시 인증 번호 4자리 아무렇게나 누르면 아디이 보여주는 화면으로 넘어감

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class FindId extends StatefulWidget {
  const FindId({super.key});

  @override
  State<FindId> createState() => _InputErrorState();
}

class _InputErrorState extends State<FindId> {
  final TextEditingController _controller = TextEditingController();

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

  bool _isChangedButton = false;

  void sendPhoneCode(String code) {
    if (code.length == 4) {
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
    final isIdStaus = Provider.of<FindUserModel>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          '이름',
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
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.0176),
        const Text(
          '전화번호',
          style: TextStyle(
              color: Color(0xff5b5b5b),
              fontSize: 12,
              fontFamily: 'Pretendard',
              height: 1.2),
        ),
        SizedBox(height: screenHeight * 0.0059),
        SizedBox(
          height: 40,
          child: Stack(
            children: [
              TextFormField(
                inputFormatters: [maskFormatter],
                style: const TextStyle(
                  height: 1.2,
                  color: Color(0xff8e8e8e),
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  hintText: "  ‘-’구분없이 입력",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 211, 211, 211),
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffdbdbdb),
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
                ),
                keyboardType: TextInputType.phone,
              ),
              Positioned(
                right: 15,
                top: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 123, 123, 123),
                                ),
                              ),
                            ),
                            child: const Text(
                              '인증번호 전송',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 123, 123, 123),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.0176),
        const Text(
          '휴대전화 인증',
          style: TextStyle(
            color: Color(0xff5b5b5b),
            fontSize: 12,
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: screenHeight * 0.0059),
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
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffdbdbdb),
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
            ),
            onChanged: (value) {
              sendPhoneCode(value);
            },
          ),
        ),
        //----------------------------------
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
                    '확인',
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
                    isIdStaus.setFindIdStatus(true);
                  },
                  child: const Text(
                    '확인',
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
