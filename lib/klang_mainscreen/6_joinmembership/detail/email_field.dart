import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_between_leaf/core_services/authentication_dio.dart';
import 'package:team_between_leaf/core_services/verify_form.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  String _errorMessage = '';
  bool _isEmailVerification = false; // 이메일 형식 검증
  bool _emailResert = false;
  bool _isBorder = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_emailFocusNode.hasFocus) {
      checkEmail(_emailController.text);
    }
  }

  void checkEmail(String email) async {
    if (emailRegExp.hasMatch(email)) {
      setState(() {
        _isEmailVerification = true;
        _emailResert = false;
        _isBorder = false;
      });
      bool isAvailable = await checkEmailAvailability(email);
      if (!isAvailable) {
        setState(() {
          _isEmailVerification = false;
          _emailResert = false;
          _isBorder = false;
          _errorMessage = '*  이미 사용중인 이메일입니다.';
        });
      } else {
        setState(() {
          _emailResert = true;
          _isBorder = true;
        });
      }
    } else {
      setState(() {
        _isEmailVerification = false;
        _emailResert = false;
        _isBorder = false;

        _errorMessage = '*  올바른 이메일 형식이 아닙니다.';
      });
    }
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.dispose();
    _emailController.dispose();
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
            '이메일',
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
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
                suffixIcon: _emailResert
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
          Row(
            children: [
              const Spacer(),
              !_isEmailVerification
                  ? Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
