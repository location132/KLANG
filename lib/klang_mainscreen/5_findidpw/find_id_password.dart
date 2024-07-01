import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/0_defaultTabController.dart';
import 'package:team_between_leaf/klang_mainscreen/0_coreScreen/logo_screen.dart';
import 'package:team_between_leaf/core_services/provider.dart';

class FindIdPassword extends StatefulWidget {
  const FindIdPassword({super.key});

  @override
  State<FindIdPassword> createState() => _FindIdPasswordState();
}

class _FindIdPasswordState extends State<FindIdPassword> {
  @override
  Widget build(BuildContext context) {
    final isidStaus = Provider.of<FindUserModel>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  child: IconButton(
                    onPressed: () {
                      isidStaus.setFindIdStatus(false);
                      isidStaus.setFindPwStatus(false);
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(CupertinoIcons.back, size: 32),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.12),
                      const LogoImage(),
                      SizedBox(height: screenHeight * 0.0446),
                      const Expanded(
                        child: FindIdPwDetail(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
