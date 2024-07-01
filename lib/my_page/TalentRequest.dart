// 미디어 쿼리 적용해야합니다. 재능 요청 페이지

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TalentRequest extends StatefulWidget {
  const TalentRequest({super.key});

  @override
  State<TalentRequest> createState() => _TalentRequestState();
}

class _TalentRequestState extends State<TalentRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.back),
        title: const Text('재능요청'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            // 재능 상품 목록입니다.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 170, // 추후 반응형으로 변경 필요
                  child: TextButton(
                    onPressed: () => null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      '재능',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 170, // 추후 반응형으로 변경 필요
                  child: TextButton(
                    onPressed: () => null,
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide())),
                    child:
                        const Text('상품', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '요청목록',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('네네임'),
                    trailing: Text('희망가격: 10,000'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [Text('제목')],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [Text('문의내용')],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text('수정'),
                        VerticalDivider(),
                        Text('삭제'),
                        Spacer(),
                        DropdownButton<String>(
                          items:
                              <String>['댓글1', '댓글2', '댓글3'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
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
