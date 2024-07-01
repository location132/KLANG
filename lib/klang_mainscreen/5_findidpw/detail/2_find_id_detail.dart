import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdFindDetail extends StatefulWidget {
  const IdFindDetail({super.key});

  @override
  State<IdFindDetail> createState() => _IdFindDetailState();
}

class _IdFindDetailState extends State<IdFindDetail> {
  String _userID = 'test1234@naver.com';
  late final TextEditingController _controller;

  bool justLookWithYourEyes = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _userID);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const SizedBox(height: 15),
        const Text(
          '회원님의 가입 아이디는',
          style: TextStyle(
            color: Color(0xff8e8e8e),
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: screenHeight * 0.047,
          child: Stack(
            children: [
              TextFormField(
                style: const TextStyle(
                  color: Color(0xff5b5b5b),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                ),
                controller: _controller,
                enabled: !justLookWithYourEyes,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      copyToClipboard(_controller.text);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xff777777),
                                )),
                              ),
                              child: const Text(
                                '복사하기',
                                style: TextStyle(
                                  color: Color(0xff777777),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff6185FE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              Navigator.pushNamed(context, '/EmailLogin');
            },
            child: const Text(
              '로그인 하러가기',
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
