// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_between_leaf/core_services/provider.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/1_find_id.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/4_find_pw_detail.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/2_find_id_detail.dart';
import 'package:team_between_leaf/klang_mainscreen/5_findidpw/detail/3_find_pw.dart';

class FindIdPwDetail extends StatefulWidget {
  const FindIdPwDetail({super.key});

  @override
  State<FindIdPwDetail> createState() => _FindIdPwDetailState();
}

class _FindIdPwDetailState extends State<FindIdPwDetail> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isidStaus = Provider.of<FindUserModel>(context);
    bool isNextId = isidStaus.findIdStatus;
    bool isNextPw = isidStaus.findPwStatue;

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.035, right: screenWidth * 0.035),
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: '아이디 찾기'),
                Tab(text: '비밀번호 찾기'),
              ],
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 110, 136, 246),
                  width: 3, // 인디케이터의 두께
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(
                color: Color(0xff5b5b5b),
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                color: Color(0xffdbdbdb),
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w100,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.0387),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              !isNextId ? const FindId() : const IdFindDetail(),
                        ),
                      ),
                    ],
                  ),
                  //--------------------------
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.0387),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              isNextPw ? const FindPw1() : const PwFindDetail(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
