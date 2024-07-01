import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isBorder = true; // 테두리 색
  bool _issuccessPhone = false; //아이콘
  bool _messageVisible = false;

  String _errorMessage = ''; // 에러 메세지
  String _checkMessage = ''; // 에러 메세지

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_phoneFocusNode.hasFocus) {
      checkPhone(_phoneController.text);
    }
  }

  void checkPhone(String phone) async {
    String formattedPhone = phone.replaceAll(RegExp('-'), '');
    bool isRegExpCheckPhone = phoneNumberRegExp.hasMatch(formattedPhone);

    if (isRegExpCheckPhone) {
      setState(() {
        _isBorder = true; // 체크 완료
        _messageVisible = false; // 체크 완료
        _checkMessage = '*  이전에 가입한 내역이 있는지 확인하고 있습니다'; // 체크 완료
        _issuccessPhone = false; // 체크 완료
        _errorMessage = '';
      });
      var isAvailable = await checkPhoneNumberAvailability(formattedPhone);
      await Future.delayed(const Duration(seconds: 2));
      bool dioresult = isAvailable["success"];
      String message = isAvailable["message"];
      if (dioresult) {
        setState(() {
          _issuccessPhone = true;
          _messageVisible = true;
          _checkMessage = ''; // 체크 완료
        });
      } else {
        setState(() {
          _isBorder = false; // 체크 완료
          _messageVisible = true; //체크 완료
          _errorMessage = message; //체크 완료
          _issuccessPhone = false; //체크 완료
        });
      }
    } else {
      setState(() {
        _isBorder = false; // 체크 완료
        _messageVisible = true; // 체크 완료
        _issuccessPhone = false; // 체크 완료
        _errorMessage = '*  올바른 전화번호 형식이 아닙니다.'; // 체크 완료
      });
    }

    if (phone.isEmpty) {
      _isBorder = false; // 체크 완료
      _messageVisible = true; // 체크 완료
      _issuccessPhone = false; // 체크 완료
      _errorMessage = '*  휴대전화 번호를 입력해주세요'; // 체크 완료
    }
  }

  @override
  void dispose() {
    _phoneFocusNode.removeListener(_onFocusChange);
    _phoneController.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
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
            '휴대전화',
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
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              inputFormatters: [maskFormatter],
              decoration: InputDecoration(
                hintText: "‘-’ 구분없이 입력",
                hintStyle: const TextStyle(
                  color: Color(0xffdbdbdb),
                  fontSize: 11,
                  fontFamily: 'PretendardSemiBold',
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
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
                suffixIcon: _issuccessPhone
                    ? const Icon(
                        Icons.check,
                        color: Color(0xff33d03a),
                      )
                    : const SizedBox(),
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
                  _messageVisible
                      ? Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                          ),
                        )
                      : Text(
                          _checkMessage,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  '인증번호',
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
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: '아직 활성화 안함',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 11,
                        fontFamily: 'PretendardSemiBold',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 12),
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
                      suffixIcon: TextButton(
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black)),
                                  ),
                                  child: const Text(
                                    '인증번호 전송',
                                    style: TextStyle(
                                      color: Color(0xff8e8e8e),
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
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              /*Row(
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
                  */
            ],
          ),
        ],
      ),
    );
  }
}
